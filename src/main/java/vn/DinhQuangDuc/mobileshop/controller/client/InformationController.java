package vn.DinhQuangDuc.mobileshop.controller.client;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class InformationController {

    @GetMapping("/about")
    public String getAboutPage(Model model) {
        model.addAttribute("pageTitle", "Giới thiệu về LongHang Mobile");
        model.addAttribute("viewType", "about");
        return "client/information/show";
    }

    @GetMapping("/policy/{type}")
    public String getPolicyPage(@PathVariable String type, Model model) {
        String title = "";
        switch (type) {
            case "warranty":
                title = "Chính sách bảo hành";
                break;
            case "return":
                title = "Chính sách đổi trả";
                break;
            case "privacy":
                title = "Chính sách bảo mật";
                break;
            case "terms":
                title = "Điều khoản sử dụng";
                break;
            case "faq":
                title = "Câu hỏi thường gặp";
                break;
            default:
                return "client/auth/deny";
        }
        model.addAttribute("pageTitle", title);
        model.addAttribute("viewType", type);
        return "client/information/show";
    }
}