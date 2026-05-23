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
import vn.DinhQuangDuc.mobileshop.dto.ProductDTO;
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
    public String createProduct(@Valid @ModelAttribute("newProduct") ProductDTO productDTO,
            BindingResult bindingResult,
            @RequestParam(value = "imagesFile", required = false) MultipartFile file, // Bổ sung tham số nhận file
            Model model) {
        // 1. Nếu form bị lỗi định dạng
        if (bindingResult.hasErrors()) {
            return "admin/product/create";
        }

        // 2. Nếu dữ liệu an toàn, tiến hành copy thủ công
        Product product = new Product();
        product.setName(productDTO.getName());
        product.setPrice(productDTO.getPrice());
        product.setQuantity(productDTO.getQuantity());
        product.setDetailDesc(productDTO.getDetailDesc());
        product.setShortDesc(productDTO.getShortDesc());
        product.setFactory(productDTO.getFactory());
        product.setTarget(productDTO.getTarget());
        product.setOs(productDTO.getOs());
        product.setRom(productDTO.getRom());
        product.setRam(productDTO.getRam());
        product.setRefreshRate(productDTO.getRefreshRate());
        product.setCpu(productDTO.getCpu());
        product.setScreenSize(productDTO.getScreenSize());
        product.setBattery(productDTO.getBattery());
        product.setFastCharge(productDTO.getFastCharge());

        // --- ĐOẠN CODE XỬ LÝ UPLOAD ẢNH BỔ SUNG ---
        if (file != null && !file.isEmpty()) {
            // Tham số "product" chính là tên thư mục con: static/images/product
            String image = this.uploadService.handleSaveUploadFile(file, "product");
            product.setImage(image); // Lưu tên ảnh vào thực thể
        }
        // ------------------------------------------

        // 3. Lưu xuống Database
        this.productService.handleSaveProduct(product);

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
    public String postUpdateProduct(@Valid @ModelAttribute("newProduct") ProductDTO productDTO,
            BindingResult bindingResult,
            @RequestParam(value = "imagesFile", required = false) MultipartFile file, // 1. Bổ sung nhận file ảnh
            Model model) {

        // BƯỚC 1: Validate form
        if (bindingResult.hasErrors()) {
            return "admin/product/update";
        }

        // BƯỚC 2: Lấy sản phẩm hiện tại từ Database
        Product currentProduct = this.productService.getProductByID(productDTO.getId());

        if (currentProduct != null) {
            // BƯỚC 3: Cập nhật dữ liệu text
            currentProduct.setName(productDTO.getName());
            currentProduct.setPrice(productDTO.getPrice());
            currentProduct.setDetailDesc(productDTO.getDetailDesc());
            currentProduct.setShortDesc(productDTO.getShortDesc());
            currentProduct.setQuantity(productDTO.getQuantity());
            currentProduct.setFactory(productDTO.getFactory());
            currentProduct.setTarget(productDTO.getTarget());
            currentProduct.setOs(productDTO.getOs());
            currentProduct.setRom(productDTO.getRom());
            currentProduct.setRam(productDTO.getRam());
            currentProduct.setRefreshRate(productDTO.getRefreshRate());
            currentProduct.setCpu(productDTO.getCpu());
            currentProduct.setScreenSize(productDTO.getScreenSize());
            currentProduct.setBattery(productDTO.getBattery());
            currentProduct.setFastCharge(productDTO.getFastCharge());

            // --- BƯỚC 4: XỬ LÝ ẢNH MỚI ---
            // Nếu người dùng CÓ CHỌN ảnh mới
            if (file != null && !file.isEmpty()) {
                String img = this.uploadService.handleSaveUploadFile(file, "product");
                currentProduct.setImage(img); // Ghi đè tên ảnh mới
            }
            // LƯU Ý: Nếu file rỗng (không chọn ảnh mới), điều kiện if phía trên sẽ bị bỏ
            // qua.
            // Biến currentProduct vẫn giữ nguyên giá trị image cũ lấy từ Database. Không lo
            // mất ảnh!

            // BƯỚC 5: Lưu xuống DB
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
