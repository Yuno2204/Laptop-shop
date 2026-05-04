package vn.DinhQuangDuc.mobileshop.controller.admin;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import vn.DinhQuangDuc.mobileshop.domain.Order;
import vn.DinhQuangDuc.mobileshop.service.OrderService;

@Controller
public class OrderController {

    private final OrderService orderService;

    public OrderController(OrderService orderService) {
        this.orderService = orderService;
    }

    // Hiển thị danh sách đơn hàng
    @GetMapping("/admin/order")
    public String getDashboard(Model model) {
        List<Order> orders = this.orderService.fetchAllOrders();
        model.addAttribute("orders", orders);
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
}