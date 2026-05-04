package vn.DinhQuangDuc.mobileshop.service;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import vn.DinhQuangDuc.mobileshop.domain.Order;
import vn.DinhQuangDuc.mobileshop.domain.OrderDetail;
import vn.DinhQuangDuc.mobileshop.repository.OrderDetailRepository;
import vn.DinhQuangDuc.mobileshop.repository.OrderRepository;

@Service
public class OrderService {
    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;

    public OrderService(OrderRepository orderRepository, OrderDetailRepository orderDetailRepository) {
        this.orderRepository = orderRepository;
        this.orderDetailRepository = orderDetailRepository;
    }

    // Lấy tất cả đơn hàng cho trang Admin
    public List<Order> fetchAllOrders() {
        return this.orderRepository.findAll();
    }

    // Lấy chi tiết một đơn hàng theo ID
    public Optional<Order> fetchOrderById(long id) {
        return this.orderRepository.findById(id);
    }

    // Cập nhật trạng thái đơn hàng (PENDING, SHIPPING, DELIVERED, v.v.)
    public void updateOrder(Order order) {
        Optional<Order> orderOptional = this.fetchOrderById(order.getId());
        if (orderOptional.isPresent()) {
            Order currentOrder = orderOptional.get();
            currentOrder.setStatus(order.getStatus());
            this.orderRepository.save(currentOrder);
        }
    }

    // Xóa đơn hàng và các chi tiết liên quan
    public void deleteOrderById(long id) {
        Optional<Order> orderOptional = this.fetchOrderById(id);
        if (orderOptional.isPresent()) {
            Order order = orderOptional.get();
            List<OrderDetail> details = order.getOrderDetails();
            // Xóa hết các chi tiết đơn hàng trước
            for (OrderDetail cd : details) {
                this.orderDetailRepository.deleteById(cd.getId());
            }
            // Sau đó mới xóa đơn hàng chính
            this.orderRepository.deleteById(id);
        }
    }
}