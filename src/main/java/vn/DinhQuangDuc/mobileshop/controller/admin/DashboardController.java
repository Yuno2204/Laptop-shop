package vn.DinhQuangDuc.mobileshop.controller.admin;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import vn.DinhQuangDuc.mobileshop.domain.Order;
import vn.DinhQuangDuc.mobileshop.service.OrderService;
import vn.DinhQuangDuc.mobileshop.service.ProductService;
import vn.DinhQuangDuc.mobileshop.service.UserService;

@Controller
public class DashboardController {

    private final UserService userService;
    private final ProductService productService;
    private final OrderService orderService;

    public DashboardController(UserService userService, ProductService productService, OrderService orderService) {
        this.userService = userService;
        this.productService = productService;
        this.orderService = orderService;
    }

    @GetMapping("/admin")
    public String getDashboard(Model model) {
        model.addAttribute("countUsers", this.userService.getAllUsers().size());
        model.addAttribute("countProducts", this.productService.fetchProducts().size());
        model.addAttribute("countOrders", this.orderService.fetchAllOrders().size());

        List<Order> allOrders = this.orderService.fetchAllOrders();
        double totalRevenue = allOrders.stream()
                .filter(o -> "DELIVERED".equals(o.getStatus()))
                .mapToDouble(Order::getTotalPrice)
                .sum();

        model.addAttribute("totalRevenue", totalRevenue);
        return "admin/dashboard/show";
    }

}
