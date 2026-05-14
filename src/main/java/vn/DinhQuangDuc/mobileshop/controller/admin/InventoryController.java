package vn.DinhQuangDuc.mobileshop.controller.admin;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.DinhQuangDuc.mobileshop.domain.Product;
import vn.DinhQuangDuc.mobileshop.service.ProductService;

import java.util.List;

@Controller
public class InventoryController {

    private final ProductService productService;

    public InventoryController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping("/admin/inventory")
    public String getInventoryPage(Model model,
            @RequestParam(value = "page", defaultValue = "1") int page) {

        Pageable pageable = PageRequest.of(page - 1, 10);
        Page<Product> prs = this.productService.fetchProductsWithPagination(pageable);

        model.addAttribute("products", prs.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", prs.getTotalPages());

        return "admin/inventory/show";
    }

    // Xử lý khi Admin nhập thêm số lượng hàng (Nhập kho)
    @PostMapping("/admin/inventory/import")
    public String importStock(@RequestParam("productId") long productId,
            @RequestParam("addQuantity") int addQuantity,
            RedirectAttributes redirectAttributes) {

        // SỬ DỤNG HÀM ĐÃ CÓ SẴN CỦA BẠN TẠI ĐÂY
        Product currentProduct = this.productService.getProductByID(productId);

        // Kiểm tra xem có tìm thấy sản phẩm không (khác null)
        if (currentProduct != null) {
            // Cộng dồn số lượng mới vào số lượng cũ
            currentProduct.setQuantity(currentProduct.getQuantity() + addQuantity);

            // Lưu lại (Bạn thay "handleSaveProduct" bằng tên hàm lưu Product của bạn nhé)
            this.productService.handleSaveProduct(currentProduct);

            redirectAttributes.addFlashAttribute("successMsg",
                    "Đã nhập thêm " + addQuantity + " sản phẩm cho " + currentProduct.getName());
        } else {
            redirectAttributes.addFlashAttribute("errorMsg", "Không tìm thấy sản phẩm!");
        }

        return "redirect:/admin/inventory";
    }
}