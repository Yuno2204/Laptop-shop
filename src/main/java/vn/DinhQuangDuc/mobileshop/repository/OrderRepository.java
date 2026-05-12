package vn.DinhQuangDuc.mobileshop.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import vn.DinhQuangDuc.mobileshop.domain.Order;
import vn.DinhQuangDuc.mobileshop.domain.User;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {
    List<Order> findByUser(User user);

    // Thêm hàm tìm kiếm đơn hàng theo tên người nhận hoặc số điện thoại
    @Query("SELECT o FROM Order o WHERE LOWER(o.receiverName) LIKE LOWER(CONCAT('%', :keyword, '%')) OR o.receiverPhone LIKE CONCAT('%', :keyword, '%')")
    List<Order> searchByKeyword(@Param("keyword") String keyword);

    @Query("SELECT o FROM Order o WHERE o.status IN ('DELIVERED', 'SUCCESS') AND o.deliveredDate >= :startDate AND o.deliveredDate <= :endDate")
    List<Order> findRevenueOrders(@Param("startDate") LocalDateTime startDate, @Param("endDate") LocalDateTime endDate);
}
