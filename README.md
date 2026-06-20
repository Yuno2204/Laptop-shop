src/main/java/vn/DinhQuangDuc/mobileshop/
├── config/              # Cấu hình bảo mật (Spring Security), cấu hình Web MVC, phân quyền thành công.
├── controller/          # Tiếp nhận và xử lý các yêu cầu HTTP request
│   ├── admin/           # Bộ điều hướng quản lý (Dashboard, sản phẩm, người dùng, hóa đơn, kho...)
│   └── client/          # Bộ điều hướng dành cho người mua hàng (Trang chủ, chi tiết sản phẩm, giỏ hàng, tài khoản...)
├── domain/              # Các thực thể Entity ánh xạ trực tiếp xuống cơ sở dữ liệu (User, Product, Order, Cart...)
├── dto/                 # Khung chứa dữ liệu truyền tải giữa các tầng (Data Transfer Object)
├── repository/          # Tầng giao tiếp dữ liệu Spring Data JPA kết nối DB
├── service/             # Tầng xử lý logic nghiệp vụ hệ thống (Business Logic)
│   └── validator/       # Xử lý kiểm tra ràng buộc dữ liệu đăng ký tài khoản, mật khẩu mạnh.
└── MobileshopApplication.java  # File khởi chạy chính của dự án.
