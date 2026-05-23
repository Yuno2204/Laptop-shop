<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8" />
                <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                <title>Trang chủ - LongHang Mobile</title>

                <link rel="preconnect" href="https://fonts.googleapis.com">
                <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                <link
                    href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
                    rel="stylesheet">

                <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
                <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
                    rel="stylesheet">

                <link href="/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
                <link href="/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

                <link href="/client/css/bootstrap.min.css" rel="stylesheet">
                <link href="/client/css/style.css" rel="stylesheet">

                <style>
                    body {
                        background-color: #f4f6f8;
                        font-family: 'Open Sans', sans-serif;
                    }

                    /* =========================================================
           KHUNG BO SẢN PHẨM (SHOWCASE BOX)
           ========================================================= */
                    .showcase-box {
                        background-color: #fff;
                        border-radius: 16px;
                        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
                        padding: 25px;
                        margin-bottom: 40px;
                    }

                    .showcase-header {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        margin-bottom: 25px;
                        border-bottom: 2px solid #f4f6f8;
                        padding-bottom: 15px;
                    }

                    .showcase-title {
                        font-family: 'Raleway', sans-serif;
                        font-size: 22px;
                        font-weight: 800;
                        color: #333;
                        text-transform: uppercase;
                        margin: 0;
                        display: flex;
                        align-items: center;
                        gap: 10px;
                    }

                    .showcase-title i {
                        color: #d32f2f;
                        font-size: 28px;
                    }

                    /* PRODUCT CARD (Giữ nguyên độ xịn sò) */
                    .product-card {
                        background: #fff;
                        border-radius: 12px;
                        border: 1px solid #f0f0f0;
                        padding: 15px;
                        transition: all 0.3s ease;
                        display: flex;
                        flex-direction: column;
                        height: 100%;
                        position: relative;
                    }

                    .product-card:hover {
                        transform: translateY(-5px);
                        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.08);
                        border-color: #d32f2f;
                    }

                    .product-card img {
                        max-height: 200px;
                        width: 100%;
                        object-fit: contain;
                        transition: 0.3s;
                        margin-bottom: 15px;
                    }

                    .product-card:hover img {
                        transform: scale(1.05);
                    }

                    .p-name {
                        font-size: 14px;
                        font-weight: 600;
                        color: #333;
                        text-decoration: none;
                        display: -webkit-box;
                        -webkit-line-clamp: 2;
                        -webkit-box-orient: vertical;
                        overflow: hidden;
                        height: 42px;
                        margin-bottom: 8px;
                    }

                    .p-name:hover {
                        color: #d32f2f;
                    }

                    .p-price {
                        font-size: 17px;
                        font-weight: 800;
                        color: #d32f2f;
                    }

                    .specs-mini {
                        display: flex;
                        flex-wrap: nowrap;
                        /* ÉP TẤT CẢ PHẢI NẰM TRÊN 1 DÒNG DUY NHẤT */
                        gap: 5px;
                        margin: 10px 0;
                        overflow-x: auto;
                        /* Nếu dài quá thì cho phép vuốt ngang */
                        scrollbar-width: none;
                        /* Ẩn thanh cuộn (dành cho Firefox) */
                        padding-bottom: 2px;
                    }

                    /* Ẩn thanh cuộn xấu xí (dành cho Chrome, Safari, Edge) */
                    .specs-mini::-webkit-scrollbar {
                        display: none;
                    }

                    .specs-mini span {
                        background: #f1f2f6;
                        color: #555;
                        padding: 3px 8px;
                        /* Tăng padding 2 bên cho rộng rãi */
                        border-radius: 4px;
                        font-size: 11px;
                        font-weight: 600;
                        /* In đậm lên một chút cho dễ đọc */
                        white-space: nowrap;
                        /* BÍ QUYẾT LÀ ĐÂY: KHÔNG CHO CẮT CHỮ XUỐNG DÒNG */
                    }

                    .btn-outline-danger {
                        color: #d32f2f;
                        border-color: #d32f2f;
                    }

                    .btn-outline-danger:hover {
                        background-color: #d32f2f;
                        color: #fff;
                    }

                    .badge-hot {
                        position: absolute;
                        top: 10px;
                        left: 10px;
                        background-color: #d32f2f;
                        color: white;
                        font-size: 11px;
                        font-weight: bold;
                        padding: 4px 10px;
                        border-radius: 6px;
                        z-index: 2;
                    }

                    /* Hiệu ứng nhấp nháy cho icon Lửa */
                    @keyframes fire-flicker {
                        0% {
                            transform: scale(1);
                            opacity: 1;
                        }

                        50% {
                            transform: scale(1.1);
                            opacity: 0.8;
                        }

                        100% {
                            transform: scale(1);
                            opacity: 1;
                        }
                    }

                    .fire-icon {
                        animation: fire-flicker 1.5s infinite;
                    }
                </style>
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
            </head>

            <body>

                <div id="spinner"
                    class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50 d-flex align-items-center justify-content-center">
                    <div class="spinner-grow text-danger" role="status"></div>
                </div>

                <jsp:include page="../layout/header.jsp" />
                <jsp:include page="../layout/banner.jsp" />

                <div class="container-fluid py-5">
                    <div class="container">

                        <div class="showcase-box">
                            <div class="showcase-header">
                                <h2 class="showcase-title">
                                    <i class="fas fa-fire fire-icon"></i> SẢN PHẨM BÁN CHẠY NHẤT
                                </h2>
                                <a href="/products" class="text-danger fw-bold text-decoration-none">Xem tất cả <i
                                        class="fas fa-chevron-right ms-1"></i></a>
                            </div>

                            <div class="row g-3">
                                <c:forEach items="${products}" var="product" end="11">
                                    <div class="col-6 col-md-4 col-lg-3 col-xl-3">
                                        <div class="product-card">
                                            <div class="badge-hot">Bán chạy</div>
                                            <a href="/product/${product.id}" class="text-center">
                                                <img src="/images/product/${product.image}" class="img-fluid"
                                                    alt="${product.name}"
                                                    onerror="this.src='/client/img/single-item.jpg'">
                                            </a>
                                            <div class="mt-auto">
                                                <a href="/product/${product.id}" class="p-name">${product.name}</a>

                                                <div class="specs-mini">
                                                    <c:if test="${not empty product.screenSize}">
                                                        <span><i class="fas fa-mobile-alt"></i>
                                                            ${product.screenSize}</span>
                                                    </c:if>
                                                    <c:if test="${not empty product.ram}">
                                                        <span><i class="fas fa-memory"></i> ${product.ram}</span>
                                                    </c:if>
                                                    <c:if test="${not empty product.rom}">
                                                        <span><i class="fas fa-hdd"></i> ${product.rom}</span>
                                                    </c:if>
                                                    <c:if test="${not empty product.battery}">
                                                        <span><i class="fas fa-battery-full"></i>
                                                            ${product.battery}</span>
                                                    </c:if>
                                                </div>

                                                <div class="p-price mb-3">
                                                    <fmt:formatNumber value="${product.price}" pattern="#,###" />đ
                                                </div>

                                                <form action="/add-product-to-cart/${product.id}" method="post"
                                                    class="m-0">
                                                    <input type="hidden" name="${_csrf.parameterName}"
                                                        value="${_csrf.token}" />
                                                    <c:choose>
                                                        <c:when test="${empty sessionScope.email}">
                                                            <button type="button" onclick="requireLogin()"
                                                                class="btn btn-outline-danger w-100 rounded-pill fw-bold"
                                                                style="font-size: 13px;">
                                                                Thêm vào giỏ hàng
                                                            </button>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <button type="submit"
                                                                class="btn btn-outline-danger w-100 rounded-pill fw-bold"
                                                                style="font-size: 13px;">
                                                                Thêm vào giỏ hàng
                                                            </button>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>

                <jsp:include page="../layout/feature.jsp" />
                <jsp:include page="../layout/footer.jsp" />

                <a href="#" class="btn btn-danger border-3 border-danger rounded-circle back-to-top"><i
                        class="fa fa-arrow-up"></i></a>

                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
                <script src="/client/lib/easing/easing.min.js"></script>
                <script src="/client/lib/waypoints/waypoints.min.js"></script>
                <script src="/client/lib/lightbox/js/lightbox.min.js"></script>
                <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>

                <script src="/client/js/main.js"></script>
                <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>

                <script>
                    function requireLogin() {
                        // Cấu hình hiển thị cho Toastr
                        toastr.options = {
                            "closeButton": true,
                            "progressBar": true,
                            "positionClass": "toast-top-right",
                            "timeOut": "2000" // Hiển thị 2 giây
                        };

                        // Hiện thông báo cảnh báo
                        toastr.warning('Bạn cần phải đăng nhập để mua hàng!', 'Thông báo');

                        // Chờ 2 giây để người dùng đọc thông báo rồi mới tự động chuyển hướng sang trang đăng nhập
                        setTimeout(function () {
                            window.location.href = '/login';
                        }, 2000);
                    }
                </script>

                <c:if test="${sessionScope.showWelcome == true}">
                    <script>
                        $(document).ready(function () {
                            toastr.options = {
                                "closeButton": true,
                                "progressBar": true,
                                "positionClass": "toast-top-right",
                                "timeOut": "3000" // Hiển thị 3 giây
                            };

                            // Có thể dùng ${sessionScope.fullName} để gọi tên người dùng cho thân thiện
                            toastr.success('Chào mừng ${sessionScope.fullName} đến với cửa hàng LongHang Mobile!', 'Đăng nhập thành công');
                        });
                    </script>

                    <%-- Lệnh này rất quan trọng: Xóa biến session ngay sau khi dùng để ấn F5 không bị hiện lại thông
                        báo --%>
                        <c:remove var="showWelcome" scope="session" />
                </c:if>
                <c:if test="${param.logout == 'success'}">
                    <script>
                        $(document).ready(function () {
                            toastr.options = {
                                "closeButton": true,
                                "progressBar": true,
                                "positionClass": "toast-top-right",
                                "timeOut": "3000"
                            };

                            toastr.info('Bạn đã đăng xuất thành công. Hẹn gặp lại!', 'Thông báo');

                            // Xử lý làm sạch URL (xóa chữ ?logout=success) để trông chuyên nghiệp hơn
                            if (window.history.replaceState) {
                                const url = window.location.protocol + "//" + window.location.host + window.location.pathname;
                                window.history.replaceState({ path: url }, '', url);
                            }
                        });
                    </script>
                </c:if>
            </body>

            </html>