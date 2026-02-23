package vn.hoidanit.laptopshop;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {
    @GetMapping("/")
    public String index() {
        return "Hello World with Cen!";
    }

    @GetMapping("/user")
    public String userPage() {
        return "Only User!";
    }

    @GetMapping("/admin")
    public String adminPage() {
        return "Only Admin!";
    }
}