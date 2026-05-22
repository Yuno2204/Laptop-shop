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
            Model model) {
        // 1. Nếu form bị lỗi định dạng (Validation thất bại), trả về lại trang tạo mới
        if (bindingResult.hasErrors()) {
            return "admin/product/create";
        }

        // 2. Nếu dữ liệu an toàn, tiến hành copy thủ công từ DTO sang Entity
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

        // Giữ nguyên logic xử lý upload ảnh nếu có...

        // 3. Lưu xuống Database (Lúc này hàm save sẽ chạy mượt mà không văng Exception)
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
            Model model) {

        // BƯỚC 1: Validate từ form. Nếu có lỗi (như để trống tên, sai định dạng
        // pin...), trả về ngay lập tức
        if (bindingResult.hasErrors()) {
            return "admin/product/update"; // Giữ nguyên form kèm thông báo lỗi màu đỏ
        }

        // BƯỚC 2: Nếu hợp lệ, lấy đối tượng Product thực tế từ Database lên
        Product currentProduct = this.productService.getProductByID(productDTO.getId());

        if (currentProduct != null) {
            // BƯỚC 3: Cập nhật dữ liệu từ DTO sang Entity thực tế
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

            // (Bạn có thể giữ nguyên đoạn code xử lý Upload file ảnh ở đây nếu người dùng
            // có chọn ảnh mới)

            // BƯỚC 4: Lưu xuống cơ sở dữ liệu. Quá trình này không còn bị Exception chặn
            // lại nữa.
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
