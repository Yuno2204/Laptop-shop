package vn.DinhQuangDuc.mobileshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import vn.DinhQuangDuc.mobileshop.domain.Notification;
import vn.DinhQuangDuc.mobileshop.domain.User;

import java.util.List;

@Repository
public interface NotificationRepository extends JpaRepository<Notification, Long> {
    // Lấy thông báo theo người dùng, sắp xếp mới nhất lên trên
    List<Notification> findByUserOrderByCreatedAtDesc(User user);
    
    // Đếm số lượng thông báo chưa đọc
    long countByUserAndIsReadFalse(User user);
}