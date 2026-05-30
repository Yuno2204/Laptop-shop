package vn.DinhQuangDuc.mobileshop.controller.client;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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
    @ResponseBody
    public ResponseEntity<Map<String, Object>> addProductToCartApi(
            @PathVariable long id,
            @RequestParam(value = "quantity", defaultValue = "1") long quantity,
            HttpServletRequest request) {
        // [Giữ nguyên code hiện tại]
        Map<String, Object> response = new HashMap<>();
        try {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("email") == null) {
                response.put("success", false);
                response.put("message", "Vui lòng đăng nhập để mua hàng!");
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(response);
            }

            String email = (String) session.getAttribute("email");
            String errorMsg = this.productService.handleAddProductToCart(email, id, session, quantity);

            if (errorMsg != null) {
                response.put("success", false);
                response.put("message", errorMsg);
                return ResponseEntity.ok(response);
            }

            Object sumObj = session.getAttribute("sum");
            int currentSum = sumObj != null ? (int) sumObj : 0;
            response.put("success", true);
            response.put("message", "Thêm sản phẩm vào giỏ hàng thành công!");
            response.put("cartCount", currentSum);

            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Hệ thống đang bận. Vui lòng thử lại sau!");
            return ResponseEntity.ok(response);
        }
    }

    @GetMapping("/cart")
    public String getCartPage(Model model, HttpServletRequest request,
            @RequestParam(value = "keyword", required = false) String keyword) { // Thêm param keyword

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null) {
            return "redirect:/login";
        }

        long userId = (long) session.getAttribute("id");
        User currentUser = this.userService.getUserByID(userId);

        Cart cart = this.productService.fetchByUser(currentUser);
        List<CartDetail> cartDetails = cart == null ? new ArrayList<CartDetail>() : cart.getCartDetails();

        // LOGIC TÌM KIẾM SẢN PHẨM TRONG GIỎ HÀNG
        if (keyword != null && !keyword.trim().isEmpty()) {
            String finalKeyword = keyword.trim().toLowerCase();
            cartDetails = cartDetails.stream()
                    .filter(cd -> cd.getProduct().getName().toLowerCase().contains(finalKeyword))
                    .collect(Collectors.toList());
            model.addAttribute("keyword", keyword.trim()); // Lưu lại trạng thái keyword cho giao diện
        }

        double totalPrice = 0;
        for (CartDetail cd : cartDetails) {
            totalPrice += cd.getPrice() * cd.getQuantity();
        }

        model.addAttribute("cartDetails", cartDetails);
        model.addAttribute("totalPrice", totalPrice);
        model.addAttribute("cart", cart); // cart.getCartDetails() vẫn giữ nguyên, không bị thay đổi trong DB
        return "client/cart/show";
    }

    @PostMapping("/delete-cart-product/{id}")
    public String deleteCartDetail(@PathVariable long id, HttpServletRequest request,
            @RequestParam(value = "keyword", required = false) String keyword) { // Thêm param keyword

        HttpSession session = request.getSession(false);
        if (session == null) {
            return "redirect:/login";
        }
        this.productService.handleRemoveCartDetail(id, session);

        // Nếu đang ở trạng thái tìm kiếm, giữ nguyên query sau khi xóa
        if (keyword != null && !keyword.trim().isEmpty()) {
            return "redirect:/cart?keyword=" + keyword.trim();
        }
        return "redirect:/cart";
    }

    // Các phương thức khác: /checkout, /confirm-checkout, /place-order,
    // order-history... giữ nguyên hoàn toàn
    @GetMapping("/checkout")
    public String getCheckOutPage(Model model, HttpServletRequest request) {
        // [Giữ nguyên code hiện tại]
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null) {
            return "redirect:/login";
        }

        @SuppressWarnings("unchecked")
        List<Long> selectedCartDetailIds = (List<Long>) session.getAttribute("selectedCartDetailIds");
        if (selectedCartDetailIds == null || selectedCartDetailIds.isEmpty()) {
            return "redirect:/cart";
        }

        long userId = (long) session.getAttribute("id");
        User currentUser = this.userService.getUserByID(userId);
        model.addAttribute("user", currentUser);

        Cart cart = this.productService.fetchByUser(currentUser);
        List<CartDetail> cartDetails = cart == null ? new ArrayList<>() : cart.getCartDetails();

        List<CartDetail> selectedCartDetails = cartDetails.stream()
                .filter(cd -> selectedCartDetailIds.contains(cd.getId()))
                .collect(Collectors.toList());

        double totalPrice = 0;
        for (CartDetail cd : selectedCartDetails) {
            totalPrice += cd.getPrice() * cd.getQuantity();
        }

        model.addAttribute("cartDetails", selectedCartDetails);
        model.addAttribute("totalPrice", totalPrice);

        return "client/cart/checkout";
    }

    @PostMapping("/confirm-checkout")
    public String confirmCheckout(@ModelAttribute("cart") Cart cart,
            @RequestParam(value = "selectedCartDetailIds", required = false) List<Long> selectedCartDetailIds,
            HttpServletRequest request) {
        // [Giữ nguyên code hiện tại]
        if (selectedCartDetailIds == null || selectedCartDetailIds.isEmpty()) {
            return "redirect:/cart";
        }

        List<CartDetail> cartDetails = cart == null ? new ArrayList<>() : cart.getCartDetails();
        this.productService.handleUpdateCartBeforeCheckout(cartDetails);
        request.getSession().setAttribute("selectedCartDetailIds", selectedCartDetailIds);
        return "redirect:/checkout";
    }

    @PostMapping("/place-order")
    public String handlePlaceOrder(
            HttpServletRequest request,
            @RequestParam("receiverName") String receiverName,
            @RequestParam("receiverAddress") String receiverAddress,
            @RequestParam("receiverPhone") String receiverPhone,
            RedirectAttributes redirectAttributes) {
        // [Giữ nguyên code hiện tại]
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null)
            return "redirect:/login";

        long userId = (long) session.getAttribute("id");
        User currentUser = this.userService.getUserByID(userId);

        @SuppressWarnings("unchecked")
        List<Long> selectedCartDetailIds = (List<Long>) session.getAttribute("selectedCartDetailIds");
        if (selectedCartDetailIds == null || selectedCartDetailIds.isEmpty())
            return "redirect:/cart";

        String errorMsg = this.productService.handlePlaceOrder(currentUser, session, receiverName, receiverAddress,
                receiverPhone, selectedCartDetailIds);

        if (errorMsg != null) {
            redirectAttributes.addFlashAttribute("error", errorMsg);
            return "redirect:/checkout";
        }

        session.removeAttribute("selectedCartDetailIds");
        return "redirect:/thanks";
    }

    @GetMapping("/thanks")
    public String getThankYouPage() {
        return "client/cart/thanks";
    }

    @GetMapping("/order-history")
    public String getOrderHistoryPage(Model model, HttpServletRequest request) {
        // [Giữ nguyên code hiện tại]
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null)
            return "redirect:/login";

        long userId = (long) session.getAttribute("id");
        User currentUser = this.userService.getUserByID(userId);

        List<Order> orders = this.orderService.fetchOrderByUser(currentUser);
        model.addAttribute("orders", orders);
        return "client/cart/order-history";
    }

    @GetMapping("/order-history/{id}")
    public String getOrderDetailPage(Model model, HttpServletRequest request, @PathVariable long id) {
        // [Giữ nguyên code hiện tại]
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null)
            return "redirect:/login";
        long userId = (long) session.getAttribute("id");

        Optional<Order> orderOpt = this.orderService.fetchOrderById(id);
        if (orderOpt.isPresent()) {
            Order order = orderOpt.get();
            if (order.getUser().getId() != userId)
                return "redirect:/order-history";
            model.addAttribute("order", order);
            return "client/cart/order-detail";
        }
        return "redirect:/order-history";
    }

    @PostMapping("/order-history/update")
    public String updateOrderInfo(HttpServletRequest request,
            @RequestParam("orderId") long orderId,
            @RequestParam("receiverName") String receiverName,
            @RequestParam("receiverAddress") String receiverAddress,
            @RequestParam("receiverPhone") String receiverPhone,
            RedirectAttributes ra) {
        // [Giữ nguyên code hiện tại]
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null)
            return "redirect:/login";
        long userId = (long) session.getAttribute("id");

        Optional<Order> orderOpt = this.orderService.fetchOrderById(orderId);
        if (orderOpt.isPresent()) {
            Order order = orderOpt.get();
            if (order.getUser().getId() == userId && "PENDING".equals(order.getStatus())) {
                order.setReceiverName(receiverName);
                order.setReceiverAddress(receiverAddress);
                order.setReceiverPhone(receiverPhone);
                this.orderService.saveOrder(order);
                ra.addFlashAttribute("success", "Cập nhật thông tin nhận hàng thành công!");
            } else {
                ra.addFlashAttribute("error", "Đơn hàng đang giao, không thể cập nhật!");
            }
        }
        return "redirect:/order-history/" + orderId;
    }

    @PostMapping("/order-history/cancel")
    public String cancelOrder(HttpServletRequest request, @RequestParam("orderId") long orderId,
            RedirectAttributes ra) {
        // [Giữ nguyên code hiện tại]
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null)
            return "redirect:/login";
        long userId = (long) session.getAttribute("id");

        Optional<Order> orderOpt = this.orderService.fetchOrderById(orderId);
        if (orderOpt.isPresent()) {
            Order order = orderOpt.get();
            if (order.getUser().getId() == userId && "PENDING".equals(order.getStatus())) {
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
        return this.orderService.fetchOrderById(id).orElse(null);
    }

    @PostMapping("/api/update-cart-quantity")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> updateCartQuantityApi(
            @RequestParam("cartDetailId") long cartDetailId,
            @RequestParam("quantity") long quantity,
            HttpServletRequest request) {
        // [Giữ nguyên code hiện tại]
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null) {
            Map<String, Object> error = new HashMap<>();
            error.put("success", false);
            error.put("message", "Vui lòng đăng nhập");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(error);
        }

        Map<String, Object> result = this.productService.handleUpdateCartQuantity(cartDetailId, quantity);
        return ResponseEntity.ok(result);
    }
}