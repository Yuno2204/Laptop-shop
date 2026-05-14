<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
                <!DOCTYPE html>
                <html lang="vi">

                <head>
                    <meta charset="utf-8">
                    <title>Thanh toán - Mobileshop</title>
                    <meta content="width=device-width, initial-scale=1.0" name="viewport">

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
                        .checkout-summary-card {
                            border: 1px solid #eee;
                            border-radius: 15px;
                            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.06);
                            position: sticky;
                            top: 120px;
                            /* Ghim box tổng tiền khi cuộn chuột */
                        }

                        .checkout-info-card {
                            background: #fff;
                            border-radius: 15px;
                            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.03);
                            border: 1px solid #f5f5f5;
                        }

                        .product-img-sm {
                            width: 65px;
                            height: 65px;
                            object-fit: cover;
                            border-radius: 10px;
                            border: 1px solid #eee;
                        }

                        .form-control-custom {
                            border-radius: 10px;
                            padding: 12px 15px;
                            border: 1px solid #ddd;
                            background-color: #fcfcfc;
                            transition: all 0.3s;
                        }

                        .form-control-custom:focus {
                            background-color: #fff;
                            box-shadow: 0 0 0 0.25rem rgba(129, 196, 8, 0.15);
                            /* Màu chủ đạo của web */
                            border-color: #81c408;
                        }

                        .form-label-custom {
                            font-weight: 600;
                            color: #45595b;
                            margin-bottom: 8px;
                        }

                        .payment-method-box {
                            border: 1px solid #81c408;
                            background-color: #f8fff0;
                            border-radius: 10px;
                            padding: 15px;
                        }
                    </style>
                </head>

                <body>

                    <div id="spinner"
                        class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50 d-flex align-items-center justify-content-center">
                        <div class="spinner-grow text-primary" role="status"></div>
                    </div>
                    <jsp:include page="../layout/header.jsp" />

                    <div class="container-fluid py-5 mt-5">
                        <div class="container py-5">

                            <div class="mb-5">
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb mb-0">
                                        <li class="breadcrumb-item"><a href="/"
                                                class="text-decoration-none text-muted">Trang chủ</a></li>
                                        <li class="breadcrumb-item"><a href="/cart"
                                                class="text-decoration-none text-muted">Giỏ hàng</a></li>
                                        <li class="breadcrumb-item active text-primary fw-bold" aria-current="page">
                                            Thanh Toán</li>
                                    </ol>
                                </nav>
                            </div>

                            <c:if test="${not empty cartDetails}">
                                <form:form action="/place-order" method="post" modelAttribute="cart">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                                    <div class="row g-5">

                                        <div class="col-lg-7">

                                            <div class="checkout-info-card p-4 p-md-5 mb-4">
                                                <h4 class="mb-4 fw-bold text-dark"><i
                                                        class="fas fa-map-marked-alt text-primary me-2"></i> Thông Tin
                                                    Giao Hàng</h4>

                                                <div class="row g-4">
                                                    <div class="col-md-12">
                                                        <div class="form-group">
                                                            <label class="form-label-custom">Họ và tên người nhận <span
                                                                    class="text-danger">*</span></label>
                                                            <div class="input-group">
                                                                <span
                                                                    class="input-group-text bg-light border-end-0 rounded-start-custom"><i
                                                                        class="fas fa-user text-muted"></i></span>
                                                                <input type="text"
                                                                    class="form-control form-control-custom border-start-0"
                                                                    name="receiverName" value="${user.fullName}"
                                                                    required placeholder="Nhập họ tên đầy đủ">
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-12">
                                                        <div class="form-group">
                                                            <label class="form-label-custom">Số điện thoại <span
                                                                    class="text-danger">*</span></label>
                                                            <div class="input-group">
                                                                <span
                                                                    class="input-group-text bg-light border-end-0 rounded-start-custom"><i
                                                                        class="fas fa-phone-alt text-muted"></i></span>
                                                                <input type="text"
                                                                    class="form-control form-control-custom border-start-0"
                                                                    name="receiverPhone" value="${user.phone}" required
                                                                    placeholder="Số điện thoại liên hệ">
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-12">
                                                        <div class="form-group">
                                                            <label class="form-label-custom">Địa chỉ giao hàng <span
                                                                    class="text-danger">*</span></label>
                                                            <div class="input-group">
                                                                <span
                                                                    class="input-group-text bg-light border-end-0 rounded-start-custom"><i
                                                                        class="fas fa-home text-muted"></i></span>
                                                                <input type="text"
                                                                    class="form-control form-control-custom border-start-0"
                                                                    name="receiverAddress" value="${user.address}"
                                                                    required
                                                                    placeholder="Số nhà, tên đường, phường/xã, quận/huyện...">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="checkout-info-card p-4 p-md-5">
                                                <h4 class="mb-4 fw-bold text-dark"><i
                                                        class="fas fa-box-open text-primary me-2"></i> Kiểm Tra Sản Phẩm
                                                </h4>

                                                <div class="product-list">
                                                    <c:forEach var="cartDetail" items="${cartDetails}">
                                                        <div class="d-flex align-items-center mb-3 pb-3 border-bottom">
                                                            <a href="/product/${cartDetail.product.id}">
                                                                <img src="/images/product/${cartDetail.product.image}"
                                                                    class="product-img-sm me-3 shadow-sm"
                                                                    alt="${cartDetail.product.name}">
                                                            </a>
                                                            <div class="flex-grow-1">
                                                                <a href="/product/${cartDetail.product.id}"
                                                                    class="text-dark text-decoration-none fw-bold h6 d-block mb-1">
                                                                    ${cartDetail.product.name}
                                                                </a>
                                                                <small class="text-muted d-block">Đơn giá:
                                                                    <fmt:formatNumber type="number"
                                                                        value="${cartDetail.price}" /> đ
                                                                </small>
                                                                <span class="badge bg-light text-dark border mt-1">SL:
                                                                    ${cartDetail.quantity}</span>
                                                            </div>
                                                            <div class="text-end fw-bold text-primary fs-6">
                                                                <fmt:formatNumber type="number"
                                                                    value="${cartDetail.price * cartDetail.quantity}" />
                                                                đ
                                                            </div>
                                                        </div>
                                                    </c:forEach>
                                                </div>
                                                <div class="mt-3">
                                                    <a href="/cart" class="text-primary text-decoration-none"><i
                                                            class="fas fa-long-arrow-alt-left me-1"></i> Quay lại giỏ
                                                        hàng sửa số lượng</a>
                                                </div>
                                            </div>

                                        </div>

                                        <div class="col-lg-5">
                                            <div class="checkout-summary-card bg-white p-4 p-md-5">
                                                <h4 class="mb-4 fw-bold text-dark">Tổng Kết Đơn Hàng</h4>

                                                <div class="d-flex justify-content-between mb-3 text-muted">
                                                    <span>Tạm tính (
                                                        <c:out value="${cartDetails.size()}" /> sản phẩm):
                                                    </span>
                                                    <span class="fw-bold text-dark">
                                                        <fmt:formatNumber type="number" value="${totalPrice}" /> đ
                                                    </span>
                                                </div>
                                                <div class="d-flex justify-content-between mb-3 text-muted">
                                                    <span>Phí vận chuyển:</span>
                                                    <span class="fw-bold text-success">Miễn phí (0 đ)</span>
                                                </div>

                                                <hr class="my-4 text-muted">

                                                <div class="d-flex justify-content-between mb-4">
                                                    <h5 class="mb-0 fw-bold">Tổng thanh toán:</h5>
                                                    <h4 class="mb-0 fw-bold text-primary">
                                                        <fmt:formatNumber type="number" value="${totalPrice}" /> đ
                                                    </h4>
                                                </div>

                                                <h6 class="fw-bold mb-3 mt-4 text-dark">Phương thức thanh toán</h6>
                                                <div class="payment-method-box mb-4">
                                                    <div class="form-check d-flex align-items-center m-0">
                                                        <input class="form-check-input mt-0 me-3" type="radio"
                                                            name="paymentMethod" id="cod" checked
                                                            style="transform: scale(1.2);">
                                                        <label
                                                            class="form-check-label fw-bold text-dark mb-0 d-flex align-items-center"
                                                            for="cod">
                                                            <i
                                                                class="fas fa-money-bill-wave text-success fs-4 me-2"></i>
                                                            Thanh toán khi nhận hàng (COD)
                                                        </label>
                                                    </div>
                                                    <small class="text-muted d-block mt-2 ms-4 ps-2">Nhận hàng, kiểm tra
                                                        rồi mới thanh toán tiền cho Shiper.</small>
                                                </div>

                                                <button type="submit"
                                                    class="btn btn-primary rounded-pill w-100 py-3 fw-bold text-uppercase fs-6 shadow">
                                                    Đặt Hàng Ngay <i class="fas fa-check-circle ms-2"></i>
                                                </button>

                                                <p class="text-center text-muted mt-3 mb-0" style="font-size: 0.85rem;">
                                                    Bằng việc đặt hàng, bạn đồng ý với <a href="#"
                                                        class="text-primary">Điều khoản sử dụng</a> của Mobileshop.
                                                </p>
                                            </div>
                                        </div>

                                    </div>
                                </form:form>
                            </c:if>

                            <c:if test="${empty cartDetails}">
                                <div class="text-center py-5">
                                    <h3>Giỏ hàng của bạn đang trống!</h3>
                                    <a href="/" class="btn btn-primary rounded-pill py-2 px-4 mt-3">Quay về trang
                                        chủ</a>
                                </div>
                            </c:if>

                        </div>
                    </div>
                    <jsp:include page="../layout/footer.jsp" />

                    <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top">
                        <i class="fa fa-arrow-up"></i>
                    </a>

                    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
                    <script src="/client/lib/easing/easing.min.js"></script>
                    <script src="/client/lib/waypoints/waypoints.min.js"></script>
                    <script src="/client/lib/lightbox/js/lightbox.min.js"></script>
                    <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>

                    <script src="/client/js/main.js"></script>
                </body>

                </html>