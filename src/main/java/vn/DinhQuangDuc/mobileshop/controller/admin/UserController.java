package vn.DinhQuangDuc.mobileshop.controller.admin;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.Valid;
import vn.DinhQuangDuc.mobileshop.domain.User;
import vn.DinhQuangDuc.mobileshop.dto.UserSearchDTO;
import vn.DinhQuangDuc.mobileshop.service.ExcelExportService;
import vn.DinhQuangDuc.mobileshop.service.UploadService;
import vn.DinhQuangDuc.mobileshop.service.UserService;

@Controller
public class UserController {
    private final UserService userService;
    private final UploadService uploadService;
    private final PasswordEncoder passwordEncoder;
    private final ExcelExportService excelExportService;

    public UserController(UserService userService, UploadService uploadService,
            PasswordEncoder passwordEncoder, ExcelExportService excelExportService) {
        this.userService = userService;
        this.uploadService = uploadService;
        this.passwordEncoder = passwordEncoder;
        this.excelExportService = excelExportService;
    }

    @GetMapping("/admin/user")
    public String getUserPage(Model model, @RequestParam(value = "page", defaultValue = "1") int page) {
        List<User> users = this.userService.getAllUsers();

        int pageSize = 10;
        int totalItems = users.size();
        int totalPages = (int) Math.ceil((double) totalItems / pageSize);
        if (totalPages == 0)
            totalPages = 1;
        if (page < 1)
            page = 1;
        if (page > totalPages)
            page = totalPages;

        int startItem = (page - 1) * pageSize;
        int endItem = Math.min(startItem + pageSize, totalItems);
        List<User> pagedUsers = users.subList(startItem, endItem);

        model.addAttribute("users1", pagedUsers);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);

        return "admin/user/show";
    }

    @GetMapping("/admin/user/create")
    public String getCreateUserPage(Model model) {
        this.userService.handleHello();
        model.addAttribute("newUser", new User());
        return "admin/user/create";
    }

    @PostMapping("/admin/user/create")
    public String createUserPage(Model model,
            @ModelAttribute("newUser") @Valid User cen,
            BindingResult bindingResult,
            // Thêm required = false để không bị lỗi 400 Bad Request
            @RequestParam(value = "imagesFile", required = false) MultipartFile file) {
        if (this.userService.checkEmailExist(cen.getEmail())) {
            bindingResult.rejectValue("email", "error.newUser", "Email này đã tồn tại, vui lòng sử dụng email khác");
        }
        // Bắt lỗi bắt buộc chọn ảnh
        if (file == null || file.isEmpty() || file.getOriginalFilename().isEmpty()) {
            bindingResult.rejectValue("avatar", "error.user", "Vui lòng chọn ảnh đại diện");
        }

        if (bindingResult.hasErrors()) {
            return "admin/user/create";
        }

        String avatar = this.uploadService.handleSaveUploadFile(file, "avatar");
        String hashPassword = this.passwordEncoder.encode(cen.getPassword());
        cen.setAvatar(avatar);
        cen.setPassword(hashPassword);
        cen.setRole(this.userService.getRoleByName(cen.getRole().getName()));
        this.userService.handleSaveUser(cen);
        return "redirect:/admin/user";
    }

    @GetMapping("/admin/user/{id}")
    public String getUserDetailPage(Model model, @PathVariable long id) {
        User user = this.userService.getUserByID(id);
        model.addAttribute("user", user);
        model.addAttribute("id", id);
        return "admin/user/detail";
    }

    @GetMapping("/admin/user/update/{id}")
    public String getUpdateUserPage(Model model, @PathVariable long id) {
        User crrentUser = this.userService.getUserByID(id);
        model.addAttribute("newUser", crrentUser);
        return "admin/user/update";
    }

    @PostMapping("/admin/user/update")
    public String postUpdateUserPage(Model model,
            @ModelAttribute("newUser") @Valid User cen, // Đã thêm @Valid
            BindingResult bindingResult, // Đã thêm BindingResult
            @RequestParam(value = "imagesFile", required = false) MultipartFile file) {

        // Bắt lỗi đỏ trả về trang update nếu nhập sai
        if (bindingResult.hasErrors()) {
            return "admin/user/update";
        }

        User currentUser = this.userService.getUserByID(cen.getId());
        if (currentUser != null) {
            // Cập nhật ảnh nếu có chọn file mới
            if (file != null && !file.isEmpty()) {
                String avatar = this.uploadService.handleSaveUploadFile(file, "avatar");
                currentUser.setAvatar(avatar);
            }

            currentUser.setAddress(cen.getAddress());
            currentUser.setFullName(cen.getFullName());
            currentUser.setPhone(cen.getPhone());
            currentUser.setGender(cen.getGender());
            currentUser.setDateOfBirth(cen.getDateOfBirth());
            this.userService.handleSaveUser(currentUser);
        }
        return "redirect:/admin/user";
    }

    @GetMapping("/admin/user/delete/{id}")
    public String getDeleteUserPage(Model model, @PathVariable long id) {
        model.addAttribute("id", id);
        model.addAttribute("newUser", new User());
        return "admin/user/delete";
    }

    @PostMapping("/admin/user/delete")
    public String postDeleteUserPage(Model model, @ModelAttribute("newUser") User cen) {
        this.userService.deleteUser(cen.getId());
        return "redirect:/admin/user";
    }

    @GetMapping("/admin/user/search")
    @ResponseBody
    public ResponseEntity<List<UserSearchDTO>> searchUser(@RequestParam(defaultValue = "") String keyword) {
        List<UserSearchDTO> users = userService.searchUserAjax(keyword);
        return ResponseEntity.ok(users);
    }

    @GetMapping("/admin/user/export")
    public void exportUsersToExcel(HttpServletResponse response) {
        try {
            List<User> users = this.userService.getAllUsers();
            this.excelExportService.exportUsers(response, users);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}