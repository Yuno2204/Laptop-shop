<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <title>Sản phẩm - LongHang Mobile</title>
                <link rel="preconnect" href="https://fonts.googleapis.com">
                <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                <link
                    href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
                    rel="stylesheet">

                <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
                <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
                    rel="stylesheet">

                <link href="/client/css/bootstrap.min.css" rel="stylesheet">
                <link href="/client/css/style.css" rel="stylesheet">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
                <style>
                    body {
                        background-color: #f4f6f8;
                        /* Đã xóa font-family lỗi */
                        padding-top: 100px;
                        /* Thêm padding để không bị Header đè */
                    }

                    /* THANH TÌM KIẾM CỐ ĐỊNH TRÊN CÙNG */
                    .search-box {
                        position: relative;
                        margin-bottom: 25px;
                    }

                    .search-box input {
                        width: 100%;
                        padding: 12px 20px 12px 45px;
                        border-radius: 12px;
                        border: 1px solid #e0e0e0;
                        background: #fff;
                        font-size: 14px;
                        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.03);
                        transition: 0.3s;
                    }

                    .search-box input:focus {
                        border-color: #d32f2f;
                        box-shadow: 0 0 0 3px rgba(211, 47, 47, 0.1);
                        outline: none;
                    }

                    .search-box i {
                        position: absolute;
                        top: 50%;
                        left: 18px;
                        transform: translateY(-50%);
                        color: #888;
                        font-size: 16px;
                    }

                    /* SIDEBAR CHUYÊN NGHIỆP */
                    .filter-sidebar {
                        background: #fff;
                        border-radius: 16px;
                        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.04);
                        padding: 20px;
                        position: sticky;
                        top: 90px;
                        max-height: calc(100vh - 100px);
                        display: flex;
                        flex-direction: column;
                    }

                    .filter-content {
                        overflow-y: auto;
                        padding-right: 5px;
                        flex-grow: 1;
                        margin-bottom: 15px;
                    }

                    .filter-content::-webkit-scrollbar {
                        width: 5px;
                    }

                    .filter-content::-webkit-scrollbar-thumb {
                        background: #dcdcdc;
                        border-radius: 10px;
                    }

                    .filter-section {
                        border-bottom: 1px solid #f0f0f0;
                        padding-bottom: 15px;
                        margin-bottom: 15px;
                    }

                    .filter-section:last-child {
                        border-bottom: none;
                    }

                    .filter-title {
                        font-weight: 700;
                        font-size: 14px;
                        margin-bottom: 10px;
                        color: #222;
                        text-transform: uppercase;
                    }

                    /* TAG BUTTONS */
                    .filter-checkbox {
                        display: none;
                    }

                    .filter-label {
                        background: #f3f4f6;
                        border: 1px solid #e5e7eb;
                        border-radius: 8px;
                        padding: 6px 10px;
                        font-size: 12px;
                        color: #444;
                        cursor: pointer;
                        transition: 0.2s;
                        display: inline-block;
                        flex-grow: 1;
                        text-align: center;
                    }

                    .filter-label:hover {
                        background: #ffebee;
                        border-color: #d32f2f;
                        color: #d32f2f;
                    }

                    .filter-checkbox:checked+.filter-label {
                        background: #d32f2f;
                        border-color: #d32f2f;
                        color: #fff;
                        font-weight: 600;
                    }

                    /* SELECT OPTION */
                    .form-select {
                        border-radius: 8px;
                        font-size: 13px;
                        cursor: pointer;
                        border-color: #e0e0e0;
                    }

                    .form-select:focus {
                        border-color: #d32f2f;
                        box-shadow: none;
                    }

                    /* CỤM NÚT FILTER ACTION */
                    .filter-actions {
                        display: flex;
                        gap: 10px;
                        border-top: 1px solid #eee;
                        padding-top: 15px;
                        background: #fff;
                    }

                    .btn-filter-search {
                        background-color: #d32f2f;
                        color: #fff;
                        border: none;
                        border-radius: 8px;
                        padding: 10px 15px;
                        font-weight: bold;
                        flex: 1;
                        transition: 0.3s;
                        box-shadow: 0 4px 10px rgba(211, 47, 47, 0.2);
                    }

                    .btn-filter-search:hover {
                        background-color: #b71c1c;
                        color: #fff;
                        transform: translateY(-2px);
                    }

                    .btn-clear-filter {
                        background-color: #fff;
                        color: #555;
                        border: 1px solid #ccc;
                        border-radius: 8px;
                        padding: 10px 15px;
                        font-weight: bold;
                        flex: 1;
                        transition: 0.3s;
                    }

                    .btn-clear-filter:hover {
                        background-color: #f8f9fa;
                        border-color: #999;
                    }

                    /* PRODUCT CARD */
                    .product-card {
                        background: #fff;
                        border-radius: 16px;
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
                        object-fit: contain;
                        transition: 0.3s;
                        margin-bottom: 15px;
                    }

                    .product-card:hover img {
                        transform: scale(1.03);
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
                        font-weight: 700;
                        color: #d32f2f;
                    }

                    .specs-mini {
                        display: flex;
                        flex-wrap: wrap;
                        gap: 5px;
                        margin: 10px 0;
                    }

                    .specs-mini span {
                        background: #f1f2f6;
                        color: #555;
                        padding: 3px 6px;
                        border-radius: 4px;
                        font-size: 11px;
                        font-weight: 500;
                    }

                    /* SORT BUTTON */
                    .sort-btn {
                        border: 1px solid #e0e0e0;
                        background: #fff;
                        color: #444;
                        padding: 6px 15px;
                        border-radius: 20px;
                        font-size: 13px;
                        font-weight: 500;
                        transition: 0.2s;
                    }

                    .sort-btn:hover {
                        background: #ffebee;
                        color: #d32f2f;
                        border-color: #d32f2f;
                    }

                    .sort-btn.active {
                        background: #d32f2f;
                        color: #fff;
                        border-color: #d32f2f;
                    }
                </style>
            </head>

            <body>
                <jsp:include page="../layout/header.jsp" />

                <div class="container-fluid py-4 px-xl-5">
                    <div class="row">

                        <div class="col-lg-3 col-md-4 mb-4">
                            <div class="search-box">
                                <i class="fas fa-search"></i>
                                <input type="text" id="searchInput" placeholder="Tìm tên điện thoại...">
                            </div>

                            <div class="filter-sidebar">
                                <h6 class="fw-bold mb-3 text-dark"><i class="fas fa-filter text-danger me-2"></i>BỘ LỌC
                                    TÌM KIẾM</h6>

                                <div class="filter-content">
                                    <div class="filter-section">
                                        <div class="filter-title">Hệ điều hành</div>
                                        <select id="osSelect" class="form-select">
                                            <option value="">Tất cả</option>
                                            <option value="iOS">iOS</option>
                                            <option value="Android">Android</option>
                                        </select>
                                    </div>

                                    <div class="filter-section">
                                        <div class="filter-title">Thương hiệu</div>
                                        <select id="factorySelect" class="form-select">
                                            <option value="">Tất cả</option>
                                            <option value="Apple">Apple</option>
                                            <option value="Samsung">Samsung</option>
                                            <option value="Xiaomi">Xiaomi</option>
                                            <option value="Oppo">Oppo</option>
                                            <option value="Vivo">Vivo</option>
                                            <option value="Nokia">Nokia</option>
                                        </select>
                                    </div>

                                    <div class="filter-section">
                                        <div class="filter-title">Nhu cầu sử dụng</div>
                                        <select id="targetSelect" class="form-select">
                                            <option value="">Tất cả</option>
                                            <option value="Chơi game">Chơi game</option>
                                            <option value="Cấu hình cao">Cấu hình cao</option>
                                            <option value="Pin trâu">Pin trâu</option>
                                            <option value="Chụp ảnh đẹp">Chụp ảnh đẹp</option>
                                            <option value="Mỏng nhẹ">Mỏng nhẹ</option>
                                            <option value="Nhỏ gọn, dễ cầm nắm">Nhỏ gọn, dễ cầm nắm</option>
                                            <option value="Livestream">Livestream</option>
                                        </select>
                                    </div>

                                    <div class="filter-section">
                                        <div class="filter-title">Mức giá</div>
                                        <div class="d-flex flex-wrap gap-2">
                                            <input type="radio" class="filter-checkbox" name="price" value="" id="p0"
                                                checked><label class="filter-label" for="p0">Tất cả</label>
                                            <input type="radio" class="filter-checkbox" name="price" value="0-5"
                                                id="p1"><label class="filter-label" for="p1">Dưới 5 triệu</label>
                                            <input type="radio" class="filter-checkbox" name="price" value="5-10"
                                                id="p2"><label class="filter-label" for="p2">Từ 5 - 10 triệu</label>
                                            <input type="radio" class="filter-checkbox" name="price" value="10-20"
                                                id="p3"><label class="filter-label" for="p3">Từ 10 - 20 triệu</label>
                                            <input type="radio" class="filter-checkbox" name="price" value="20-30"
                                                id="p4"><label class="filter-label" for="p4">Từ 20 - 30 triệu</label>
                                            <input type="radio" class="filter-checkbox" name="price" value="30-max"
                                                id="p5"><label class="filter-label" for="p5">Trên 30 triệu</label>
                                        </div>
                                    </div>

                                    <div class="filter-section">
                                        <div class="filter-title">Dung lượng ROM</div>
                                        <div class="d-flex flex-wrap gap-2">
                                            <input type="checkbox" class="filter-checkbox" name="rom" value="≤128 GB"
                                                id="rom1">
                                            <label class="filter-label" for="rom1">
                                                < 128GB</label>

                                                    <input type="checkbox" class="filter-checkbox" name="rom"
                                                        value="256 GB" id="rom2">
                                                    <label class="filter-label" for="rom2">256GB</label>

                                                    <input type="checkbox" class="filter-checkbox" name="rom"
                                                        value="512 GB" id="rom3">
                                                    <label class="filter-label" for="rom3">512GB</label>

                                                    <input type="checkbox" class="filter-checkbox" name="rom"
                                                        value="1 TB" id="rom4">
                                                    <label class="filter-label" for="rom4">1TB</label>
                                        </div>
                                    </div>

                                    <div class="filter-section">
                                        <div class="filter-title">Dung lượng RAM</div>
                                        <div class="d-flex flex-wrap gap-2">
                                            <input type="checkbox" class="filter-checkbox" name="ram" value="4 GB"
                                                id="r1">
                                            <label class="filter-label" for="r1">4GB</label>

                                            <input type="checkbox" class="filter-checkbox" name="ram" value="6 GB"
                                                id="r2">
                                            <label class="filter-label" for="r2">6GB</label>

                                            <input type="checkbox" class="filter-checkbox" name="ram" value="8 GB"
                                                id="r3">
                                            <label class="filter-label" for="r3">8GB</label>

                                            <input type="checkbox" class="filter-checkbox" name="ram" value="12 GB"
                                                id="r4">
                                            <label class="filter-label" for="r4">12GB</label>
                                        </div>
                                    </div>

                                    <div class="filter-section">
                                        <div class="filter-title">Kích thước màn hình</div>
                                        <div class="d-flex flex-wrap gap-2">
                                            <input type="checkbox" class="filter-checkbox" name="screenSize"
                                                value="Dưới 6 inch" id="s1"><label class="filter-label" for="s1">
                                                < 6"</label>
                                                    <input type="checkbox" class="filter-checkbox" name="screenSize"
                                                        value="6.0 - 6.4 inch" id="s2"><label class="filter-label"
                                                        for="s2">6.0 - 6.4"</label>
                                                    <input type="checkbox" class="filter-checkbox" name="screenSize"
                                                        value="6.5 - 6.7 inch" id="s3"><label class="filter-label"
                                                        for="s3">6.5 - 6.7"</label>
                                                    <input type="checkbox" class="filter-checkbox" name="screenSize"
                                                        value="Trên 6.7 inch" id="s4"><label class="filter-label"
                                                        for="s4">> 6.7"</label>
                                        </div>
                                    </div>

                                    <div class="filter-section">
                                        <div class="filter-title">Dung lượng pin</div>
                                        <div class="d-flex flex-wrap gap-2">
                                            <input type="checkbox" class="filter-checkbox" name="battery"
                                                value="Dưới 4000mAh" id="b1"><label class="filter-label" for="b1">
                                                < 4000mAh</label>
                                                    <input type="checkbox" class="filter-checkbox" name="battery"
                                                        value="4000 - 5000mAh" id="b2"><label class="filter-label"
                                                        for="b2">4000 - 5000mAh</label>
                                                    <input type="checkbox" class="filter-checkbox" name="battery"
                                                        value="5000 - 6000mAh" id="b3"><label class="filter-label"
                                                        for="b3">5000 - 6000mAh</label>
                                                    <input type="checkbox" class="filter-checkbox" name="battery"
                                                        value="Trên 6000mAh" id="b4"><label class="filter-label"
                                                        for="b4">> 6000mAh</label>
                                        </div>
                                    </div>
                                </div>

                                <div class="filter-actions">
                                    <button type="button" id="btnClearFilter" class="btn-clear-filter">Xóa lọc</button>
                                    <button type="button" id="btnApplyFilter" class="btn-filter-search">
                                        <i class="fas fa-search me-1"></i> Tìm kiếm
                                    </button>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-9 col-md-8">
                            <div
                                class="d-flex flex-wrap gap-2 align-items-center mb-4 bg-white p-3 shadow-sm rounded-4">
                                <span class="fw-bold me-2 text-dark">Sắp xếp:</span>
                                <button class="sort-btn active" data-sort="newest">Mới nhất</button>
                                <button class="sort-btn" data-sort="priceAsc">Giá tăng dần</button>
                                <button class="sort-btn" data-sort="priceDesc">Giá giảm dần</button>
                                <button class="sort-btn" data-sort="bestSeller">Bán chạy</button>
                            </div>

                            <div id="productGrid" class="row row-cols-2 row-cols-md-3 row-cols-lg-4 g-3">
                                <c:forEach items="${products}" var="product">
                                    <div class="col">
                                        <div class="product-card">
                                            <a href="/product/${product.id}" class="text-center">
                                                <img src="/images/product/${product.image}" class="img-fluid"
                                                    alt="${product.name}">
                                            </a>
                                            <div class="mt-auto">
                                                <a href="/product/${product.id}" class="p-name">${product.name}</a>
                                                <div class="specs-mini">
                                                    <c:if test="${not empty product.screenSize}"><span><i
                                                                class="fas fa-mobile-alt"></i>
                                                            ${product.screenSize}</span></c:if>
                                                    <c:if test="${not empty product.ram}"><span><i
                                                                class="fas fa-memory"></i> ${product.ram}</span></c:if>
                                                    <c:if test="${not empty product.rom}"><span><i
                                                                class="fas fa-hdd"></i> ${product.rom}</span></c:if>
                                                    <c:if test="${not empty product.battery}"><span><i
                                                                class="fas fa-battery-full"></i>
                                                            ${product.battery}</span></c:if>
                                                </div>
                                                <div class="p-price mb-2">
                                                    <fmt:formatNumber value="${product.price}" pattern="#,###" />đ
                                                </div>
                                                <form action="/add-product-to-cart/${product.id}" method="post">
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
                            <c:if test="${totalPages > 1}">
                                <nav class="mt-5 d-flex justify-content-center">
                                    <%-- Thêm d-flex và flex-row vào ul để ép các thẻ li nằm ngang --%>
                                        <ul class="pagination custom-pagination mb-0 d-flex flex-row">

                                            <%-- Mũi tên TRƯỚC --%>
                                                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                                    <a class="page-link" href="/products?page=${currentPage - 1}"
                                                        aria-label="Previous">
                                                        <i class="fas fa-chevron-left"></i>
                                                    </a>
                                                </li>

                                                <%-- Danh sách số trang --%>
                                                    <c:forEach begin="1" end="${totalPages}" varStatus="loop">
                                                        <li
                                                            class="page-item ${currentPage == loop.index ? 'active' : ''}">
                                                            <a class="page-link"
                                                                href="/products?page=${loop.index}">${loop.index}</a>
                                                        </li>
                                                    </c:forEach>

                                                    <%-- Mũi tên SAU --%>
                                                        <li
                                                            class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                                            <a class="page-link"
                                                                href="/products?page=${currentPage + 1}"
                                                                aria-label="Next">
                                                                <i class="fas fa-chevron-right"></i>
                                                            </a>
                                                        </li>

                                        </ul>
                                </nav>
                            </c:if>

                            <nav id="pagination" class="mt-5 d-flex justify-content-center"></nav>
                        </div>
                    </div>
                </div>

                <jsp:include page="../layout/footer.jsp" />
                <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>

                <script src="/client/js/product-filter.js"></script>
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
                <script>
                    $(document).ready(function () {
                        // Bắt sự kiện submit của tất cả các form thêm vào giỏ hàng
                        $('form[action^="/add-product-to-cart"]').on('submit', function (e) {
                            e.preventDefault(); // Chặn hành vi chuyển trang mặc định của trình duyệt

                            var form = $(this);
                            var url = form.attr('action');

                            // Lấy token CSRF để vượt qua bảo mật của Spring Security
                            var csrfToken = form.find('input[name="_csrf"]').val();
                            var csrfParam = form.find('input[name="_csrf"]').attr('name');
                            var data = {};
                            data[csrfParam] = csrfToken;

                            // Tạo hiệu ứng vô hiệu hóa nút trong lúc chờ xử lý
                            var submitBtn = form.find('button[type="submit"]');
                            var originalText = submitBtn.html();
                            submitBtn.prop('disabled', true).text('Đang xử lý...');

                            // Gửi dữ liệu ngầm (AJAX)
                            $.ajax({
                                type: 'POST',
                                url: url,
                                data: data,
                                success: function () {
                                    var cartBadge = $('.cart-badge');
                                    var currentSum = parseInt(cartBadge.text().trim()) || 0;
                                    cartBadge.text(currentSum + 1);
                                    // Cấu hình hiển thị Toastr
                                    toastr.options = {
                                        "closeButton": true,
                                        "progressBar": true,
                                        "positionClass": "toast-top-right",
                                        "timeOut": "2000"
                                    };
                                    // Hiển thị thông báo thành công
                                    toastr.success('Thêm sản phẩm vào giỏ hàng thành công!', 'Thành công');

                                    // Khôi phục lại nút bấm
                                    submitBtn.prop('disabled', false).html(originalText);
                                },
                                error: function () {
                                    toastr.error('Có lỗi xảy ra, vui lòng thử lại!', 'Thất bại');
                                    submitBtn.prop('disabled', false).html(originalText);
                                }
                            });
                        });
                    });
                </script>
            </body>

            </html>