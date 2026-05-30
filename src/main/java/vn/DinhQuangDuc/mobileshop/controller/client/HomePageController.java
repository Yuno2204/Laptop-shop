package vn.DinhQuangDuc.mobileshop.controller.client;

import java.util.List;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import vn.DinhQuangDuc.mobileshop.domain.Product;
import vn.DinhQuangDuc.mobileshop.domain.User;
import vn.DinhQuangDuc.mobileshop.dto.RegisterDTO;
import vn.DinhQuangDuc.mobileshop.service.ProductService;
import vn.DinhQuangDuc.mobileshop.service.UploadService;
import vn.DinhQuangDuc.mobileshop.service.UserService;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

@Controller
public class HomePageController {
    private final ProductService productService;
    private final UserService userService;
    private final PasswordEncoder passwordEncoder;
    private final UploadService uploadService;

    public HomePageController(ProductService productService, UserService userService, PasswordEncoder passwordEncoder,
            UploadService uploadService) {
        this.productService = productService;
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;
        this.uploadService = uploadService;
    }

    @GetMapping("/")
    public String getHomePage(Model model) {
        List<Product> products = this.productService.fetchProducts();
        if (products != null && !products.isEmpty()) {
            products.sort((p1, p2) -> {
                long sold1 = p1.getSold();
                long sold2 = p2.getSold();
                return Long.compare(sold2, sold1);
            });
        }
        model.addAttribute("products", products);
        return "client/homepage/show";
    }

    @GetMapping("/register")
    public String getRegisterPage(Model model) {
        model.addAttribute("registerUser", new RegisterDTO());
        return "client/auth/register";
    }

    @PostMapping("/register")
    public String handleRegister(@ModelAttribute("registerUser") @Valid RegisterDTO registerDTO,
            BindingResult bindingResult,
            @RequestParam("avatarFile") MultipartFile avatarFile) {

        if (bindingResult.hasErrors()) {
            return "client/auth/register";
        }
        User user = this.userService.registerDTOtoUser(registerDTO);
        if (!avatarFile.isEmpty()) {
            String avatarFilename = this.uploadService.handleSaveUploadFile(avatarFile, "avatar");
            user.setAvatar(avatarFilename);
        } else {
            user.setAvatar("avatar.jpg");
        }

        String hashPassword = this.passwordEncoder.encode(user.getPassword());
        user.setPassword(hashPassword);
        user.setRole(this.userService.getRoleByName("USER"));
        this.userService.handleSaveUser(user);
        return "redirect:/login?register=success";
    }

    @GetMapping("/login")
    public String getloginPage(Model model) {
        return "client/auth/login";
    }

    @GetMapping("/access-deny")
    public String getDenyPage(Model model) {
        return "client/auth/deny";
    }
}
