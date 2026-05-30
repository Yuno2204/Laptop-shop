package vn.DinhQuangDuc.mobileshop.service;

import org.springframework.stereotype.Service;
import vn.DinhQuangDuc.mobileshop.domain.Notification;
import vn.DinhQuangDuc.mobileshop.domain.Order;
import vn.DinhQuangDuc.mobileshop.domain.User;
import vn.DinhQuangDuc.mobileshop.repository.NotificationRepository;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class NotificationService {
    private final NotificationRepository notificationRepository;

    public NotificationService(NotificationRepository notificationRepository) {
        this.notificationRepository = notificationRepository;
    }

    public void createOrderShippingNotification(Order order) {
        Notification notif = new Notification();
        notif.setTitle("Đơn hàng đang được giao");
        notif.setContent(
                "Đơn hàng #" + order.getId() + " của bạn đã được xác nhận và đang được giao đến địa chỉ nhận hàng.");
        notif.setOrder(order);
        notif.setUser(order.getUser());
        notif.setRead(false);
        notif.setCreatedAt(LocalDateTime.now());
        notificationRepository.save(notif);
    }

    public void createOrderDeliveredNotification(Order order) {
        Notification notif = new Notification();
        notif.setTitle("Đơn hàng giao thành công");
        notif.setContent("Đơn hàng #" + order.getId()
                + " của bạn đã được giao thành công. Cảm ơn bạn đã tin tưởng mua sắm tại LongHang Mobile!");
        notif.setOrder(order);
        notif.setUser(order.getUser());
        notif.setRead(false);
        notif.setCreatedAt(LocalDateTime.now());
        notificationRepository.save(notif);
    }

    public List<Notification> getNotificationsByUser(User user) {
        return notificationRepository.findByUserOrderByCreatedAtDesc(user);
    }

    public long getUnreadCount(User user) {
        return notificationRepository.countByUserAndIsReadFalse(user);
    }

    public void markAsRead(long notificationId) {
        notificationRepository.findById(notificationId).ifPresent(notif -> {
            notif.setRead(true);
            notificationRepository.save(notif);
        });
    }
}