package vn.DinhQuangDuc.mobileshop.controller.client;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import vn.DinhQuangDuc.mobileshop.domain.User;
import vn.DinhQuangDuc.mobileshop.service.UserService;

@Controller
public class AccountController {
    private final UserService userService;
    private final PasswordEncoder passwordEncoder;

    public AccountController(UserService userService, PasswordEncoder passwordEncoder) {
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;
    }

    @GetMapping("/account")
    public String getAccountPage(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null) {
            return "redirect:/login";
        }
        long userId = (long) session.getAttribute("id");
        User currentUser = this.userService.getUserByID(userId);
        model.addAttribute("user", currentUser);

        return "client/account/show";
    }

    @PostMapping("/account/update")
    public String updateAccount(@ModelAttribute("user") User user, HttpServletRequest request) {
        this.userService.updateUserProfile(user);
        request.getSession().setAttribute("fullName", user.getFullName());
        return "redirect:/account?success=profile";
    }

    @PostMapping("/account/change-password")
    public String changePassword(HttpServletRequest request,
            @RequestParam("oldPassword") String oldPassword,
            @RequestParam("newPassword") String newPassword,
            @RequestParam("confirmPassword") String confirmPassword,
            RedirectAttributes ra) {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null) {
            return "redirect:/login";
        }

        long userId = (long) session.getAttribute("id");
        User user = this.userService.getUserByID(userId);

        // 1. Kiểm tra mật khẩu cũ có đúng không
        if (!this.passwordEncoder.matches(oldPassword, user.getPassword())) {
            ra.addFlashAttribute("pwdError", "Mật khẩu hiện tại không chính xác!");
            return "redirect:/account?tab=password"; // Truyền tham số tab để UI tự mở đúng tab
        }

        // 2. Kiểm tra độ dài mật khẩu mới
        if (newPassword.length() < 8) {
            ra.addFlashAttribute("pwdError", "Mật khẩu mới phải có ít nhất 8 ký tự!");
            return "redirect:/account?tab=password";
        }

        // 3. Kiểm tra mật khẩu mới và xác nhận có khớp không
        if (!newPassword.equals(confirmPassword)) {
            ra.addFlashAttribute("pwdError", "Xác nhận mật khẩu mới không khớp!");
            return "redirect:/account?tab=password";
        }

        // 4. Mã hóa BCrypt và Lưu vào database
        String hashedNewPassword = this.passwordEncoder.encode(newPassword);
        user.setPassword(hashedNewPassword);

        // Gọi hàm save có sẵn trong UserService
        this.userService.handleSaveUser(user);

        ra.addFlashAttribute("pwdSuccess", "Đổi mật khẩu thành công! Hãy dùng mật khẩu mới cho lần đăng nhập sau.");
        return "redirect:/account?tab=password";
    }
}