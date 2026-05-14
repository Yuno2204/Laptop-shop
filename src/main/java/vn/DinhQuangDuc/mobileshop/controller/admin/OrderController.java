package vn.DinhQuangDuc.mobileshop.controller.admin;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpServletResponse;
import vn.DinhQuangDuc.mobileshop.domain.Order;
import vn.DinhQuangDuc.mobileshop.dto.OrderSearchDTO;
import vn.DinhQuangDuc.mobileshop.service.ExcelExportService;
import vn.DinhQuangDuc.mobileshop.service.OrderService;

@Controller
public class OrderController {

    private final OrderService orderService;
    private final ExcelExportService excelExportService;

    public OrderController(OrderService orderService, ExcelExportService excelExportService) {
        this.orderService = orderService;
        this.excelExportService = excelExportService;
    }

    // Hiển thị danh sách đơn hàng
    // Hiển thị danh sách đơn hàng
    @GetMapping("/admin/order")
    public String getDashboard(Model model,
            @RequestParam(value = "startDate", required = false) String startDate,
            @RequestParam(value = "endDate", required = false) String endDate,
            @RequestParam(value = "page", defaultValue = "1") int page) { // Thêm tham số page

        List<Order> orders;
        List<Order> revenueOrders;

        // 1. Lấy TẤT CẢ đơn hàng
        orders = this.orderService.fetchAllOrders();

        if (startDate != null && !startDate.isEmpty() && endDate != null && !endDate.isEmpty()) {
            LocalDateTime start = LocalDate.parse(startDate).atStartOfDay();
            LocalDateTime end = LocalDate.parse(endDate).atTime(23, 59, 59);

            // Lọc danh sách tổng theo ngày tạo
            orders = orders.stream()
                    .filter(o -> o.getOrderDate() != null
                            && !o.getOrderDate().isBefore(start)
                            && !o.getOrderDate().isAfter(end))
                    .collect(Collectors.toList());

            // 2. Doanh thu:
            revenueOrders = this.orderService.getRevenueByDate(start, end);
        } else {
            // Doanh thu mặc định
            revenueOrders = orders.stream()
                    .filter(o -> "DELIVERED".equals(o.getStatus()) || "SUCCESS".equals(o.getStatus()))
                    .collect(Collectors.toList());
        }

        // Sắp xếp đơn mới nhất lên đầu
        orders.sort((o1, o2) -> Long.compare(o2.getId(), o1.getId()));
        revenueOrders.sort((o1, o2) -> Long.compare(o2.getId(), o1.getId()));

        // Tính tổng tiền dựa trên TẤT CẢ đơn hàng lọc được (Giữ nguyên không đổi)
        double totalRevenue = revenueOrders.stream()
                .mapToDouble(Order::getTotalPrice)
                .sum();

        // --- BẮT ĐẦU CẮT 10 DÒNG CHO BẢNG HIỂN THỊ ĐƠN HÀNG ---
        int pageSize = 10;
        int totalItems = orders.size();
        int totalPages = (int) Math.ceil((double) totalItems / pageSize);
        if (totalPages == 0)
            totalPages = 1;
        if (page < 1)
            page = 1;
        if (page > totalPages)
            page = totalPages;

        int startItem = (page - 1) * pageSize;
        int endItem = Math.min(startItem + pageSize, totalItems);
        List<Order> pagedOrders = orders.subList(startItem, endItem);
        // --------------------------------------------------------

        // Trả về View
        model.addAttribute("orders", pagedOrders); // Chỉ truyền 10 đơn lên giao diện
        model.addAttribute("revenueOrders", revenueOrders); // Bảng doanh thu giữ nguyên
        model.addAttribute("totalRevenue", totalRevenue);

        // Gửi lại các biến lọc và trang
        model.addAttribute("startDate", startDate);
        model.addAttribute("endDate", endDate);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);

        return "admin/order/show";
    }

    // Xem chi tiết đơn hàng
    @GetMapping("/admin/order/{id}")
    public String getOrderDetailPage(Model model, @PathVariable long id) {
        Optional<Order> orderOptional = this.orderService.fetchOrderById(id);
        if (orderOptional.isPresent()) {
            Order order = orderOptional.get();
            model.addAttribute("order", order);
            model.addAttribute("id", id);
            model.addAttribute("orderDetails", order.getOrderDetails());
        }
        return "admin/order/detail";
    }

    // Lấy giao diện cập nhật trạng thái đơn hàng
    @GetMapping("/admin/order/update/{id}")
    public String getUpdateOrderPage(Model model, @PathVariable long id) {
        Optional<Order> currentOrder = this.orderService.fetchOrderById(id);
        if (currentOrder.isPresent()) {
            model.addAttribute("newOrder", currentOrder.get());
        }
        return "admin/order/update";
    }

    // Xử lý cập nhật trạng thái đơn hàng
    @PostMapping("/admin/order/update")
    public String postUpdateOrderPage(@ModelAttribute("newOrder") Order order) {
        this.orderService.updateOrder(order);
        return "redirect:/admin/order";
    }

    // Lấy giao diện xác nhận xóa đơn hàng
    @GetMapping("/admin/order/delete/{id}")
    public String getDeleteOrderPage(Model model, @PathVariable long id) {
        model.addAttribute("id", id);
        model.addAttribute("newOrder", new Order());
        return "admin/order/delete";
    }

    // Xử lý xóa đơn hàng
    @PostMapping("/admin/order/delete")
    public String postDeleteOrderPage(@ModelAttribute("newOrder") Order order) {
        this.orderService.deleteOrderById(order.getId());
        return "redirect:/admin/order";
    }

    @GetMapping("/admin/order/search")
    @ResponseBody
    public ResponseEntity<List<OrderSearchDTO>> searchOrder(@RequestParam(defaultValue = "") String keyword) {
        List<OrderSearchDTO> orders = orderService.searchOrderAjax(keyword);
        return ResponseEntity.ok(orders);
    }

    @GetMapping("/admin/order/revenue/filter")
    @ResponseBody
    public ResponseEntity<?> filterRevenue(@RequestParam String startDate, @RequestParam String endDate) {
        LocalDateTime start = LocalDate.parse(startDate).atStartOfDay();
        LocalDateTime end = LocalDate.parse(endDate).atTime(23, 59, 59);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");

        List<OrderSearchDTO> revenueData = orderService.getRevenueByDate(start, end)
                .stream().map(o -> new OrderSearchDTO(
                        o.getId(),
                        o.getReceiverName(),
                        o.getReceiverPhone(),
                        o.getReceiverAddress(),
                        o.getTotalPrice(),
                        o.getStatus(),
                        // Parse LocalDateTime sang String
                        o.getOrderDate() != null ? o.getOrderDate().format(formatter) : "",
                        o.getDeliveredDate() != null ? o.getDeliveredDate().format(formatter) : ""))
                .collect(Collectors.toList());

        return ResponseEntity.ok(revenueData);
    }

    @GetMapping("/admin/order/revenue/export")
    public void exportExcel(HttpServletResponse response, @RequestParam String startDate, @RequestParam String endDate)
            throws Exception {
        LocalDateTime start = LocalDate.parse(startDate).atStartOfDay();
        LocalDateTime end = LocalDate.parse(endDate).atTime(23, 59, 59);
        List<Order> revenueOrders = orderService.getRevenueByDate(start, end);
        excelExportService.exportRevenue(response, revenueOrders, start, end);
    }

    @GetMapping("/admin/order/export")
    public void exportOrdersToExcel(HttpServletResponse response) {
        try {
            // Lấy toàn bộ đơn hàng
            List<Order> orders = this.orderService.fetchAllOrders();
            // Xuất báo cáo Master-Detail (Kèm danh sách sản phẩm bên trong)
            this.excelExportService.exportOrders(response, orders);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @GetMapping("/admin/order/invoice/{id}")
    public String getInvoicePage(Model model, @PathVariable long id) {
        Order order = this.orderService.fetchOrderById(id).get();
        model.addAttribute("order", order);
        model.addAttribute("orderDetails", order.getOrderDetails());
        return "admin/order/invoice";
    }
}