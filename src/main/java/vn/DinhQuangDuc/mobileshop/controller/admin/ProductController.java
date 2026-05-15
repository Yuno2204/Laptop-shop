package vn.DinhQuangDuc.mobileshop.controller.admin;

import java.util.List;

import org.springframework.http.ResponseEntity;
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
import vn.DinhQuangDuc.mobileshop.domain.Product;
import vn.DinhQuangDuc.mobileshop.dto.ProductSearchDTO;
import vn.DinhQuangDuc.mobileshop.dto.UserSearchDTO;
import vn.DinhQuangDuc.mobileshop.service.ExcelExportService;
import vn.DinhQuangDuc.mobileshop.service.ProductService;
import vn.DinhQuangDuc.mobileshop.service.UploadService;

@Controller
public class ProductController {
    private final ProductService productService;
    private final UploadService uploadService;
    private final ExcelExportService excelExportService;

    public ProductController(ProductService productService, UploadService uploadService,
            ExcelExportService excelExportService) {
        this.productService = productService;
        this.uploadService = uploadService;
        this.excelExportService = excelExportService;
    }

    @GetMapping("/admin/product")
    public String getDashboard(Model model, @RequestParam(value = "page", defaultValue = "1") int page) {
        List<Product> products = this.productService.fetchProducts();

        // --- XỬ LÝ PHÂN TRANG ---
        int pageSize = 10;
        int totalItems = products.size();
        int totalPages = (int) Math.ceil((double) totalItems / pageSize);
        if (totalPages == 0)
            totalPages = 1;
        if (page < 1)
            page = 1;
        if (page > totalPages)
            page = totalPages;

        int startItem = (page - 1) * pageSize;
        int endItem = Math.min(startItem + pageSize, totalItems);
        List<Product> pagedProducts = products.subList(startItem, endItem);
        // ------------------------

        model.addAttribute("products", pagedProducts);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);

        return "admin/product/show";
    }

    @GetMapping("/admin/product/create") // GET
    public String getCreateUserPage(Model model) {
        model.addAttribute("newProduct", new Product());
        return "admin/product/create";
    }

    @PostMapping("/admin/product/create")
    public String createUserPage(Model model,
            @ModelAttribute("newProduct") @Valid Product product,
            BindingResult bindingResult,
            @RequestParam(value = "imagesFile", required = false) MultipartFile file) {

        if (file == null || file.isEmpty() || file.getOriginalFilename().isEmpty()) {
            bindingResult.rejectValue("image", "error.product", "Vui lòng chọn ảnh cho sản phẩm");
        }

        if (bindingResult.hasErrors()) {
            return "admin/product/create";
        }

        String image = this.uploadService.handleSaveUploadFile(file, "product");
        product.setImage(image);

        product.setSold(0);

        this.productService.createProduct(product);
        return "redirect:/admin/product";
    }

    @GetMapping("/admin/product/{id}")
    public String getUserDetailPage(Model model, @PathVariable long id) {
        Product product = this.productService.getProductByID(id);
        model.addAttribute("product", product);
        model.addAttribute("id", id);
        return "admin/product/detail";
    }

    @GetMapping("/admin/product/update/{id}") // GET
    public String getUpdateProductPage(Model model, @PathVariable long id) {
        Product crrentProduct = this.productService.getProductByID(id);
        model.addAttribute("newProduct", crrentProduct);
        return "admin/product/update";
    }

    @PostMapping("/admin/product/update")
    public String postUpdateProductPage(
            Model model,
            @ModelAttribute("newProduct") @Valid Product product,
            BindingResult bindingResult,
            @RequestParam(value = "imagesFile", required = false) MultipartFile file) {

        if (bindingResult.hasErrors()) {
            return "admin/product/update";
        }

        Product currentProduct = this.productService.getProductByID(product.getId());

        if (currentProduct != null) {
            if (file != null && !file.isEmpty()) {
                String image = this.uploadService.handleSaveUploadFile(file, "product");
                currentProduct.setImage(image);
            }

            currentProduct.setName(product.getName());
            currentProduct.setPrice(product.getPrice());
            currentProduct.setQuantity(product.getQuantity());
            currentProduct.setShortDesc(product.getShortDesc());
            currentProduct.setFactory(product.getFactory());
            currentProduct.setTarget(product.getTarget());
            currentProduct.setOs(product.getOs());
            currentProduct.setRom(product.getRom());
            currentProduct.setRam(product.getRam());
            currentProduct.setRefreshRate(product.getRefreshRate());
            currentProduct.setCpu(product.getCpu());
            currentProduct.setScreenSize(product.getScreenSize());
            currentProduct.setBattery(product.getBattery());
            currentProduct.setFastCharge(product.getFastCharge());
            currentProduct.setDetailDesc(product.getDetailDesc());
            this.productService.handleSaveProduct(currentProduct);
        }

        return "redirect:/admin/product";
    }

    @GetMapping("/admin/product/delete/{id}") // GET
    public String getDeleteUserPage(Model model, @PathVariable long id) {
        model.addAttribute("id", id);
        model.addAttribute("newProduct", new Product());
        return "admin/product/delete";
    }

    @PostMapping("/admin/product/delete") // GET
    public String postDeleteUserPage(Model model, @ModelAttribute("newProduct") Product product) {
        this.productService.deleteProduct(product.getId());
        return "redirect:/admin/product";
    }

    @GetMapping("/admin/product/search")
    @ResponseBody
    public ResponseEntity<List<ProductSearchDTO>> searchProduct(@RequestParam(defaultValue = "") String keyword) {
        List<ProductSearchDTO> products = productService.searchProductAjax(keyword);
        return ResponseEntity.ok(products);
    }

    @GetMapping("/admin/product/export")
    public void exportProductsToExcel(HttpServletResponse response) {
        try {
            // Lấy toàn bộ sản phẩm
            List<Product> products = this.productService.fetchProducts();
            // Xuất báo cáo kho chi tiết
            this.excelExportService.exportProducts(response, products);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
