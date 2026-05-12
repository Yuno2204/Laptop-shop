package vn.DinhQuangDuc.mobileshop.controller.client;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import vn.DinhQuangDuc.mobileshop.domain.Cart;
import vn.DinhQuangDuc.mobileshop.domain.CartDetail;
import vn.DinhQuangDuc.mobileshop.domain.Order;
import vn.DinhQuangDuc.mobileshop.domain.Product;
import vn.DinhQuangDuc.mobileshop.domain.User;
import vn.DinhQuangDuc.mobileshop.service.OrderService;
import vn.DinhQuangDuc.mobileshop.service.ProductService;
import vn.DinhQuangDuc.mobileshop.service.UserService;

@Controller
public class ItemController {

    private final ProductService productService;
    private final OrderService orderService;
    private final UserService userService;

    public ItemController(ProductService productService, OrderService orderService, UserService userService) {
        this.productService = productService;
        this.orderService = orderService;
        this.userService = userService;
    }

    @GetMapping("/product/{id}")
    public String getProductPage(Model model, @PathVariable long id) {
        Product product = this.productService.getProductByID(id);
        model.addAttribute("product", product);
        model.addAttribute("id", id);
        return "client/product/detail";
    }

    @PostMapping("/add-product-to-cart/{id}")
    public String addProductToCart(@PathVariable long id, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("email") == null) {
            return "redirect:/login";
        }

        String email = (String) session.getAttribute("email");
        this.productService.handleAddProductToCart(email, id, session);
        return "redirect:/";
    }

    @GetMapping("/cart")
    public String getCartPage(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null) {
            return "redirect:/login";
        }

        long userId = (long) session.getAttribute("id");
        User currentUser = new User();
        currentUser.setId(userId);

        Cart cart = this.productService.fetchByUser(currentUser);
        List<CartDetail> cartDetails = cart == null ? new ArrayList<CartDetail>() : cart.getCartDetails();

        double totalPrice = 0;
        for (CartDetail cd : cartDetails) {
            totalPrice += cd.getPrice() * cd.getQuantity();
        }

        model.addAttribute("cartDetails", cartDetails);
        model.addAttribute("totalPrice", totalPrice);
        model.addAttribute("cart", cart);
        return "client/cart/show";
    }

    @PostMapping("/delete-cart-product/{id}")
    public String deleteCartDetail(@PathVariable long id, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return "redirect:/login";
        }
        this.productService.handleRemoveCartDetail(id, session);
        return "redirect:/cart";
    }

    @GetMapping("/checkout")
    public String getCheckOutPage(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null) {
            return "redirect:/login";
        }

        // Lấy ID từ session
        long userId = (long) session.getAttribute("id");

        // Gọi userService lấy thông tin User (Đã hết lỗi vì đã inject ở Bước 1)
        User currentUser = this.userService.getUserByID(userId);

        // TRUYỀN DỮ LIỆU USER SANG TRANG CHECKOUT ĐỂ TỰ ĐỘNG ĐIỀN FORM
        model.addAttribute("user", currentUser);

        // Xử lý giỏ hàng và tổng tiền
        Cart cart = this.productService.fetchByUser(currentUser);
        List<CartDetail> cartDetails = cart == null ? new ArrayList<>() : cart.getCartDetails();

        double totalPrice = 0;
        for (CartDetail cd : cartDetails) {
            totalPrice += cd.getPrice() * cd.getQuantity();
        }

        model.addAttribute("cartDetails", cartDetails);
        model.addAttribute("totalPrice", totalPrice);

        return "client/cart/checkout";
    }

    @PostMapping("/confirm-checkout")
    public String confirmCheckout(@ModelAttribute("cart") Cart cart) {
        List<CartDetail> cartDetails = cart == null ? new ArrayList<>() : cart.getCartDetails();
        this.productService.handleUpdateCartBeforeCheckout(cartDetails);
        return "redirect:/checkout";
    }

    @PostMapping("/place-order")
    public String handlePlaceOrder(
            HttpServletRequest request,
            @RequestParam("receiverName") String receiverName,
            @RequestParam("receiverAddress") String receiverAddress,
            @RequestParam("receiverPhone") String receiverPhone,
            RedirectAttributes redirectAttributes) {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null) {
            return "redirect:/login";
        }

        long userId = (long) session.getAttribute("id");
        User currentUser = new User();
        currentUser.setId(userId);

        // Gọi service xử lý đặt hàng (đã có logic kiểm tra tồn kho và trừ hàng)
        String errorMsg = this.productService.handlePlaceOrder(currentUser, session, receiverName, receiverAddress,
                receiverPhone);

        if (errorMsg != null) {
            redirectAttributes.addFlashAttribute("error", errorMsg);
            return "redirect:/checkout";
        }

        return "redirect:/thanks";
    }

    @GetMapping("/thanks")
    public String getThankYouPage() {
        return "client/cart/thanks";
    }

    @GetMapping("/order-history")
    public String getOrderHistoryPage(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null) {
            return "redirect:/login";
        }

        long userId = (long) session.getAttribute("id");
        User currentUser = new User();
        currentUser.setId(userId);

        List<Order> orders = this.orderService.fetchOrderByUser(currentUser);
        model.addAttribute("orders", orders);

        return "client/cart/order-history";
    }

    @GetMapping("/order-history/{id}")
    public String getOrderDetailPage(Model model, HttpServletRequest request, @PathVariable long id) {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null)
            return "redirect:/login";
        long userId = (long) session.getAttribute("id");

        Optional<Order> orderOpt = this.orderService.fetchOrderById(id);
        if (orderOpt.isPresent()) {
            Order order = orderOpt.get();
            // Bảo mật: Chỉ cho phép xem đơn hàng của chính mình
            if (order.getUser().getId() != userId) {
                return "redirect:/order-history";
            }
            model.addAttribute("order", order);
            return "client/cart/order-detail";
        }
        return "redirect:/order-history";
    }

    // 2. Xử lý cập nhật thông tin nhận hàng
    @PostMapping("/order-history/update")
    public String updateOrderInfo(HttpServletRequest request,
            @RequestParam("orderId") long orderId,
            @RequestParam("receiverName") String receiverName,
            @RequestParam("receiverAddress") String receiverAddress,
            @RequestParam("receiverPhone") String receiverPhone,
            RedirectAttributes ra) {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null)
            return "redirect:/login";
        long userId = (long) session.getAttribute("id");

        Optional<Order> orderOpt = this.orderService.fetchOrderById(orderId);
        if (orderOpt.isPresent()) {
            Order order = orderOpt.get();
            // Kểm tra điều kiện: Đúng chủ đơn hàng VÀ trạng thái phải là PENDING
            if (order.getUser().getId() == userId && "PENDING".equals(order.getStatus())) {
                order.setReceiverName(receiverName);
                order.setReceiverAddress(receiverAddress);
                order.setReceiverPhone(receiverPhone);
                this.orderService.saveOrder(order); // Lưu thay đổi
                ra.addFlashAttribute("success", "Cập nhật thông tin nhận hàng thành công!");
            } else {
                ra.addFlashAttribute("error", "Đơn hàng đang giao, không thể cập nhật!");
            }
        }
        return "redirect:/order-history/" + orderId;
    }

    // 3. Xử lý Hủy đơn hàng
    @PostMapping("/order-history/cancel")
    public String cancelOrder(HttpServletRequest request, @RequestParam("orderId") long orderId,
            RedirectAttributes ra) {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null)
            return "redirect:/login";
        long userId = (long) session.getAttribute("id");

        Optional<Order> orderOpt = this.orderService.fetchOrderById(orderId);
        if (orderOpt.isPresent()) {
            Order order = orderOpt.get();
            if (order.getUser().getId() == userId && "PENDING".equals(order.getStatus())) {
                // Tái sử dụng logic updateOrder của Admin (tự động hoàn kho)
                Order tempOrder = new Order();
                tempOrder.setId(orderId);
                tempOrder.setStatus("CANCELLED");
                this.orderService.updateOrder(tempOrder);

                ra.addFlashAttribute("success", "Hủy đơn hàng thành công! Số lượng sản phẩm đã được hoàn lại kho.");
            } else {
                ra.addFlashAttribute("error", "Không thể hủy đơn hàng lúc này!");
            }
        }
        return "redirect:/order-history/" + orderId;
    }

    @GetMapping("/api/order/status/{id}")
    @ResponseBody
    public Order getOrderStatus(@PathVariable Long id) {
        // Trả về đối tượng Order dưới dạng JSON
        return this.orderService.fetchOrderById(id).orElse(null);
    }
}