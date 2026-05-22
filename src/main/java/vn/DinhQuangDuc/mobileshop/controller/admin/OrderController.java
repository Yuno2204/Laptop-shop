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

    @GetMapping("/admin/order")
    public String getDashboard(Model model,
            @RequestParam(value = "startDate", required = false) String startDate,
            @RequestParam(value = "endDate", required = false) String endDate,
            @RequestParam(value = "page", defaultValue = "1") int page) {

        List<Order> orders;
        List<Order> revenueOrders;

        orders = this.orderService.fetchAllOrders();

        if (startDate != null && !startDate.isEmpty() && endDate != null && !endDate.isEmpty()) {
            LocalDateTime start = LocalDate.parse(startDate).atStartOfDay();
            LocalDateTime end = LocalDate.parse(endDate).atTime(23, 59, 59);

            orders = orders.stream()
                    .filter(o -> o.getOrderDate() != null
                            && !o.getOrderDate().isBefore(start)
                            && !o.getOrderDate().isAfter(end))
                    .collect(Collectors.toList());

            revenueOrders = this.orderService.getRevenueByDate(start, end);
        } else {
            revenueOrders = orders.stream()
                    .filter(o -> "DELIVERED".equals(o.getStatus()) || "SUCCESS".equals(o.getStatus()))
                    .collect(Collectors.toList());
        }

        orders.sort((o1, o2) -> Long.compare(o2.getId(), o1.getId()));
        revenueOrders.sort((o1, o2) -> Long.compare(o2.getId(), o1.getId()));

        double totalRevenue = revenueOrders.stream()
                .mapToDouble(Order::getTotalPrice)
                .sum();

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

        model.addAttribute("orders", pagedOrders);
        model.addAttribute("revenueOrders", revenueOrders);
        model.addAttribute("totalRevenue", totalRevenue);

        model.addAttribute("startDate", startDate);
        model.addAttribute("endDate", endDate);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);

        return "admin/order/show";
    }

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

    @GetMapping("/admin/order/update/{id}")
    public String getUpdateOrderPage(Model model, @PathVariable long id) {
        Optional<Order> currentOrder = this.orderService.fetchOrderById(id);
        if (currentOrder.isPresent()) {
            model.addAttribute("newOrder", currentOrder.get());
        }
        return "admin/order/update";
    }

    @PostMapping("/admin/order/update")
    public String postUpdateOrderPage(@ModelAttribute("newOrder") Order order) {
        this.orderService.updateOrder(order);
        return "redirect:/admin/order";
    }

    @GetMapping("/admin/order/delete/{id}")
    public String getDeleteOrderPage(Model model, @PathVariable long id) {
        model.addAttribute("id", id);

        // SỬA LỖI: Cần tạo đối tượng và ép giá trị ID tĩnh vào thay vì truyền Order
        // rỗng.
        Order tempOrder = new Order();
        tempOrder.setId(id);
        model.addAttribute("newOrder", tempOrder);

        return "admin/order/delete";
    }

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
            List<Order> orders = this.orderService.fetchAllOrders();
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