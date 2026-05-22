package vn.DinhQuangDuc.mobileshop.service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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

    public List<Order> fetchAllOrders() {
        return this.orderRepository.findAll();
    }

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
                            throw new RuntimeException("Lỗi: Sản phẩm [" + product.getName() + "] không đủ tồn kho!");
                        }
                        product.setQuantity(product.getQuantity() - qty);
                    }
                } else if (oldStatus.equals("CANCELLED") && !newStatus.equals("CANCELLED")
                        && !newStatus.equals("DELIVERED")) {
                    if (product.getQuantity() < qty) {
                        throw new RuntimeException("Lỗi: Sản phẩm [" + product.getName() + "] không đủ tồn kho!");
                    }
                    product.setQuantity(product.getQuantity() - qty);
                } else if (oldStatus.equals("DELIVERED") && !newStatus.equals("DELIVERED")
                        && !newStatus.equals("CANCELLED")) {
                    product.setSold(product.getSold() - qty);
                }
                this.productRepository.save(product);
            }

            LocalDateTime now = LocalDateTime.now();
            if ("SHIPPING".equals(newStatus)) {
                currentOrder.setShippingDate(now);
                currentOrder.setExpectedDeliveryDate(now.plusDays(3));
            } else if ("DELIVERED".equals(newStatus) || "SUCCESS".equals(newStatus)) {
                currentOrder.setDeliveredDate(now);
            } else if ("CANCELLED".equals(newStatus)) {
                currentOrder.setCancelledDate(now);
            }

            currentOrder.setStatus(newStatus);
            this.orderRepository.save(currentOrder);
        }
    }

    @Transactional
    public void deleteOrderById(long id) {
        Optional<Order> orderOptional = this.fetchOrderById(id);
        if (orderOptional.isPresent()) {
            Order order = orderOptional.get();

            // SỬA LỖI: Hoàn lại số lượng tồn kho nếu đơn hàng bị xóa cứng trực tiếp (mà
            // chưa từng bị hủy)
            if (!"CANCELLED".equals(order.getStatus())) {
                List<OrderDetail> details = order.getOrderDetails();
                for (OrderDetail cd : details) {
                    Product product = cd.getProduct();
                    product.setQuantity(product.getQuantity() + cd.getQuantity());
                    if ("DELIVERED".equals(order.getStatus()) || "SUCCESS".equals(order.getStatus())) {
                        product.setSold(product.getSold() - cd.getQuantity());
                    }
                    this.productRepository.save(product);
                }
            }

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
        if (order.getId() == 0 || order.getOrderDate() == null) {
            order.setOrderDate(LocalDateTime.now());
        }
        this.orderRepository.save(order);
    }

    public List<Order> searchOrder(String keyword) {
        return orderRepository.searchByKeyword(keyword);
    }

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
                o.getOrderDate() != null ? o.getOrderDate().format(formatter) : "",
                o.getDeliveredDate() != null ? o.getDeliveredDate().format(formatter) : ""))
                .collect(Collectors.toList());
    }

    public Order createOrder(Order order) {
        order.setOrderDate(LocalDateTime.now());
        order.setStatus("PENDING");
        return orderRepository.save(order);
    }

    public void updateOrderStatus(long orderId, String newStatus) {
        Order order = orderRepository.findById(orderId).orElse(null);
        if (order != null) {
            order.setStatus(newStatus);
            LocalDateTime now = LocalDateTime.now();
            switch (newStatus) {
                case "SHIPPING":
                    order.setShippingDate(now);
                    order.setExpectedDeliveryDate(now.plusDays(3));
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

    public List<Order> getRevenueByDate(LocalDateTime start, LocalDateTime end) {
        return orderRepository.findRevenueOrders(start, end);
    }

    public Page<Order> fetchOrdersWithPagination(Pageable pageable) {
        return this.orderRepository.findAll(pageable);
    }
}