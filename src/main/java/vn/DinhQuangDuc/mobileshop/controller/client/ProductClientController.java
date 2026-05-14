package vn.DinhQuangDuc.mobileshop.controller.client;

import jakarta.persistence.criteria.Predicate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import vn.DinhQuangDuc.mobileshop.domain.Product;
import vn.DinhQuangDuc.mobileshop.repository.ProductRepository;

import java.util.ArrayList;
import java.util.List;

@Controller
public class ProductClientController {

    @Autowired
    private ProductRepository productRepository;

    @GetMapping("/products")
    public String productPage(Model model,
            @RequestParam(value = "page", defaultValue = "1") int page) {

        Pageable pageable = PageRequest.of(page - 1, 12, Sort.by(Sort.Direction.DESC, "id"));

        // SỬ DỤNG productRepository thay vì productService để không bị lỗi đỏ
        Page<Product> prs = this.productRepository.findAll(pageable);

        model.addAttribute("products", prs.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", prs.getTotalPages());

        return "client/product/show";
    }

    @GetMapping("/api/products/filter")
    @ResponseBody
    public ResponseEntity<?> filterProducts(
            @RequestParam(required = false, defaultValue = "") String keyword,
            @RequestParam(required = false) String os,
            @RequestParam(required = false) String factory,
            @RequestParam(required = false) String target,
            @RequestParam(required = false, value = "ram[]") List<String> rams,
            @RequestParam(required = false, value = "rom[]") List<String> roms,
            @RequestParam(required = false, value = "refreshRate[]") List<String> refreshRates,
            @RequestParam(required = false, value = "battery[]") List<String> batteries,
            @RequestParam(required = false, value = "fastCharge[]") List<String> fastCharges,
            @RequestParam(required = false, value = "screenSize[]") List<String> screenSizes,
            @RequestParam(required = false) String priceRange,
            @RequestParam(required = false, defaultValue = "newest") String sort,
            @RequestParam(defaultValue = "0") int page) {

        Specification<Product> spec = (root, query, cb) -> {
            List<Predicate> predicates = new ArrayList<>();

            // ================= LOG DEBUG =================
            System.out.println("=== BẮT ĐẦU CHẠY FILTER ĐỘNG ===");
            System.out.println("Keyword: " + keyword);
            System.out.println("Factory: " + factory);
            System.out.println("Target: " + target);
            System.out.println("RAM (Khoảng): " + rams);
            System.out.println("ROM (Khoảng): " + roms);
            System.out.println("Screen Size: " + screenSizes);

            // 1. TÌM KIẾM KEYWORD (Bắt buộc gom nhóm OR lại với nhau trước khi đem đi AND)
            if (keyword != null && !keyword.trim().isEmpty()) {
                String searchKw = "%" + keyword.trim().toLowerCase() + "%";
                Predicate nameLike = cb.like(cb.lower(root.get("name")), searchKw);
                Predicate factoryLike = cb.like(cb.lower(root.get("factory")), searchKw);
                predicates.add(cb.or(nameLike, factoryLike));
            }

            // 2. LỌC CHÍNH XÁC SELECT (Ép điều kiện AND)
            if (os != null && !os.trim().isEmpty()) {
                predicates.add(cb.equal(root.get("os"), os.trim()));
            }
            if (factory != null && !factory.trim().isEmpty()) {
                predicates.add(cb.equal(root.get("factory"), factory.trim()));
            }
            if (target != null && !target.trim().isEmpty()) {
                predicates.add(cb.equal(root.get("target"), target.trim()));
            }

            // 3. LỌC THEO MẢNG CHECKBOX
            // Xử lý RAM và ROM (Đã đồng bộ giá trị với Frontend)
            if (rams != null && !rams.isEmpty()) {
                List<String> validRams = rams.stream().filter(s -> !s.isBlank()).toList();
                if (!validRams.isEmpty())
                    predicates.add(root.get("ram").in(validRams));
            }

            if (roms != null && !roms.isEmpty()) {
                List<String> validRoms = roms.stream().filter(s -> !s.isBlank()).toList();
                if (!validRoms.isEmpty())
                    predicates.add(root.get("rom").in(validRoms));
            }

            // Xử lý Tần số quét
            if (refreshRates != null && !refreshRates.isEmpty()) {
                List<String> validRefresh = refreshRates.stream().filter(s -> !s.isBlank()).toList();
                if (!validRefresh.isEmpty())
                    predicates.add(root.get("refreshRate").in(validRefresh));
            }

            // Xử lý Pin (Dùng LIKE để quét chữ đầu tiên do DB lưu dạng String "5000 mAh")
            if (batteries != null && !batteries.isEmpty()) {
                List<Predicate> batPreds = new ArrayList<>();
                for (String b : batteries) {
                    if (b.equals("Dưới 4000mAh")) {
                        batPreds.add(cb.like(root.get("battery"), "3%")); // Bắt pin 3xxx mAh
                        batPreds.add(cb.like(root.get("battery"), "2%")); // Bắt pin 2xxx mAh
                    } else if (b.equals("4000 - 5000mAh")) {
                        batPreds.add(cb.like(root.get("battery"), "4%")); // Bắt pin 4xxx mAh
                        batPreds.add(cb.like(root.get("battery"), "5000%")); // Bắt chuẩn 5000
                    } else if (b.equals("5000 - 6000mAh")) {
                        batPreds.add(cb.like(root.get("battery"), "5%")); // Bắt pin 5xxx mAh
                        batPreds.add(cb.like(root.get("battery"), "6000%")); // Bắt chuẩn 6000
                    } else if (b.equals("Trên 6000mAh")) {
                        batPreds.add(cb.like(root.get("battery"), "6%")); // Bắt pin >6000 mAh
                        batPreds.add(cb.like(root.get("battery"), "7%")); // Bắt pin 7xxx mAh
                    }
                }
                if (!batPreds.isEmpty()) {
                    predicates.add(cb.or(batPreds.toArray(new Predicate[0])));
                }
            }

            // Xử lý Kích thước màn hình (Dùng LIKE quét thập phân do DB lưu String "6.7
            // inch")
            if (screenSizes != null && !screenSizes.isEmpty()) {
                List<Predicate> screenPreds = new ArrayList<>();
                for (String s : screenSizes) {
                    if (s.equals("Dưới 6 inch")) {
                        screenPreds.add(cb.like(root.get("screenSize"), "4.%"));
                        screenPreds.add(cb.like(root.get("screenSize"), "5.%"));
                    } else if (s.equals("6.0 - 6.4 inch")) {
                        screenPreds.add(cb.like(root.get("screenSize"), "6.0%"));
                        screenPreds.add(cb.like(root.get("screenSize"), "6.1%"));
                        screenPreds.add(cb.like(root.get("screenSize"), "6.2%"));
                        screenPreds.add(cb.like(root.get("screenSize"), "6.3%"));
                        screenPreds.add(cb.like(root.get("screenSize"), "6.4%"));
                    } else if (s.equals("6.5 - 6.7 inch")) {
                        screenPreds.add(cb.like(root.get("screenSize"), "6.5%"));
                        screenPreds.add(cb.like(root.get("screenSize"), "6.6%"));
                        screenPreds.add(cb.like(root.get("screenSize"), "6.7%"));
                    } else if (s.equals("Trên 6.7 inch")) {
                        screenPreds.add(cb.like(root.get("screenSize"), "6.8%"));
                        screenPreds.add(cb.like(root.get("screenSize"), "6.9%"));
                        screenPreds.add(cb.like(root.get("screenSize"), "7.%"));
                    }
                }
                if (!screenPreds.isEmpty()) {
                    predicates.add(cb.or(screenPreds.toArray(new Predicate[0])));
                }
            }

            // 4. LỌC GIÁ (Ép điều kiện AND)
            if (priceRange != null && !priceRange.trim().isEmpty()) {
                String p = priceRange.trim();
                if (p.equals("0-5"))
                    predicates.add(cb.lessThan(root.get("price"), 5000000.0));
                else if (p.equals("5-10"))
                    predicates.add(cb.between(root.get("price"), 5000000.0, 10000000.0));
                else if (p.equals("10-20"))
                    predicates.add(cb.between(root.get("price"), 10000000.0, 20000000.0));
                else if (p.equals("20-30"))
                    predicates.add(cb.between(root.get("price"), 20000000.0, 30000000.0));
                else if (p.equals("30-max"))
                    predicates.add(cb.greaterThanOrEqualTo(root.get("price"), 30000000.0));
            }

            // LƯU Ý QUAN TRỌNG: Nối tất cả các filter bằng phép AND
            System.out.println("=> Tổng số điều kiện AND áp dụng: " + predicates.size());
            if (predicates.isEmpty()) {
                return cb.conjunction(); // Không lọc gì cả
            }

            return cb.and(predicates.toArray(new Predicate[0]));
        };

        // Xử lý Sort
        Sort sortObj = Sort.by(Sort.Direction.DESC, "id");
        if ("priceAsc".equals(sort))
            sortObj = Sort.by(Sort.Direction.ASC, "price");
        else if ("priceDesc".equals(sort))
            sortObj = Sort.by(Sort.Direction.DESC, "price");
        else if ("bestSeller".equals(sort))
            sortObj = Sort.by(Sort.Direction.DESC, "sold");

        Page<Product> result = productRepository.findAll(spec, PageRequest.of(page, 12, sortObj));

        System.out.println("=> SỐ LƯỢNG KẾT QUẢ TRẢ VỀ: " + result.getContent().size());
        return ResponseEntity.ok(result);
    }
}