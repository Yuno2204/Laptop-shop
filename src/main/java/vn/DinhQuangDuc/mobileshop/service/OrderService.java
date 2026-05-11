package vn.DinhQuangDuc.mobileshop.service;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import vn.DinhQuangDuc.mobileshop.domain.Order;
import vn.DinhQuangDuc.mobileshop.domain.OrderDetail;
import vn.DinhQuangDuc.mobileshop.domain.Product;
import vn.DinhQuangDuc.mobileshop.domain.User;
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
            String oldStatus = currentOrder.getStatus();
            String newStatus = order.getStatus();

            // Bỏ qua nếu Admin bấm cập nhật nhưng trạng thái không thay đổi
            if (oldStatus.equals(newStatus)) {
                return;
            }

            // Duyệt qua từng chi tiết đơn hàng để cập nhật Kho và Lượt bán
            List<OrderDetail> details = currentOrder.getOrderDetails();
            for (OrderDetail cd : details) {
                Product product = cd.getProduct();
                long qty = cd.getQuantity();

                // 1. Chuyển sang CANCELLED (Hủy đơn)
                if (!oldStatus.equals("CANCELLED") && newStatus.equals("CANCELLED")) {
                    // Trả lại kho (Quantity +)
                    product.setQuantity(product.getQuantity() + qty);
                    // Nếu trước đó trạng thái là DELIVERED, phải trừ đi số lượng đã bán (Sold -)
                    if (oldStatus.equals("DELIVERED")) {
                        product.setSold(product.getSold() - qty);
                    }
                }
                // 2. Chuyển sang DELIVERED (Giao thành công)
                else if (!oldStatus.equals("DELIVERED") && newStatus.equals("DELIVERED")) {
                    // Tăng lượt bán (Sold +)
                    product.setSold(product.getSold() + qty);
                    // Nếu trước đó đơn bị HỦY (đã hoàn kho), giờ phải trừ kho lại (Quantity -)
                    if (oldStatus.equals("CANCELLED")) {
                        if (product.getQuantity() < qty) {
                            throw new RuntimeException(
                                    "Lỗi: Sản phẩm [" + product.getName() + "] không đủ tồn kho để giao!");
                        }
                        product.setQuantity(product.getQuantity() - qty);
                    }
                }
                // 3. Khôi phục từ CANCELLED về PENDING/SHIPPING
                else if (oldStatus.equals("CANCELLED") && !newStatus.equals("CANCELLED")
                        && !newStatus.equals("DELIVERED")) {
                    // Trừ kho lại (Quantity -)
                    if (product.getQuantity() < qty) {
                        throw new RuntimeException(
                                "Lỗi: Sản phẩm [" + product.getName() + "] không đủ tồn kho để khôi phục đơn hàng!");
                    }
                    product.setQuantity(product.getQuantity() - qty);
                }
                // 4. Hoàn tác từ DELIVERED về PENDING/SHIPPING
                else if (oldStatus.equals("DELIVERED") && !newStatus.equals("DELIVERED")
                        && !newStatus.equals("CANCELLED")) {
                    // Giảm lượt bán xuống (Sold -), tồn kho vẫn đang bị giữ nên không thay đổi
                    product.setSold(product.getSold() - qty);
                }

                // Lưu thay đổi của Product
                this.productRepository.save(product);
            }

            // Cập nhật trạng thái mới cho Order và lưu lại
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
        this.orderRepository.save(order);
    }
}