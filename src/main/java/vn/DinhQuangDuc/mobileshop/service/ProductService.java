package vn.DinhQuangDuc.mobileshop.service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jakarta.servlet.http.HttpSession;
import vn.DinhQuangDuc.mobileshop.domain.Cart;
import vn.DinhQuangDuc.mobileshop.domain.CartDetail;
import vn.DinhQuangDuc.mobileshop.domain.Order;
import vn.DinhQuangDuc.mobileshop.domain.OrderDetail;
import vn.DinhQuangDuc.mobileshop.domain.Product;
import vn.DinhQuangDuc.mobileshop.domain.User;
import vn.DinhQuangDuc.mobileshop.dto.ProductSearchDTO;
import vn.DinhQuangDuc.mobileshop.repository.CartDetailRepository;
import vn.DinhQuangDuc.mobileshop.repository.CartRepository;
import vn.DinhQuangDuc.mobileshop.repository.OrderDetailRepository;
import vn.DinhQuangDuc.mobileshop.repository.OrderRepository;
import vn.DinhQuangDuc.mobileshop.repository.ProductRepository;

@Service
public class ProductService {
    private final ProductRepository productRepository;
    private final CartRepository cartRepository;
    private final CartDetailRepository cartDetailRepository;
    private final UserService userService;
    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;

    public ProductService(ProductRepository productRepository, CartRepository cartRepository,
            CartDetailRepository cartDetailRepository, UserService userService, OrderRepository orderRepository,
            OrderDetailRepository orderDetailRepository) {
        this.productRepository = productRepository;
        this.cartRepository = cartRepository;
        this.cartDetailRepository = cartDetailRepository;
        this.userService = userService;
        this.orderRepository = orderRepository;
        this.orderDetailRepository = orderDetailRepository;
    }

    public Product createProduct(Product product) {
        return this.productRepository.save(product);
    }

    public List<Product> fetchProducts() {
        return this.productRepository.findAll();
    }

    public Product getProductByID(long id) {
        return this.productRepository.findById(id);
    }

    public void deleteProduct(long id) {
        this.productRepository.deleteById(id);
    }

    public Product handleSaveProduct(Product product) {
        return this.productRepository.save(product);
    }

    @Transactional // Bắt buộc để đảm bảo tính toàn vẹn dữ liệu
    public String handleAddProductToCart(String email, Long productID, HttpSession session, long quantity) {
        User user = this.userService.getUserByEmail(email);
        if (user == null)
            return "Vui lòng đăng nhập để mua hàng!";

        // 1. CHUẨN HÓA CART: Đảm bảo User chỉ có 1 Cart duy nhất
        Cart cart = this.cartRepository.findByUser(user);
        if (cart == null) {
            Cart newCart = new Cart();
            newCart.setUser(user);
            newCart.setSum(0); // Sum ở đây là SỐ LOẠI SẢN PHẨM KHÁC NHAU
            cart = this.cartRepository.save(newCart);
        }

        Optional<Product> productOpt = this.productRepository.findById(productID);
        if (productOpt.isPresent()) {
            Product realProduct = productOpt.get();
            CartDetail oldDetail = this.cartDetailRepository.findByCartAndProduct(cart, realProduct);

            long currentQtyInCart = (oldDetail != null) ? oldDetail.getQuantity() : 0;
            long requestedTotalQty = currentQtyInCart + quantity;

            // 2. CHẶN VƯỢT TỒN KHO TỪ TRONG TRỨNG NƯỚC
            if (requestedTotalQty > realProduct.getQuantity()) {
                long remaining = realProduct.getQuantity() - currentQtyInCart;
                if (remaining <= 0) {
                    return "Sản phẩm đã đạt giới hạn tồn kho trong giỏ của bạn. Không thể thêm!";
                } else {
                    return "Chỉ có thể thêm tối đa " + remaining + " sản phẩm nữa.";
                }
            }

            // 3. LOGIC XỬ LÝ CART ITEM (Không Duplicate)
            if (oldDetail == null) {
                // TRƯỜNG HỢP A: Sản phẩm MỚI HOÀN TOÀN -> Tạo CartDetail & TĂNG BADGE
                CartDetail cartDetail = new CartDetail();
                cartDetail.setCart(cart);
                cartDetail.setProduct(realProduct);
                cartDetail.setPrice(realProduct.getPrice());
                cartDetail.setQuantity(quantity); // Set đúng quantity yêu cầu
                this.cartDetailRepository.save(cartDetail);

                int newSum = cart.getSum() + 1; // Chỉ tăng badge khi có sản phẩm loại mới
                cart.setSum(newSum);
                this.cartRepository.save(cart);

                // Đồng bộ session cho giao diện hiện tại
                session.setAttribute("sum", newSum);
            } else {
                // TRƯỜNG HỢP B: Đã có sản phẩm -> CHỈ UPDATE QUANTITY, KHÔNG TĂNG BADGE
                oldDetail.setQuantity(requestedTotalQty);
                this.cartDetailRepository.save(oldDetail);
                // cart.getSum() giữ nguyên
            }

            return null; // Return null nghĩa là HOÀN TOÀN THÀNH CÔNG
        } else {
            return "Sản phẩm không tồn tại trên hệ thống!";
        }
    }

    public Cart fetchByUser(User user) {
        return this.cartRepository.findByUser(user);
    }

    public void handleRemoveCartDetail(long cartDetailId, HttpSession session) {
        Optional<CartDetail> cartDetailOptional = this.cartDetailRepository.findById(cartDetailId);

        if (cartDetailOptional.isPresent()) {
            CartDetail cartDetail = cartDetailOptional.get();
            Cart currentCart = cartDetail.getCart();

            this.cartDetailRepository.deleteById(cartDetailId);

            if (currentCart.getSum() > 1) {
                int s = currentCart.getSum() - 1;
                currentCart.setSum(s);
                session.setAttribute("sum", s);
                this.cartRepository.save(currentCart);
            } else {
                this.cartRepository.deleteById(currentCart.getId());
                session.setAttribute("sum", 0);
            }
        }
    }

    public void handleUpdateCartBeforeCheckout(List<CartDetail> cartDetails) {
        for (CartDetail cartDetail : cartDetails) {
            Optional<CartDetail> optional = this.cartDetailRepository.findById(cartDetail.getId());

            if (optional.isPresent()) {
                CartDetail currentCartDetail = optional.get();

                // KIỂM TRA BẢO MẬT: Bắt buộc ép về Max Stock nếu request cố tình gửi vượt
                long maxStock = currentCartDetail.getProduct().getQuantity();
                long requestedQty = cartDetail.getQuantity();

                if (requestedQty > maxStock) {
                    requestedQty = maxStock;
                } else if (requestedQty < 1) {
                    requestedQty = 1;
                }

                currentCartDetail.setQuantity(requestedQty);
                this.cartDetailRepository.save(currentCartDetail);
            }
        }
    }

    @Transactional
    public String handlePlaceOrder(User user, HttpSession session, String receiverName, String receiverAddress,
            String receiverPhone, List<Long> selectedCartDetailIds) { // Bổ sung tham số List<Long>
        Cart cart = this.cartRepository.findByUser(user);
        if (cart != null) {
            List<CartDetail> cartDetails = cart.getCartDetails();
            if (cartDetails != null && !cartDetails.isEmpty()) {

                // 1. Chỉ lấy những CartDetail được khách chọn
                List<CartDetail> selectedDetails = cartDetails.stream()
                        .filter(cd -> selectedCartDetailIds.contains(cd.getId()))
                        .collect(Collectors.toList());

                // 2. Validate số lượng tồn kho (Chỉ validate những sp đang mua)
                for (CartDetail cd : selectedDetails) {
                    if (cd.getQuantity() > cd.getProduct().getQuantity()) {
                        return "Sản phẩm [" + cd.getProduct().getName() + "] không đủ số lượng. Chỉ còn "
                                + cd.getProduct().getQuantity() + " sản phẩm.";
                    }
                }

                // 3. Tạo Order
                Order order = new Order();
                order.setUser(user);
                order.setReceiverName(receiverName);
                order.setReceiverAddress(receiverAddress);
                order.setReceiverPhone(receiverPhone);
                order.setStatus("PENDING");

                double totalPrice = 0;
                for (CartDetail cd : selectedDetails) {
                    totalPrice += (cd.getPrice() * cd.getQuantity());
                }
                order.setTotalPrice(totalPrice);
                order.setOrderDate(LocalDateTime.now());
                order = this.orderRepository.save(order);

                // 4. Lưu OrderDetail & Cập nhật tồn kho
                for (CartDetail cd : selectedDetails) {
                    OrderDetail orderDetail = new OrderDetail();
                    orderDetail.setOrder(order);
                    orderDetail.setProduct(cd.getProduct());
                    orderDetail.setPrice((long) cd.getPrice());
                    orderDetail.setQuantity(cd.getQuantity());
                    this.orderDetailRepository.save(orderDetail);

                    Product product = cd.getProduct();
                    long newQuantity = product.getQuantity() - cd.getQuantity();
                    product.setQuantity(newQuantity);
                    this.productRepository.save(product);
                }

                // 5. Xóa các sản phẩm đã mua khỏi Database
                for (CartDetail cd : selectedDetails) {
                    this.cartDetailRepository.deleteById(cd.getId());
                }

                // 6. Xóa các sản phẩm đã mua khỏi giỏ hàng Memory và tính lại tổng số lượng còn
                // trong giỏ
                cart.getCartDetails().removeIf(cd -> selectedCartDetailIds.contains(cd.getId()));
                cart.setSum(cart.getCartDetails().size());
                this.cartRepository.save(cart);

                session.setAttribute("sum", cart.getSum());
            }
        }
        return null;
    }

    public List<Product> searchProduct(String keyword) {
        return productRepository.searchByKeyword(keyword);
    }

    public List<Product> getAllProducts() {
        return productRepository.findAll();
    }

    public List<ProductSearchDTO> searchProductAjax(String keyword) {
        List<Product> products = keyword.isEmpty() ? productRepository.findAll()
                : productRepository.searchByKeyword(keyword);
        return products.stream().map(p -> new ProductSearchDTO(
                p.getId(), p.getName(), p.getPrice(), p.getQuantity(),
                p.getFactory())).collect(Collectors.toList());
    }

    public Page<Product> fetchProductsWithPagination(Pageable pageable) {
        return this.productRepository.findAll(pageable);
    }
}