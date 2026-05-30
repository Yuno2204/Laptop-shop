package vn.DinhQuangDuc.mobileshop.controller.client;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import vn.DinhQuangDuc.mobileshop.domain.Notification;
import vn.DinhQuangDuc.mobileshop.domain.User;
import vn.DinhQuangDuc.mobileshop.service.NotificationService;
import vn.DinhQuangDuc.mobileshop.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/notifications")
public class NotificationController {

    private final NotificationService notificationService;
    private final UserService userService;

    public NotificationController(NotificationService notificationService, UserService userService) {
        this.notificationService = notificationService;
        this.userService = userService;
    }

    @GetMapping
    public ResponseEntity<?> getUserNotifications(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null) {
            return ResponseEntity.status(401).body("Unauthorized");
        }

        long userId = (long) session.getAttribute("id");
        User user = userService.getUserByID(userId);

        List<Notification> notifications = notificationService.getNotificationsByUser(user);
        long unreadCount = notificationService.getUnreadCount(user);

        // Chuyển sang DTO bằng Map để tránh lỗi lặp JSON (Infinite Recursion) của
        // Hibernate
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm dd/MM/yyyy");
        List<Map<String, Object>> notifList = notifications.stream().map(n -> {
            Map<String, Object> map = new HashMap<>();
            map.put("id", n.getId());
            map.put("title", n.getTitle());
            map.put("content", n.getContent());
            map.put("read", n.isRead());
            map.put("orderId", n.getOrder().getId());
            map.put("createdAt", n.getCreatedAt().format(formatter));
            return map;
        }).collect(Collectors.toList());

        Map<String, Object> response = new HashMap<>();
        response.put("notifications", notifList);
        response.put("unreadCount", unreadCount);

        return ResponseEntity.ok(response);
    }

    @PostMapping("/read/{id}")
    public ResponseEntity<?> markAsRead(@PathVariable long id, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null) {
            return ResponseEntity.status(401).body("Unauthorized");
        }
        notificationService.markAsRead(id);
        return ResponseEntity.ok().build();
    }
}