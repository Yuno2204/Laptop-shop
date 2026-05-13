package vn.DinhQuangDuc.mobileshop.service;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.*;
import org.springframework.stereotype.Service;
import jakarta.servlet.http.HttpServletResponse;

import vn.DinhQuangDuc.mobileshop.domain.*;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Service
public class ExcelExportService {

    private final DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
    private final DateTimeFormatter shortDateFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");

    // ==========================================
    // 1. MODULE: QUẢN LÝ NGƯỜI DÙNG
    // ==========================================
    public void exportUsers(HttpServletResponse response, List<User> users) throws Exception {
        try (XSSFWorkbook workbook = new XSSFWorkbook()) {
            XSSFSheet sheet = workbook.createSheet("Danh sách Người Dùng");
            createTitle(workbook, sheet, "BÁO CÁO DANH SÁCH NGƯỜI DÙNG", 8);

            String[] headers = { "ID", "Họ tên", "Email", "SĐT", "Địa chỉ", "Vai trò", "Giới tính", "Ngày sinh",
                    "Avatar Link" };
            createHeaderRow(workbook, sheet, headers, 4);

            XSSFCellStyle dataStyle = createBorderStyle(workbook, HorizontalAlignment.LEFT);
            XSSFCellStyle centerStyle = createBorderStyle(workbook, HorizontalAlignment.CENTER);

            int rowIdx = 5;
            for (User u : users) {
                Row row = sheet.createRow(rowIdx++);
                createCell(row, 0, u.getId(), centerStyle);
                createCell(row, 1, u.getFullName(), dataStyle);
                createCell(row, 2, u.getEmail(), dataStyle);
                createCell(row, 3, u.getPhone(), centerStyle);
                createCell(row, 4, u.getAddress(), dataStyle);
                createCell(row, 5, u.getRole() != null ? u.getRole().getName() : "", centerStyle);
                createCell(row, 6, u.getGender(), centerStyle);
                createCell(row, 7, u.getDateOfBirth(), centerStyle);
                createCell(row, 8, u.getAvatar(), dataStyle);
            }

            Row summaryRow = sheet.createRow(rowIdx + 1);
            createSummaryCell(workbook, summaryRow, 0, 2, "TỔNG SỐ NGƯỜI DÙNG:", users.size() + " tài khoản");

            finalizeSheet(sheet, headers.length);
            writeResponse(response, workbook, "Users_Report");
        }
    }

    // ==========================================
    // 2. MODULE: QUẢN LÝ SẢN PHẨM
    // ==========================================
    public void exportProducts(HttpServletResponse response, List<Product> products) throws Exception {
        try (XSSFWorkbook workbook = new XSSFWorkbook()) {
            XSSFSheet sheet = workbook.createSheet("Danh sách Sản Phẩm");
            createTitle(workbook, sheet, "BÁO CÁO KHO SẢN PHẨM", 16);

            String[] headers = {
                    "ID", "Tên sản phẩm", "Giá (VNĐ)", "Số lượng", "Đã bán",
                    "Hãng", "Đối tượng", "Hệ điều hành", "CPU", "RAM", "ROM",
                    "Tần số quét", "Màn hình", "Pin", "Sạc nhanh", "Mô tả ngắn", "Ảnh"
            };
            createHeaderRow(workbook, sheet, headers, 4);

            XSSFCellStyle dataStyle = createBorderStyle(workbook, HorizontalAlignment.LEFT);
            XSSFCellStyle centerStyle = createBorderStyle(workbook, HorizontalAlignment.CENTER);
            XSSFCellStyle currencyStyle = createCurrencyStyle(workbook);

            int rowIdx = 5;
            long totalStock = 0;
            long totalSold = 0;

            for (Product p : products) {
                Row row = sheet.createRow(rowIdx++);
                createCell(row, 0, p.getId(), centerStyle);
                createCell(row, 1, p.getName(), dataStyle);
                createCell(row, 2, p.getPrice(), currencyStyle);
                createCell(row, 3, p.getQuantity(), centerStyle);
                createCell(row, 4, p.getSold(), centerStyle);
                createCell(row, 5, p.getFactory(), centerStyle);
                createCell(row, 6, p.getTarget(), centerStyle);
                createCell(row, 7, p.getOs(), centerStyle);
                createCell(row, 8, p.getCpu(), centerStyle);
                createCell(row, 9, p.getRam(), centerStyle);
                createCell(row, 10, p.getRom(), centerStyle);
                createCell(row, 11, p.getRefreshRate(), centerStyle);
                createCell(row, 12, p.getScreenSize(), dataStyle);
                createCell(row, 13, p.getBattery(), centerStyle);
                createCell(row, 14, p.getFastCharge(), centerStyle);
                createCell(row, 15, p.getShortDesc(), dataStyle);
                createCell(row, 16, p.getImage(), dataStyle);

                totalStock += p.getQuantity();
                totalSold += p.getSold();
            }

            Row summaryRow = sheet.createRow(rowIdx + 1);
            createSummaryCell(workbook, summaryRow, 0, 3, "TỔNG MÃ SẢN PHẨM:", products.size() + " SP");
            Row summaryRow2 = sheet.createRow(rowIdx + 2);
            createSummaryCell(workbook, summaryRow2, 0, 3, "TỔNG TỒN KHO:", totalStock + " chiếc");
            Row summaryRow3 = sheet.createRow(rowIdx + 3);
            createSummaryCell(workbook, summaryRow3, 0, 3, "TỔNG ĐÃ BÁN:", totalSold + " chiếc");

            finalizeSheet(sheet, headers.length);
            writeResponse(response, workbook, "Products_Report");
        }
    }

    // ==========================================
    // 3. MODULE: QUẢN LÝ ĐƠN HÀNG CHI TIẾT
    // ==========================================
    public void exportOrders(HttpServletResponse response, List<Order> orders) throws Exception {
        try (XSSFWorkbook workbook = new XSSFWorkbook()) {
            XSSFSheet sheet = workbook.createSheet("Báo cáo Đơn Hàng");
            createTitle(workbook, sheet, "BÁO CÁO CHI TIẾT ĐƠN HÀNG", 12);

            String[] headers = { "Mã ĐH", "Khách hàng", "SĐT", "Tài khoản (User)", "Địa chỉ nhận", "Tổng tiền",
                    "Trạng thái", "Ngày đặt", "Ngày giao", "Ngày dự kiến", "Ngày nhận", "Ngày hủy", "Ghi chú/SP" };
            createHeaderRow(workbook, sheet, headers, 4);

            XSSFCellStyle dataStyle = createBorderStyle(workbook, HorizontalAlignment.LEFT);
            XSSFCellStyle centerStyle = createBorderStyle(workbook, HorizontalAlignment.CENTER);
            XSSFCellStyle currencyStyle = createCurrencyStyle(workbook);
            XSSFCellStyle detailStyle = workbook.createCellStyle();
            detailStyle.cloneStyleFrom(dataStyle);
            detailStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
            detailStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            XSSFFont italicFont = workbook.createFont();
            italicFont.setItalic(true);
            detailStyle.setFont(italicFont);

            int rowIdx = 5;
            double totalRevenue = 0;
            int successOrders = 0;
            int cancelledOrders = 0;

            for (Order o : orders) {
                Row row = sheet.createRow(rowIdx++);
                createCell(row, 0, "MD" + o.getId(), centerStyle);
                createCell(row, 1, o.getReceiverName(), dataStyle);
                createCell(row, 2, o.getReceiverPhone(), centerStyle);
                createCell(row, 3, o.getUser() != null ? o.getUser().getEmail() : "", dataStyle);
                createCell(row, 4, o.getReceiverAddress(), dataStyle);
                createCell(row, 5, o.getTotalPrice(), currencyStyle);

                Cell statusCell = row.createCell(6);
                statusCell.setCellValue(o.getStatus());
                statusCell.setCellStyle(createStatusStyle(workbook, o.getStatus()));

                createCell(row, 7, o.getOrderDate() != null ? o.getOrderDate().format(dateFormatter) : "", centerStyle);
                createCell(row, 8, o.getShippingDate() != null ? o.getShippingDate().format(dateFormatter) : "",
                        centerStyle);
                createCell(row, 9,
                        o.getExpectedDeliveryDate() != null ? o.getExpectedDeliveryDate().format(shortDateFormatter)
                                : "",
                        centerStyle);
                createCell(row, 10, o.getDeliveredDate() != null ? o.getDeliveredDate().format(dateFormatter) : "",
                        centerStyle);
                createCell(row, 11, o.getCancelledDate() != null ? o.getCancelledDate().format(dateFormatter) : "",
                        centerStyle);
                createCell(row, 12, "Thông tin đơn hàng chính", dataStyle);

                if ("DELIVERED".equals(o.getStatus()) || "SUCCESS".equals(o.getStatus())) {
                    totalRevenue += o.getTotalPrice();
                    successOrders++;
                } else if ("CANCELLED".equals(o.getStatus())) {
                    cancelledOrders++;
                }

                if (o.getOrderDetails() != null && !o.getOrderDetails().isEmpty()) {
                    for (OrderDetail detail : o.getOrderDetails()) {
                        Row detailRow = sheet.createRow(rowIdx++);
                        sheet.addMergedRegion(new CellRangeAddress(rowIdx - 1, rowIdx - 1, 0, 3));
                        Cell padCell = detailRow.createCell(0);
                        padCell.setCellValue("  ↳ Chi tiết SP:");
                        padCell.setCellStyle(detailStyle);
                        for (int i = 1; i <= 3; i++)
                            detailRow.createCell(i).setCellStyle(detailStyle);

                        createCell(detailRow, 4,
                                detail.getProduct() != null ? detail.getProduct().getName() : "Sản phẩm bị xóa",
                                detailStyle);
                        createCell(detailRow, 5, detail.getPrice(), detailStyle);
                        createCell(detailRow, 6, "SL: " + detail.getQuantity(), detailStyle);
                        createCell(detailRow, 7, "Thành tiền: " + (detail.getPrice() * detail.getQuantity()),
                                detailStyle);

                        for (int i = 8; i < headers.length; i++)
                            detailRow.createCell(i).setCellStyle(detailStyle);
                    }
                }
            }

            Row sRow1 = sheet.createRow(rowIdx + 1);
            createSummaryCell(workbook, sRow1, 0, 4, "TỔNG SỐ ĐƠN HÀNG:", orders.size() + " đơn");

            Row sRow2 = sheet.createRow(rowIdx + 2);
            createSummaryCell(workbook, sRow2, 0, 4, "TỔNG DOANH THU (Đã nhận):",
                    String.format("%,.0f VNĐ", totalRevenue));
            sRow2.getCell(0).getCellStyle().setFont(getBoldRedFont(workbook));
            sRow2.getCell(5).getCellStyle().setFont(getBoldRedFont(workbook));

            finalizeSheet(sheet, headers.length);
            writeResponse(response, workbook, "Orders_Report");
        }
    }

    // ==========================================
    // 4. MODULE: BÁO CÁO DOANH THU (Gộp từ OrderService)
    // ==========================================
    public void exportRevenue(HttpServletResponse response, List<Order> orders, LocalDateTime start, LocalDateTime end)
            throws Exception {
        try (XSSFWorkbook workbook = new XSSFWorkbook()) {
            XSSFSheet sheet = workbook.createSheet("Báo cáo doanh thu");

            // Dòng Title
            createTitle(workbook, sheet, "BÁO CÁO DOANH THU ĐƠN HÀNG", 7);

            // Dòng khoảng thời gian lọc (Ghi đè dòng 2)
            Row rowFilter = sheet.createRow(2);
            rowFilter.createCell(0).setCellValue("Từ ngày: " + start.format(shortDateFormatter) + "  -  Đến ngày: "
                    + end.format(shortDateFormatter));

            String[] headers = { "STT", "Mã đơn", "Khách hàng", "SĐT", "Ngày đặt", "Ngày nhận", "Tổng tiền",
                    "Trạng thái" };
            createHeaderRow(workbook, sheet, headers, 4);

            XSSFCellStyle dataStyle = createBorderStyle(workbook, HorizontalAlignment.LEFT);
            XSSFCellStyle centerStyle = createBorderStyle(workbook, HorizontalAlignment.CENTER);
            XSSFCellStyle currencyStyle = createCurrencyStyle(workbook);

            int rowIdx = 5;
            int stt = 1;
            double totalRevenue = 0;

            for (Order o : orders) {
                Row row = sheet.createRow(rowIdx++);

                createCell(row, 0, stt++, centerStyle);
                createCell(row, 1, "MD" + o.getId(), centerStyle);
                createCell(row, 2, o.getReceiverName(), dataStyle);
                createCell(row, 3, o.getReceiverPhone(), centerStyle);
                createCell(row, 4, o.getOrderDate() != null ? o.getOrderDate().format(dateFormatter) : "", centerStyle);
                createCell(row, 5, o.getDeliveredDate() != null ? o.getDeliveredDate().format(dateFormatter) : "",
                        centerStyle);
                createCell(row, 6, o.getTotalPrice(), currencyStyle);

                Cell statusCell = row.createCell(7);
                statusCell.setCellValue(o.getStatus());
                statusCell.setCellStyle(createStatusStyle(workbook, o.getStatus()));

                totalRevenue += o.getTotalPrice();
            }

            // Dòng Tổng Doanh Thu
            Row summaryRow = sheet.createRow(rowIdx + 1);
            createSummaryCell(workbook, summaryRow, 0, 5, "TỔNG DOANH THU HIỆN TẠI:",
                    String.format("%,.0f VNĐ", totalRevenue));
            summaryRow.getCell(0).getCellStyle().setFont(getBoldRedFont(workbook));
            summaryRow.getCell(6).getCellStyle().setFont(getBoldRedFont(workbook));

            finalizeSheet(sheet, headers.length);
            writeResponse(response, workbook, "BaoCaoDoanhThu");
        }
    }

    // ==========================================
    // CÁC HÀM TIỆN ÍCH HỖ TRỢ STYLE TÁCH RỜI
    // ==========================================
    private void createTitle(XSSFWorkbook wb, XSSFSheet sheet, String titleText, int lastCol) {
        Row row = sheet.createRow(0);
        row.setHeightInPoints(35);
        Cell cell = row.createCell(0);
        cell.setCellValue(titleText);

        XSSFFont font = wb.createFont();
        font.setBold(true);
        font.setFontHeightInPoints((short) 18);
        font.setColor(IndexedColors.DARK_BLUE.getIndex());

        XSSFCellStyle style = wb.createCellStyle();
        style.setAlignment(HorizontalAlignment.CENTER);
        style.setVerticalAlignment(VerticalAlignment.CENTER);
        style.setFont(font);
        cell.setCellStyle(style);

        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, lastCol));

        sheet.createRow(1).createCell(0).setCellValue(
                "Ngày xuất báo cáo: " + LocalDateTime.now().format(DateTimeFormatter.ofPattern("dd/MM/yyyy")));
    }

    private void createHeaderRow(XSSFWorkbook wb, XSSFSheet sheet, String[] headers, int rowIndex) {
        Row row = sheet.createRow(rowIndex);
        row.setHeightInPoints(25);

        XSSFCellStyle style = createBorderStyle(wb, HorizontalAlignment.CENTER);
        style.setFillForegroundColor(IndexedColors.DARK_RED.getIndex());
        style.setFillPattern(FillPatternType.SOLID_FOREGROUND);

        XSSFFont font = wb.createFont();
        font.setBold(true);
        font.setColor(IndexedColors.WHITE.getIndex());
        style.setFont(font);

        for (int i = 0; i < headers.length; i++) {
            Cell cell = row.createCell(i);
            cell.setCellValue(headers[i]);
            cell.setCellStyle(style);
        }

        sheet.createFreezePane(0, rowIndex + 1);
        sheet.setAutoFilter(new CellRangeAddress(rowIndex, rowIndex, 0, headers.length - 1));
    }

    private XSSFCellStyle createBorderStyle(XSSFWorkbook wb, HorizontalAlignment align) {
        XSSFCellStyle style = wb.createCellStyle();
        style.setBorderTop(BorderStyle.THIN);
        style.setBorderBottom(BorderStyle.THIN);
        style.setBorderLeft(BorderStyle.THIN);
        style.setBorderRight(BorderStyle.THIN);
        style.setAlignment(align);
        style.setVerticalAlignment(VerticalAlignment.CENTER);
        return style;
    }

    private XSSFCellStyle createCurrencyStyle(XSSFWorkbook wb) {
        XSSFCellStyle style = createBorderStyle(wb, HorizontalAlignment.RIGHT);
        style.setDataFormat(wb.getCreationHelper().createDataFormat().getFormat("#,##0 \"VNĐ\""));
        return style;
    }

    private XSSFCellStyle createStatusStyle(XSSFWorkbook wb, String status) {
        XSSFCellStyle style = createBorderStyle(wb, HorizontalAlignment.CENTER);
        XSSFFont font = wb.createFont();
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
        }
        style.setFont(font);
        return style;
    }

    private void createSummaryCell(XSSFWorkbook wb, Row row, int startCol, int endCol, String label, String value) {
        row.getSheet().addMergedRegion(new CellRangeAddress(row.getRowNum(), row.getRowNum(), startCol, endCol));

        XSSFCellStyle style = wb.createCellStyle();
        style.setFillForegroundColor(IndexedColors.LIGHT_YELLOW.getIndex());
        style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        style.setAlignment(HorizontalAlignment.RIGHT);
        style.setBorderTop(BorderStyle.MEDIUM);

        XSSFFont font = wb.createFont();
        font.setBold(true);
        font.setFontHeightInPoints((short) 12);
        style.setFont(font);

        Cell labelCell = row.createCell(startCol);
        labelCell.setCellValue(label);
        labelCell.setCellStyle(style);

        for (int i = startCol + 1; i <= endCol; i++)
            row.createCell(i).setCellStyle(style);

        Cell valueCell = row.createCell(endCol + 1);
        valueCell.setCellValue(value);
        valueCell.setCellStyle(style);
    }

    private XSSFFont getBoldRedFont(XSSFWorkbook wb) {
        XSSFFont font = wb.createFont();
        font.setBold(true);
        font.setColor(IndexedColors.RED.getIndex());
        font.setFontHeightInPoints((short) 13);
        return font;
    }

    private void createCell(Row row, int col, Object value, XSSFCellStyle style) {
        Cell cell = row.createCell(col);
        if (value instanceof Number) {
            cell.setCellValue(((Number) value).doubleValue());
        } else {
            cell.setCellValue(value != null ? value.toString() : "");
        }
        cell.setCellStyle(style);
    }

    private void finalizeSheet(XSSFSheet sheet, int colCount) {
        for (int i = 0; i < colCount; i++) {
            sheet.autoSizeColumn(i);
            sheet.setColumnWidth(i, sheet.getColumnWidth(i) + 1200);
        }
    }

    private void writeResponse(HttpServletResponse response, XSSFWorkbook wb, String prefix) throws Exception {
        String fileName = prefix + "_" + LocalDateTime.now().format(DateTimeFormatter.ofPattern("ddMMyyyy_HHmm"))
                + ".xlsx";
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=" + fileName);
        wb.write(response.getOutputStream());
    }
}