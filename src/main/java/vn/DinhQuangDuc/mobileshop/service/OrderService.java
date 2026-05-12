package vn.DinhQuangDuc.mobileshop.service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CreationHelper;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jakarta.servlet.http.HttpServletResponse;
import vn.DinhQuangDuc.mobileshop.domain.Order;
import vn.DinhQuangDuc.mobileshop.domain.OrderDetail;
import vn.DinhQuangDuc.mobileshop.domain.Product;
import vn.DinhQuangDuc.mobileshop.domain.User;
import vn.DinhQuangDuc.mobileshop.dto.OrderSearchDTO;
import vn.DinhQuangDuc.mobileshop.repository.OrderDetailRepository;
import vn.DinhQuangDuc.mobileshop.repository.OrderRepository;
import vn.DinhQuangDuc.mobileshop.repository.ProductRepository;

@Service
public class OrderService {
    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;
    private final ProductRepository productRepository;

    public OrderService(OrderRepository orderRepository, OrderDetailRepository orderDetailRepository,
            ProductRepository productRepository) {
        this.orderRepository = orderRepository;
        this.orderDetailRepository = orderDetailRepository;
        this.productRepository = productRepository;
    }

    // Lấy tất cả đơn hàng cho trang Admin
    public List<Order> fetchAllOrders() {
        return this.orderRepository.findAll();
    }

    // Lấy chi tiết một đơn hàng theo ID
    public Optional<Order> fetchOrderById(long id) {
        return this.orderRepository.findById(id);
    }

    @Transactional
    public void updateOrder(Order order) {
        Optional<Order> orderOptional = this.fetchOrderById(order.getId());
        if (orderOptional.isPresent()) {
            Order currentOrder = orderOptional.get();
            String oldStatus = currentOrder.getStatus() == null ? "" : currentOrder.getStatus();
            String newStatus = order.getStatus() == null ? "" : order.getStatus();

            if (oldStatus.equals(newStatus)) {
                return;
            }

            // 1. XỬ LÝ TỒN KHO VÀ LƯỢT BÁN (Giữ nguyên code chuẩn của bạn)
            List<OrderDetail> details = currentOrder.getOrderDetails();
            for (OrderDetail cd : details) {
                Product product = cd.getProduct();
                long qty = cd.getQuantity();

                if (!oldStatus.equals("CANCELLED") && newStatus.equals("CANCELLED")) {
                    product.setQuantity(product.getQuantity() + qty);
                    if (oldStatus.equals("DELIVERED")) {
                        product.setSold(product.getSold() - qty);
                    }
                } else if (!oldStatus.equals("DELIVERED") && newStatus.equals("DELIVERED")) {
                    product.setSold(product.getSold() + qty);
                    if (oldStatus.equals("CANCELLED")) {
                        if (product.getQuantity() < qty) {
                            throw new RuntimeException(
                                    "Lỗi: Sản phẩm [" + product.getName() + "] không đủ tồn kho để giao!");
                        }
                        product.setQuantity(product.getQuantity() - qty);
                    }
                } else if (oldStatus.equals("CANCELLED") && !newStatus.equals("CANCELLED")
                        && !newStatus.equals("DELIVERED")) {
                    if (product.getQuantity() < qty) {
                        throw new RuntimeException(
                                "Lỗi: Sản phẩm [" + product.getName() + "] không đủ tồn kho để khôi phục đơn hàng!");
                    }
                    product.setQuantity(product.getQuantity() - qty);
                } else if (oldStatus.equals("DELIVERED") && !newStatus.equals("DELIVERED")
                        && !newStatus.equals("CANCELLED")) {
                    product.setSold(product.getSold() - qty);
                }
                this.productRepository.save(product);
            }

            // 2. XỬ LÝ CẬP NHẬT THỜI GIAN REALTIME THEO TRẠNG THÁI
            LocalDateTime now = LocalDateTime.now();
            if ("SHIPPING".equals(newStatus)) {
                currentOrder.setShippingDate(now);
                currentOrder.setExpectedDeliveryDate(now.plusDays(3));
            } else if ("DELIVERED".equals(newStatus) || "SUCCESS".equals(newStatus)) {
                currentOrder.setDeliveredDate(now);
            } else if ("CANCELLED".equals(newStatus)) {
                currentOrder.setCancelledDate(now);
            }

            // 3. Cập nhật trạng thái và lưu lại
            currentOrder.setStatus(newStatus);
            this.orderRepository.save(currentOrder);
        }
    }

    @Transactional
    public void deleteOrderById(long id) {
        Optional<Order> orderOptional = this.fetchOrderById(id);
        if (orderOptional.isPresent()) {
            Order order = orderOptional.get();
            List<OrderDetail> details = order.getOrderDetails();
            for (OrderDetail cd : details) {
                this.orderDetailRepository.deleteById(cd.getId());
            }
            this.orderRepository.deleteById(id);
        }
    }

    public List<Order> fetchOrderByUser(User user) {
        return this.orderRepository.findByUser(user);
    }

    public void saveOrder(Order order) {
        // Luôn gán ngày giờ hiện tại nếu là đơn hàng mới
        if (order.getId() == 0 || order.getOrderDate() == null) {
            order.setOrderDate(LocalDateTime.now());
        }
        this.orderRepository.save(order);
    }

    public List<Order> searchOrder(String keyword) {
        return orderRepository.searchByKeyword(keyword);
    }

    // Lấy danh sách toàn bộ đơn hàng
    public List<Order> getAllOrders() {
        return orderRepository.findAll();
    }

    public List<OrderSearchDTO> searchOrderAjax(String keyword) {
        List<Order> orders = keyword.isEmpty() ? orderRepository.findAll() : orderRepository.searchByKeyword(keyword);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");

        return orders.stream().map(o -> new OrderSearchDTO(
                o.getId(),
                o.getReceiverName(),
                o.getReceiverPhone(),
                o.getReceiverAddress(),
                o.getTotalPrice(),
                o.getStatus(),
                // Format ngày đặt hàng (nếu null thì trả về chuỗi rỗng)
                o.getOrderDate() != null ? o.getOrderDate().format(formatter) : "",
                // Format ngày nhận hàng (nếu null thì trả về chuỗi rỗng)
                o.getDeliveredDate() != null ? o.getDeliveredDate().format(formatter) : ""))
                .collect(Collectors.toList());
    }

    public Order createOrder(Order order) {
        order.setOrderDate(LocalDateTime.now());
        order.setStatus("PENDING");
        return orderRepository.save(order);
    }

    // 2. Tự động cập nhật ngày khi Admin đổi trạng thái
    public void updateOrderStatus(long orderId, String newStatus) {
        Order order = orderRepository.findById(orderId).orElse(null);
        if (order != null) {
            order.setStatus(newStatus);
            LocalDateTime now = LocalDateTime.now();

            switch (newStatus) {
                case "SHIPPING":
                    order.setShippingDate(now);
                    order.setExpectedDeliveryDate(now.plusDays(3)); // Dự kiến 3 ngày sau nhận hàng
                    break;
                case "DELIVERED":
                case "SUCCESS":
                    order.setDeliveredDate(now);
                    break;
                case "CANCELLED":
                    order.setCancelledDate(now);
                    break;
            }
            orderRepository.save(order);
        }
    }

    // 3. Hàm lấy danh sách doanh thu
    public List<Order> getRevenueByDate(LocalDateTime start, LocalDateTime end) {
        return orderRepository.findRevenueOrders(start, end);
    }

    // 4. Hàm Export Excel
    public void exportRevenueToExcel(HttpServletResponse response, LocalDateTime start, LocalDateTime end)
            throws Exception {
        List<Order> orders = orderRepository.findRevenueOrders(start, end);

        try (XSSFWorkbook workbook = new XSSFWorkbook()) {
            XSSFSheet sheet = workbook.createSheet("Báo cáo doanh thu");

            // ==========================================
            // 1. KHỞI TẠO CÁC STYLE CHUYÊN NGHIỆP
            // ==========================================
            CreationHelper createHelper = workbook.getCreationHelper();

            // Style Tiêu đề lớn
            XSSFFont titleFont = workbook.createFont();
            titleFont.setBold(true);
            titleFont.setFontHeightInPoints((short) 20);
            titleFont.setColor(IndexedColors.DARK_BLUE.getIndex());
            XSSFCellStyle titleStyle = workbook.createCellStyle();
            titleStyle.setAlignment(HorizontalAlignment.CENTER);
            titleStyle.setVerticalAlignment(VerticalAlignment.CENTER);
            titleStyle.setFont(titleFont);

            // Style Header Bảng
            XSSFFont headerFont = workbook.createFont();
            headerFont.setBold(true);
            headerFont.setColor(IndexedColors.WHITE.getIndex());
            XSSFCellStyle headerStyle = createBorderedStyle(workbook);
            headerStyle.setFillForegroundColor(IndexedColors.DARK_BLUE.getIndex());
            headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            headerStyle.setAlignment(HorizontalAlignment.CENTER);
            headerStyle.setVerticalAlignment(VerticalAlignment.CENTER);
            headerStyle.setFont(headerFont);

            // Style Dữ liệu cơ bản (Căn giữa và Căn trái)
            XSSFCellStyle dataCenterStyle = createBorderedStyle(workbook);
            dataCenterStyle.setAlignment(HorizontalAlignment.CENTER);

            XSSFCellStyle dataLeftStyle = createBorderedStyle(workbook);
            dataLeftStyle.setAlignment(HorizontalAlignment.LEFT);

            // Style Dòng xen kẽ (Xám nhạt)
            XSSFCellStyle altDataCenterStyle = cloneStyleWithAltBackground(workbook, dataCenterStyle);
            XSSFCellStyle altDataLeftStyle = cloneStyleWithAltBackground(workbook, dataLeftStyle);

            // Style Tiền tệ (VNĐ)
            XSSFCellStyle currencyStyle = createBorderedStyle(workbook);
            currencyStyle.setAlignment(HorizontalAlignment.RIGHT);
            currencyStyle.setDataFormat(createHelper.createDataFormat().getFormat("#,##0 \"VNĐ\""));
            XSSFCellStyle altCurrencyStyle = cloneStyleWithAltBackground(workbook, currencyStyle);

            // Style Tổng doanh thu
            XSSFFont totalFont = workbook.createFont();
            totalFont.setBold(true);
            totalFont.setFontHeightInPoints((short) 14);
            totalFont.setColor(IndexedColors.RED.getIndex());
            XSSFCellStyle totalStyle = createBorderedStyle(workbook);
            totalStyle.setFillForegroundColor(IndexedColors.LIGHT_YELLOW.getIndex());
            totalStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            totalStyle.setAlignment(HorizontalAlignment.RIGHT);
            totalStyle.setFont(totalFont);
            totalStyle.setDataFormat(createHelper.createDataFormat().getFormat("#,##0 \"VNĐ\""));

            // ==========================================
            // 2. TẠO HEADER BÁO CÁO (THÔNG TIN CHUNG)
            // ==========================================
            DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");

            // Dòng 0: Tiêu đề lớn (Merge từ A -> H để cân đối toàn bảng)
            Row rowTitle = sheet.createRow(0);
            rowTitle.setHeightInPoints(40);
            Cell cellTitle = rowTitle.createCell(0);
            cellTitle.setCellValue("BÁO CÁO DOANH THU ĐƠN HÀNG");
            cellTitle.setCellStyle(titleStyle);
            sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 7));

            // Dòng 1: Thời gian lọc
            Row rowFilter = sheet.createRow(1);
            rowFilter.createCell(0).setCellValue(
                    "Từ ngày: " + start.format(dateFormatter) + "  -  Đến ngày: " + end.format(dateFormatter));

            // Dòng 2: Ngày xuất file
            Row rowExportDate = sheet.createRow(2);
            rowExportDate.createCell(0).setCellValue("Ngày xuất báo cáo: " + LocalDateTime.now().format(dateFormatter));

            // ==========================================
            // 3. TẠO HEADER BẢNG DỮ LIỆU
            // ==========================================
            int rowIndex = 4; // Bắt đầu bảng từ dòng số 4 (Index 4 = Row 5)
            Row headerRow = sheet.createRow(rowIndex++);
            String[] columns = { "STT", "Mã đơn", "Khách hàng", "SĐT", "Ngày đặt", "Ngày nhận", "Tổng tiền",
                    "Trạng thái" };

            for (int i = 0; i < columns.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(columns[i]);
                cell.setCellStyle(headerStyle);
            }

            // FREEZE PANE: Cố định Header bảng khi cuộn chuột
            sheet.createFreezePane(0, 5);

            // ==========================================
            // 4. ĐỔ DỮ LIỆU VÀO BẢNG
            // ==========================================
            int stt = 1;
            double totalRevenue = 0;

            for (Order order : orders) {
                Row row = sheet.createRow(rowIndex++);
                boolean isAlt = (stt % 2 == 0); // Dòng chẵn dùng màu xám nhạt xen kẽ

                // STT
                Cell cell0 = row.createCell(0);
                cell0.setCellValue(stt++);
                cell0.setCellStyle(isAlt ? altDataCenterStyle : dataCenterStyle);

                // Mã đơn
                Cell cell1 = row.createCell(1);
                cell1.setCellValue("MD" + order.getId());
                cell1.setCellStyle(isAlt ? altDataCenterStyle : dataCenterStyle);

                // Khách hàng
                Cell cell2 = row.createCell(2);
                cell2.setCellValue(order.getReceiverName());
                cell2.setCellStyle(isAlt ? altDataLeftStyle : dataLeftStyle);

                // SĐT
                Cell cell3 = row.createCell(3);
                cell3.setCellValue(order.getReceiverPhone());
                cell3.setCellStyle(isAlt ? altDataCenterStyle : dataCenterStyle);

                // Ngày đặt (Sử dụng hàm Transient đã tối ưu trước đó)
                Cell cell4 = row.createCell(4);
                cell4.setCellValue(order.getOrderDate() != null ? order.getOrderDate().format(dateFormatter) : "");
                cell4.setCellStyle(isAlt ? altDataCenterStyle : dataCenterStyle);

                // Ngày nhận
                Cell cell5 = row.createCell(5);
                cell5.setCellValue(
                        order.getDeliveredDate() != null ? order.getDeliveredDate().format(dateFormatter) : "");
                cell5.setCellStyle(isAlt ? altDataCenterStyle : dataCenterStyle);

                // Tổng tiền
                Cell cell6 = row.createCell(6);
                cell6.setCellValue(order.getTotalPrice());
                cell6.setCellStyle(isAlt ? altCurrencyStyle : currencyStyle);
                totalRevenue += order.getTotalPrice();

                // Trạng thái (Xử lý màu chữ theo Status)
                Cell cell7 = row.createCell(7);
                cell7.setCellValue(order.getStatus());
                cell7.setCellStyle(createStatusStyle(workbook, order.getStatus(), isAlt));
            }

            // ==========================================
            // 5. DÒNG TỔNG DOANH THU CUỐI BẢNG
            // ==========================================
            Row totalRow = sheet.createRow(rowIndex);
            totalRow.setHeightInPoints(25); // Cao hơn bình thường để nổi bật

            // Merge ô cho chữ TỔNG DOANH THU
            sheet.addMergedRegion(new CellRangeAddress(rowIndex, rowIndex, 0, 5));
            Cell labelCell = totalRow.createCell(0);
            labelCell.setCellValue("TỔNG DOANH THU HIỆN TẠI:");

            // Set style cho các ô bị merge để có border
            for (int i = 0; i <= 5; i++) {
                Cell c = totalRow.getCell(i);
                if (c == null)
                    c = totalRow.createCell(i);
                c.setCellStyle(totalStyle);
            }
            labelCell.setCellStyle(totalStyle); // Căn phải nằm trong totalStyle

            // Ghi số tổng tiền
            Cell totalValueCell = totalRow.createCell(6);
            totalValueCell.setCellValue(totalRevenue);
            totalValueCell.setCellStyle(totalStyle);

            // Ô cuối cùng (Cột Trạng thái) làm trống nhưng vẫn kẻ viền nền vàng
            Cell emptyLastCell = totalRow.createCell(7);
            emptyLastCell.setCellStyle(totalStyle);

            // ==========================================
            // 6. AUTO SIZE & BỘ LỌC (AUTO FILTER)
            // ==========================================
            // Kích hoạt Filter từ cột A (0) đến H (7), bắt đầu từ dòng Header (4) đến dòng
            // dữ liệu cuối cùng
            sheet.setAutoFilter(new CellRangeAddress(4, rowIndex - 1, 0, 7));

            // Tự động giãn cột (cộng thêm chút đệm để không bị sát mép)
            for (int i = 0; i < columns.length; i++) {
                sheet.autoSizeColumn(i);
                int currentWidth = sheet.getColumnWidth(i);
                sheet.setColumnWidth(i, currentWidth + 1000); // Thêm padding
            }

            // ==========================================
            // 7. XUẤT FILE
            // ==========================================
            String fileName = "BaoCaoDoanhThu_"
                    + LocalDateTime.now().format(DateTimeFormatter.ofPattern("ddMMyyyy_HHmm")) + ".xlsx";
            response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
            response.setHeader("Content-Disposition", "attachment; filename=" + fileName);
            workbook.write(response.getOutputStream());
        }
    }

    // ==========================================
    // CÁC HÀM TIỆN ÍCH HỖ TRỢ STYLE TÁCH RỜI
    // ==========================================

    private XSSFCellStyle createBorderedStyle(XSSFWorkbook workbook) {
        XSSFCellStyle style = workbook.createCellStyle();
        style.setBorderTop(BorderStyle.THIN);
        style.setBorderBottom(BorderStyle.THIN);
        style.setBorderLeft(BorderStyle.THIN);
        style.setBorderRight(BorderStyle.THIN);
        style.setVerticalAlignment(VerticalAlignment.CENTER);
        return style;
    }

    private XSSFCellStyle cloneStyleWithAltBackground(XSSFWorkbook workbook, XSSFCellStyle originalStyle) {
        XSSFCellStyle altStyle = workbook.createCellStyle();
        altStyle.cloneStyleFrom(originalStyle);
        // Màu xám siêu nhạt cho dòng xen kẽ
        altStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
        altStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        return altStyle;
    }

    private XSSFCellStyle createStatusStyle(XSSFWorkbook workbook, String status, boolean isAlt) {
        XSSFCellStyle style = createBorderedStyle(workbook);
        style.setAlignment(HorizontalAlignment.CENTER);

        if (isAlt) {
            style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
            style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        }

        XSSFFont font = workbook.createFont();
        font.setBold(true);

        if (status == null)
            status = "";
        switch (status) {
            case "PENDING":
                font.setColor(IndexedColors.DARK_YELLOW.getIndex());
                break;
            case "SHIPPING":
                font.setColor(IndexedColors.BLUE.getIndex());
                break;
            case "DELIVERED":
            case "SUCCESS":
                font.setColor(IndexedColors.GREEN.getIndex());
                break;
            case "CANCELLED":
                font.setColor(IndexedColors.RED.getIndex());
                break;
            default:
                font.setColor(IndexedColors.BLACK.getIndex());
        }
        style.setFont(font);
        return style;
    }

}