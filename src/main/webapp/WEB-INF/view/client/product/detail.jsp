<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="utf-8">
                <title>${product.name} - Mobile Shop</title>
                <meta content="width=device-width, initial-scale=1.0" name="viewport">

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
                <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
                <style>
                    .product-image-wrapper {
                        background: #f8f9fa;
                        border-radius: 15px;
                        padding: 20px;
                        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
                    }

                    .trust-badges i {
                        font-size: 1.5rem;
                        color: #81c408;
                        /* Màu chủ đạo của bạn */
                    }

                    .trust-badges .badge-item {
                        display: flex;
                        align-items: center;
                        gap: 10px;
                        margin-bottom: 15px;
                        font-size: 0.9rem;
                        color: #555;
                    }

                    .nav-tabs .nav-link.active {
                        border-bottom: 3px solid #81c408;
                        font-weight: bold;
                        color: #81c408 !important;
                    }

                    #nav-specs table {
                        border-radius: 10px;
                        overflow: hidden;
                    }

                    #nav-specs th {
                        text-transform: uppercase;
                        font-size: 0.85rem;
                        letter-spacing: 1px;
                        color: #6c757d;
                    }

                    #nav-specs td {
                        padding: 15px 20px;
                        font-size: 0.95rem;
                    }

                    #nav-specs tr:nth-child(even) {
                        background-color: #fcfcfc;
                    }

                    /* Responsive cho mobile */
                    @media (max-width: 576px) {

                        #nav-specs td,
                        #nav-specs th {
                            padding: 10px 15px;
                            font-size: 0.85rem;
                        }
                    }
                </style>
            </head>

            <body>
                <jsp:include page="../layout/header.jsp" />

                <div class="container-fluid mt-5 pt-5 bg-light">
                    <div class="container py-3">
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb mb-0">
                                <li class="breadcrumb-item"><a href="/" class="text-decoration-none">Trang chủ</a></li>
                                <li class="breadcrumb-item"><a href="/products" class="text-decoration-none">Sản
                                        phẩm</a></li>
                                <li class="breadcrumb-item active" aria-current="page">${product.name}</li>
                            </ol>
                        </nav>
                    </div>
                </div>

                <div class="container py-5">
                    <div class="row g-5">
                        <div class="col-lg-5">
                            <div class="product-image-wrapper text-center">
                                <img src="/images/product/${product.image}" class="img-fluid rounded"
                                    alt="${product.name}" style="object-fit: contain; max-height: 450px;">
                            </div>
                        </div>

                        <div class="col-lg-7">
                            <div class="d-flex align-items-center gap-2 mb-3">
                                <span class="badge bg-primary text-uppercase px-3 py-2">${product.factory}</span>
                                <c:choose>
                                    <c:when test="${product.quantity > 0}">
                                        <span class="badge bg-success px-3 py-2"><i
                                                class="fas fa-check-circle me-1"></i> Còn hàng
                                            (${product.quantity})</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-danger px-3 py-2"><i class="fas fa-times-circle me-1"></i>
                                            Hết hàng</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <h1 class="fw-bold mb-3 text-dark">${product.name}</h1>

                            <div class="d-flex align-items-center mb-4">
                                <div class="text-warning me-2">
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star-half-alt"></i>
                                </div>
                                <span class="text-muted">(Đã bán: ${product.sold})</span>
                            </div>

                            <h2 class="fw-bold text-danger mb-4">
                                <fmt:formatNumber type="number" value="${product.price}" /> đ
                            </h2>

                            <p class="mb-4 text-secondary lh-lg">${product.shortDesc}</p>

                            <hr class="mb-4">

                            <form action="/add-product-to-cart/${product.id}" method="post" class="mb-4">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                                <input type="hidden" id="max-stock-val" value="${product.quantity}" />

                                <div class="d-flex align-items-center mb-4 pt-2">
                                    <div class="input-group custom-quantity me-3" style="width: 130px;">
                                        <div class="input-group-btn">
                                            <button type="button" id="btn-minus"
                                                class="btn btn-sm btn-minus rounded-circle bg-light border">
                                                <i class="fa fa-minus"></i>
                                            </button>
                                        </div>

                                        <input type="text" id="quantity-input"
                                            class="form-control form-control-sm text-center border-0 fw-bold" value="1"
                                            name="quantity" readonly>

                                        <div class="input-group-btn">
                                            <button type="button" id="btn-plus"
                                                class="btn btn-sm btn-plus rounded-circle bg-light border">
                                                <i class="fa fa-plus"></i>
                                            </button>
                                        </div>
                                    </div>

                                    <button type="submit"
                                        class="btn border border-secondary rounded-pill px-4 py-2 text-primary fw-bold shadow-sm"
                                        ${product.quantity==0 ? 'disabled' : '' }>
                                        <i class="fa fa-shopping-bag me-2 text-primary"></i> Thêm vào giỏ hàng
                                    </button>
                                </div>
                            </form>

                            <div class="trust-badges mt-5 p-4 bg-light rounded border">
                                <div class="row">
                                    <div class="col-md-6 badge-item">
                                        <i class="fas fa-shield-alt"></i>
                                        <span>Bảo hành chính hãng 12 tháng</span>
                                    </div>
                                    <div class="col-md-6 badge-item">
                                        <i class="fas fa-truck"></i>
                                        <span>Miễn phí giao hàng toàn quốc</span>
                                    </div>
                                    <div class="col-md-6 badge-item mb-md-0">
                                        <i class="fas fa-sync-alt"></i>
                                        <span>Đổi trả miễn phí trong 30 ngày</span>
                                    </div>
                                    <div class="col-md-6 badge-item mb-0">
                                        <i class="fas fa-headset"></i>
                                        <span>Hỗ trợ kỹ thuật 24/7</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mt-5 pt-5 border-top">
                        <div class="col-12">
                            <nav>
                                <div class="nav nav-tabs justify-content-center border-0 mb-4" id="nav-tab"
                                    role="tablist">
                                    <button class="nav-link active text-dark fs-5 px-4" id="nav-desc-tab"
                                        data-bs-toggle="tab" data-bs-target="#nav-desc" type="button" role="tab">Mô tả
                                        chi tiết</button>
                                    <button class="nav-link text-dark fs-5 px-4" id="nav-specs-tab" data-bs-toggle="tab"
                                        data-bs-target="#nav-specs" type="button" role="tab">Thông số kỹ thuật</button>
                                </div>
                            </nav>
                            <div class="tab-content" id="nav-tabContent">
                                <div class="tab-pane fade show active" id="nav-desc" role="tabpanel">
                                    <div class="bg-white p-4 p-md-5 rounded shadow-sm border"
                                        style="color: #000 !important; white-space: pre-line; line-height: 1.8;">
                                        <h4 class="mb-4 fw-bold text-dark">Đặc điểm nổi bật</h4>
                                        ${product.detailDesc}
                                    </div>
                                </div>

                                <div class="tab-pane fade" id="nav-specs" role="tabpanel">
                                    <div class="bg-white p-4 p-md-5 rounded shadow-sm border">
                                        <h4 class="mb-4 fw-bold text-dark"><i class="fas fa-microchip me-2"></i>Cấu hình
                                            chi tiết</h4>
                                        <div class="table-responsive">
                                            <table class="table table-bordered table-hover align-middle mb-0">
                                                <thead class="table-light">
                                                    <tr>
                                                        <th style="width: 40%" class="py-3 ps-4">Thông số</th>
                                                        <th style="width: 60%" class="py-3 ps-4">Giá trị</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td class="fw-bold ps-4 text-secondary">Thương hiệu</td>
                                                        <td class="ps-4">${product.factory}</td>
                                                    </tr>
                                                    <tr>
                                                        <td class="fw-bold ps-4 text-secondary">Hệ điều hành</td>
                                                        <td class="ps-4 text-primary fw-bold">${not empty product.os ?
                                                            product.os : 'Đang cập nhật'}</td>
                                                    </tr>
                                                    <tr>
                                                        <td class="fw-bold ps-4 text-secondary">Chip xử lý (CPU)</td>
                                                        <td class="ps-4">${not empty product.cpu ? product.cpu : 'Đang
                                                            cập nhật'}</td>
                                                    </tr>
                                                    <tr>
                                                        <td class="fw-bold ps-4 text-secondary">RAM</td>
                                                        <td class="ps-4">${not empty product.ram ? product.ram : 'Đang
                                                            cập nhật'}</td>
                                                    </tr>
                                                    <tr>
                                                        <td class="fw-bold ps-4 text-secondary">Bộ nhớ trong (ROM)</td>
                                                        <td class="ps-4">${not empty product.rom ? product.rom : 'Đang
                                                            cập nhật'}</td>
                                                    </tr>
                                                    <tr>
                                                        <td class="fw-bold ps-4 text-secondary">Màn hình</td>
                                                        <td class="ps-4">${not empty product.screenSize ?
                                                            product.screenSize : 'Đang cập nhật'}</td>
                                                    </tr>
                                                    <tr>
                                                        <td class="fw-bold ps-4 text-secondary">Tần số quét</td>
                                                        <td class="ps-4">${not empty product.refreshRate ?
                                                            product.refreshRate : 'Đang cập nhật'}</td>
                                                    </tr>
                                                    <tr>
                                                        <td class="fw-bold ps-4 text-secondary">Dung lượng Pin</td>
                                                        <td class="ps-4">${not empty product.battery ? product.battery :
                                                            'Đang cập nhật'}</td>
                                                    </tr>
                                                    <tr>
                                                        <td class="fw-bold ps-4 text-secondary">Công nghệ sạc nhanh</td>
                                                        <td class="ps-4 text-success">${not empty product.fastCharge ?
                                                            product.fastCharge : 'Đang cập nhật'}</td>
                                                    </tr>
                                                    <tr>
                                                        <td class="fw-bold ps-4 text-secondary">Nhu cầu sử dụng</td>
                                                        <td class="ps-4"><span
                                                                class="badge bg-info text-dark">${product.target}</span>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <jsp:include page="../layout/footer.jsp" />

                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
                <script src="/client/js/main.js"></script>

                <script>
                    $(document).ready(function () {
                        var quantityInput = $('#quantity-input');

                        // Lấy số lượng tồn kho từ thẻ input ẩn
                        var maxStockInput = $('#max-stock-val').val();
                        var maxStock = parseInt(maxStockInput) || 0;

                        $('#btn-plus').click(function () {
                            var currentVal = parseInt(quantityInput.val());
                            if (currentVal < maxStock) {
                                quantityInput.val(currentVal + 1);
                            } else {
                                alert("Số lượng vượt quá sản phẩm có sẵn trong kho!");
                            }
                        });

                        $('#btn-minus').click(function () {
                            var currentVal = parseInt(quantityInput.val());
                            if (currentVal > 1) {
                                quantityInput.val(currentVal - 1);
                            }
                        });
                    });
                </script>
                <script>
                    $(document).ready(function () {
                        var quantityInput = $('#quantity-input');

                        // CHẶN SỰ KIỆN SUBMIT CỦA FORM ĐỂ LÁCH LUẬT
                        $('form[action^="/add-product-to-cart"]').on('submit', async function (e) {
                            e.preventDefault(); // Dừng việc chuyển trang ngay lập tức

                            var form = $(this);
                            var url = form.attr('action');
                            var qty = parseInt(quantityInput.val()) || 1; // Lấy con số cuối cùng sau khi bạn đã bấm tăng/giảm

                            // Lấy token bảo mật CSRF
                            var csrfToken = form.find('input[name="_csrf"]').val();
                            var csrfParam = form.find('input[name="_csrf"]').attr('name');
                            var data = {};
                            data[csrfParam] = csrfToken;

                            // Hiệu ứng nút bấm
                            var submitBtn = form.find('button[type="submit"]');
                            var originalText = submitBtn.html();
                            submitBtn.prop('disabled', true).text('Đang thêm vào giỏ...');

                            try {
                                // Vòng lặp thần thánh: Backend nhận 1, thì mình gọi n lần
                                for (let i = 0; i < qty; i++) {
                                    await $.ajax({
                                        type: 'POST',
                                        url: url,
                                        data: data
                                    });
                                }

                                // Sau khi gọi đủ số lần, mới cho đi tới giỏ hàng
                                window.location.href = '/cart';

                            } catch (error) {
                                console.error("Lỗi:", error);
                                alert('Có lỗi xảy ra!');
                                submitBtn.prop('disabled', false).html(originalText);
                            }
                        });
                    });
                </script>
            </body>

            </html>