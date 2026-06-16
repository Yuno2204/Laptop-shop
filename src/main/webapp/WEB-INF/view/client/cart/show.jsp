<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="utf-8">
                <title>Giỏ hàng - Mobileshop</title>
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
                    .cart-item-img {
                        width: 80px;
                        height: 80px;
                        object-fit: cover;
                        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                    }

                    .cart-summary-card {
                        border: 1px solid #eee;
                        border-radius: 15px;
                        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
                    }

                    .table-cart th {
                        text-transform: uppercase;
                        font-size: 0.85rem;
                        color: #6c757d;
                        letter-spacing: 0.5px;
                    }

                    .disabled-btn {
                        opacity: 0.4;
                        cursor: not-allowed !important;
                        pointer-events: none;
                    }
                </style>
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
            </head>

            <body>
                <div id="spinner"
                    class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50 d-flex align-items-center justify-content-center">
                    <div class="spinner-grow text-primary" role="status"></div>
                </div>
                <jsp:include page="../layout/header.jsp" />

                <div class="container-fluid py-5 mt-5">
                    <div class="container py-5">
                        <div class="mb-4">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb mb-0">
                                    <li class="breadcrumb-item"><a href="/"
                                            class="text-decoration-none text-muted">Trang chủ</a></li>
                                    <li class="breadcrumb-item active text-primary fw-bold" aria-current="page">Giỏ Hàng
                                    </li>
                                </ol>
                            </nav>
                        </div>

                        <c:choose>
                            <%-- TH1: Giỏ hàng chưa có bất kỳ sản phẩm nào --%>
                                <c:when test="${empty cart or empty cart.cartDetails}">
                                    <div class="row justify-content-center py-5 text-center">
                                        <div class="col-md-6">
                                            <i class="fas fa-shopping-bag text-light mb-4" style="font-size: 8rem;"></i>
                                            <h2 class="mb-3">Giỏ hàng của bạn đang trống!</h2>
                                            <p class="text-muted mb-4">Có vẻ như bạn chưa chọn được sản phẩm nào. Hãy
                                                khám phá thêm các sản phẩm hấp dẫn của Mobileshop nhé.</p>
                                            <a href="/"
                                                class="btn btn-primary rounded-pill py-3 px-5 fw-bold text-white shadow-sm">
                                                <i class="fas fa-arrow-left me-2"></i> Tiếp tục mua sắm
                                            </a>
                                        </div>
                                    </div>
                                </c:when>

                                <%-- Đã có sản phẩm trong giỏ (hiển thị ô Search) --%>
                                    <c:otherwise>
                                        <div class="row mb-4">
                                            <div class="col-lg-8">
                                                <form action="/cart" method="GET">
                                                    <div class="input-group rounded-pill shadow-sm align-items-center p-1"
                                                        style="border: 1px solid #e0e0e0; background-color: #fff;">

                                                        <span class="border-0 bg-transparent text-muted ms-3 me-2">
                                                            <i class="fas fa-search"></i>
                                                        </span>

                                                        <input type="text" name="keyword"
                                                            class="form-control border-0 shadow-none bg-transparent"
                                                            placeholder="Tìm kiếm sản phẩm trong giỏ..."
                                                            value="${keyword}"
                                                            style="font-size: 0.95rem; padding-top: 0.6rem; padding-bottom: 0.6rem;">

                                                        <c:if test="${not empty keyword}">
                                                            <a href="/cart"
                                                                class="btn border-0 text-muted shadow-none px-3 d-flex align-items-center transition-all hover-danger">
                                                                <i class="fas fa-times-circle"
                                                                    style="font-size: 1.1rem;"></i>
                                                            </a>
                                                        </c:if>

                                                        <button type="submit"
                                                            class="btn btn-primary rounded-pill px-4 py-2 me-1 fw-bold shadow-sm transition-all">
                                                            Tìm kiếm
                                                        </button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>

                                        <c:choose>

                                            <%-- TH2: Có sản phẩm trong giỏ nhưng không khớp với từ khóa tìm kiếm --%>
                                                <c:when test="${empty cartDetails}">
                                                    <div
                                                        class="row justify-content-center py-5 text-center bg-light rounded mx-1">
                                                        <div class="col-md-6 py-4">
                                                            <i class="fas fa-box-open text-secondary mb-4"
                                                                style="font-size: 5rem;"></i>
                                                            <h4 class="mb-3 text-secondary">Không tìm thấy sản phẩm phù
                                                                hợp trong giỏ hàng.</h4>
                                                            <a href="/cart"
                                                                class="btn btn-outline-primary rounded-pill py-2 px-4 mt-2 fw-bold">
                                                                <i class="fas fa-undo me-2"></i> Hiển thị tất cả
                                                            </a>
                                                        </div>
                                                    </div>
                                                </c:when>

                                                <%-- TH3: Hiện danh sách sản phẩm khớp với từ khóa (hoặc hiện tất cả nếu
                                                    ko có search) --%>
                                                    <c:otherwise>
                                                        <div class="row g-5">
                                                            <div class="col-lg-8">
                                                                <div
                                                                    class="table-responsive bg-white rounded shadow-sm p-4">
                                                                    <table
                                                                        class="table table-hover table-cart align-middle mb-0">
                                                                        <thead class="table-light">
                                                                            <tr>
                                                                                <th scope="col" style="width: 50px;"
                                                                                    class="text-center">
                                                                                    <input class="form-check-input"
                                                                                        type="checkbox" id="selectAll"
                                                                                        style="transform: scale(1.3); cursor: pointer;">
                                                                                </th>
                                                                                <th scope="col" colspan="2">Sản phẩm
                                                                                </th>
                                                                                <th scope="col" class="text-center">Đơn
                                                                                    giá</th>
                                                                                <th scope="col" class="text-center">Số
                                                                                    lượng</th>
                                                                                <th scope="col" class="text-end">Thành
                                                                                    tiền</th>
                                                                                <th scope="col" class="text-center">Xóa
                                                                                </th>
                                                                            </tr>
                                                                        </thead>
                                                                        <tbody>
                                                                            <c:forEach var="cartDetail"
                                                                                items="${cartDetails}"
                                                                                varStatus="status">
                                                                                <tr>
                                                                                    <td
                                                                                        class="text-center align-middle">
                                                                                        <input
                                                                                            class="form-check-input item-checkbox"
                                                                                            type="checkbox"
                                                                                            value="${cartDetail.id}"
                                                                                            data-price="${cartDetail.price}"
                                                                                            style="transform: scale(1.3); cursor: pointer;">
                                                                                    </td>
                                                                                    <td style="width: 100px;">
                                                                                        <a
                                                                                            href="/product/${cartDetail.product.id}">
                                                                                            <img src="/images/product/${cartDetail.product.image}"
                                                                                                class="img-fluid rounded cart-item-img"
                                                                                                alt="">
                                                                                        </a>
                                                                                    </td>
                                                                                    <td>
                                                                                        <a href="/product/${cartDetail.product.id}"
                                                                                            class="text-dark text-decoration-none fw-bold h6 d-block mb-1">
                                                                                            ${cartDetail.product.name}
                                                                                        </a>
                                                                                    </td>
                                                                                    <td class="text-center text-muted">
                                                                                        <p class="mb-0">
                                                                                            <fmt:formatNumber
                                                                                                type="number"
                                                                                                value="${cartDetail.price}" />
                                                                                            đ
                                                                                        </p>
                                                                                    </td>
                                                                                    <td>
                                                                                        <div class="input-group quantity mx-auto"
                                                                                            style="width: 100px;">
                                                                                            <div
                                                                                                class="input-group-btn">
                                                                                                <button type="button"
                                                                                                    class="btn btn-sm btn-minus rounded-circle bg-light border">
                                                                                                    <i
                                                                                                        class="fa fa-minus"></i>
                                                                                                </button>
                                                                                            </div>
                                                                                            <input type="text"
                                                                                                class="form-control form-control-sm text-center border-0"
                                                                                                value="${cartDetail.quantity}"
                                                                                                data-cart-detail-id="${cartDetail.id}"
                                                                                                data-cart-detail-price="${cartDetail.price}"
                                                                                                data-cart-detail-index="${status.index}"
                                                                                                data-stock="${cartDetail.product.quantity}">
                                                                                            <div
                                                                                                class="input-group-btn">
                                                                                                <button type="button"
                                                                                                    class="btn btn-sm btn-plus rounded-circle bg-light border">
                                                                                                    <i
                                                                                                        class="fa fa-plus"></i>
                                                                                                </button>
                                                                                            </div>
                                                                                        </div>
                                                                                    </td>
                                                                                    <td class="text-end">
                                                                                        <p class="mb-0 text-primary fw-bold"
                                                                                            data-cart-detail-id="${cartDetail.id}">
                                                                                            <fmt:formatNumber
                                                                                                type="number"
                                                                                                value="${cartDetail.price * cartDetail.quantity}" />
                                                                                            đ
                                                                                        </p>
                                                                                    </td>
                                                                                    <td class="text-center">
                                                                                        <button type="button"
                                                                                            class="btn btn-outline-danger btn-sm rounded-circle btn-delete-cart"
                                                                                            data-bs-toggle="modal"
                                                                                            data-bs-target="#confirmDeleteModal"
                                                                                            data-cart-detail-id="${cartDetail.id}">
                                                                                            <i class="fa fa-trash"></i>
                                                                                        </button>
                                                                                    </td>
                                                                                </tr>
                                                                            </c:forEach>
                                                                        </tbody>
                                                                    </table>
                                                                </div>
                                                                <div class="mt-4">
                                                                    <a href="/"
                                                                        class="btn btn-outline-primary rounded-pill py-2 px-4">
                                                                        <i class="fas fa-arrow-left me-2"></i> Tiếp tục
                                                                        chọn đồ
                                                                    </a>
                                                                </div>
                                                            </div>

                                                            <div class="col-lg-4">
                                                                <div class="cart-summary-card bg-white p-4">
                                                                    <h4 class="mb-4 fw-bold">Thông tin Đơn hàng</h4>
                                                                    <div
                                                                        class="d-flex justify-content-between mb-3 text-muted">
                                                                        <span>Tạm tính (<span
                                                                                id="selected-count-display">0</span>
                                                                            SP):</span>
                                                                        <p class="mb-0 fw-bold text-dark"
                                                                            id="sub-total-display">0 đ</p>
                                                                    </div>
                                                                    <div
                                                                        class="d-flex justify-content-between mb-3 text-muted">
                                                                        <span>Phí vận chuyển:</span>
                                                                        <p class="mb-0 fw-bold text-success">0 đ</p>
                                                                    </div>
                                                                    <hr class="my-4">
                                                                    <div class="d-flex justify-content-between mb-4">
                                                                        <h5 class="mb-0 fw-bold">Tổng thanh toán:</h5>
                                                                        <p class="mb-0 fw-bold text-primary h5"
                                                                            id="total-price-display">0 đ</p>
                                                                    </div>

                                                                    <form action="/confirm-checkout" method="post"
                                                                        id="confirm-checkout-form">
                                                                        <input type="hidden"
                                                                            name="${_csrf.parameterName}"
                                                                            value="${_csrf.token}" />
                                                                        <div style="display: none;">
                                                                            <c:forEach var="cartDetail"
                                                                                items="${cartDetails}"
                                                                                varStatus="status">
                                                                                <input type="hidden"
                                                                                    name="cartDetails[${status.index}].id"
                                                                                    value="${cartDetail.id}" />
                                                                                <input type="hidden"
                                                                                    name="cartDetails[${status.index}].quantity"
                                                                                    value="${cartDetail.quantity}"
                                                                                    id="hidden-qty-${cartDetail.id}" />
                                                                            </c:forEach>
                                                                        </div>
                                                                        <button type="button" id="btn-confirm-checkout"
                                                                            style="display: none;"></button>

                                                                        <button
                                                                            class="btn btn-primary rounded-pill w-100 py-3 fw-bold text-uppercase shadow"
                                                                            type="button" id="real-checkout-btn">
                                                                            Xác nhận đơn hàng <i
                                                                                class="fas fa-arrow-right ms-2"></i>
                                                                        </button>
                                                                    </form>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </c:otherwise>
                                        </c:choose>
                                    </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <jsp:include page="../layout/footer.jsp" />

                <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i
                        class="fa fa-arrow-up"></i></a>

                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
                <script src="/client/lib/easing/easing.min.js"></script>
                <script src="/client/lib/waypoints/waypoints.min.js"></script>
                <script src="/client/lib/lightbox/js/lightbox.min.js"></script>
                <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>
                <script src="/client/js/main.js"></script>
                <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>

                <div class="modal fade" id="confirmDeleteModal" tabindex="-1" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Xác nhận xóa sản phẩm</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                Bạn có chắc muốn xóa sản phẩm này khỏi giỏ hàng không?
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                <form id="delete-cart-form" method="post" action="">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                    <input type="hidden" name="keyword" value="${keyword}" />
                                    <button type="submit" class="btn btn-danger">Xóa</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <c:if test="${not empty error}">
                    <script>
                        $(document).ready(function () {
                            toastr.error('${error}', 'Cảnh báo');
                        });
                    </script>
                </c:if>
                <c:if test="${not empty success}">
                    <script>
                        $(document).ready(function () {
                            toastr.success('${success}', 'Thành công');
                        });
                    </script>
                </c:if>

                <script>
                    function formatMoney(value) {
                        return parseFloat(value).toLocaleString('vi-VN') + ' đ';
                    }

                    function calcSelectedTotal() {
                        var total = 0;
                        var count = 0;
                        $('.item-checkbox:checked').each(function () {
                            var id = $(this).val();
                            var price = parseFloat($(this).attr('data-price'));
                            var qty = parseInt($('input[data-cart-detail-id="' + id + '"]').val());
                            total += price * qty;
                            count += qty;
                        });
                        var formattedTotal = formatMoney(total);
                        $('#sub-total-display').text(formattedTotal);
                        $('#total-price-display').text(formattedTotal);
                        $('#selected-count-display').text(count);
                    }

                    function checkMaxStockUI($input) {
                        var maxStock = parseInt($input.attr('data-stock'));
                        var currentVal = parseInt($input.val());
                        var $btnPlus = $input.siblings('.input-group-btn').find('.btn-plus');

                        if (currentVal >= maxStock) {
                            $btnPlus.prop('disabled', true).addClass('disabled-btn');
                        } else {
                            $btnPlus.prop('disabled', false).removeClass('disabled-btn');
                        }
                    }

                    let updateTimer;
                    function updateQuantityAjax($input, newQty) {
                        var cartDetailId = $input.attr('data-cart-detail-id');
                        var maxStock = parseInt($input.attr('data-stock'));
                        var price = parseFloat($input.attr('data-cart-detail-price'));

                        if (newQty < 1) newQty = 1;
                        if (newQty > maxStock) {
                            toastr.warning('Trong kho chỉ còn tối đa ' + maxStock + ' sản phẩm!', 'Vượt tồn kho');
                            newQty = maxStock;
                        }

                        $input.val(newQty);
                        $('#hidden-qty-' + cartDetailId).val(newQty);
                        $('p[data-cart-detail-id="' + cartDetailId + '"]').text(formatMoney(price * newQty));
                        calcSelectedTotal();
                        checkMaxStockUI($input);

                        var $btnGroup = $input.closest('.quantity');
                        $btnGroup.find('button').prop('disabled', true);
                        clearTimeout(updateTimer);

                        updateTimer = setTimeout(function () {
                            $.ajax({
                                url: '/api/update-cart-quantity',
                                type: 'POST',
                                data: {
                                    cartDetailId: cartDetailId,
                                    quantity: newQty,
                                    '${_csrf.parameterName}': '${_csrf.token}'
                                },
                                success: function (res) {
                                    if (res.success) {
                                        if (res.newQuantity !== newQty) {
                                            $input.val(res.newQuantity);
                                            $('#hidden-qty-' + cartDetailId).val(res.newQuantity);
                                            $('p[data-cart-detail-id="' + cartDetailId + '"]').text(formatMoney(price * res.newQuantity));
                                            calcSelectedTotal();
                                            checkMaxStockUI($input);
                                        }
                                        if (res.warning) toastr.warning(res.warning);
                                    } else {
                                        toastr.error(res.message);
                                    }
                                },
                                error: function () {
                                    toastr.error("Đã xảy ra lỗi đồng bộ, vui lòng tải lại trang!");
                                },
                                complete: function () {
                                    $btnGroup.find('button').prop('disabled', false);
                                    checkMaxStockUI($input);
                                }
                            });
                        }, 500);
                    }

                    $(document).ready(function () {
                        $('input[data-cart-detail-id]').each(function () {
                            checkMaxStockUI($(this));
                        });

                        $('#selectAll').change(function () {
                            $('.item-checkbox').prop('checked', $(this).prop('checked'));
                            calcSelectedTotal();
                        });

                        $('.item-checkbox').change(function () {
                            if ($('.item-checkbox:checked').length === $('.item-checkbox').length) {
                                $('#selectAll').prop('checked', true);
                            } else {
                                $('#selectAll').prop('checked', false);
                            }
                            calcSelectedTotal();
                        });

                        $('input[data-cart-detail-id]').off('change keyup').on('change', function () {
                            var $input = $(this);
                            var currentVal = parseInt($input.val());
                            if (isNaN(currentVal) || currentVal < 1) currentVal = 1;
                            updateQuantityAjax($input, currentVal);
                        });

                        $('.btn-plus').off('click').on('click', function (e) {
                            e.preventDefault();
                            var $input = $(this).closest('.quantity').find('input[type="text"]');
                            var currentVal = parseInt($input.val()) || 1;
                            updateQuantityAjax($input, currentVal + 1);
                        });

                        $('.btn-minus').off('click').on('click', function (e) {
                            e.preventDefault();
                            var $input = $(this).closest('.quantity').find('input[type="text"]');
                            var currentVal = parseInt($input.val()) || 1;
                            if (currentVal > 1) updateQuantityAjax($input, currentVal - 1);
                        });

                        $('#real-checkout-btn').on('click', function (e) {
                            e.preventDefault();
                            var selectedIds = [];

                            // Gom các ID sản phẩm được tích chọn
                            $('.item-checkbox:checked').each(function () {
                                selectedIds.push($(this).val());
                            });

                            // 1. NẾU CHƯA CHỌN SẢN PHẨM NÀO
                            if (selectedIds.length === 0) {
                                // Tăng thời gian hiện thông báo lên 2 giây (2000ms)
                                toastr.warning('Vui lòng tích chọn ít nhất một sản phẩm ở bên trái để đặt hàng!', 'Chưa chọn sản phẩm', {
                                    timeOut: 2000,
                                    closeButton: true,
                                    progressBar: true
                                });

                                // Tạo hiệu ứng phát sáng viền đỏ cho các ô checkbox để nhắc người dùng
                                $('.item-checkbox').css({
                                    'box-shadow': '0 0 10px red',
                                    'border': '2px solid red',
                                    'transition': 'all 0.3s'
                                });
                                // Tự động tắt hiệu ứng đỏ sau 2 giây
                                setTimeout(function () {
                                    $('.item-checkbox').css({ 'box-shadow': 'none', 'border': 'none' });
                                }, 1000);

                                return; // Dừng lại tại đây
                            }

                            // 2. NẾU ĐÃ CHỌN SẢN PHẨM: Đồng bộ số lượng mới nhất
                            $('input[data-cart-detail-id]').each(function () {
                                var id = $(this).attr("data-cart-detail-id");
                                var hiddenInput = $("#hidden-qty-" + id);
                                if (hiddenInput.length > 0) {
                                    hiddenInput.val($(this).val());
                                }
                            });

                            // 3. Đưa ID sản phẩm vào form
                            var form = $('#confirm-checkout-form');
                            form.find('input[name="selectedCartDetailIds"]').remove();
                            selectedIds.forEach(function (id) {
                                form.append('<input type="hidden" name="selectedCartDetailIds" value="' + id + '">');
                            });

                            // 4. HIỆU ỨNG LOADING (CHỐNG ĐƠ)
                            // Đổi chữ nút thành Đang xử lý và khóa nút lại tránh bấm 2 lần
                            var $btn = $(this);
                            $btn.html('Đang xử lý... <i class="fas fa-spinner fa-spin ms-2"></i>').prop('disabled', true);

                            // Kích hoạt màn hình xoay tròn loading của web
                            $('#spinner').addClass('show');

                            // Gửi form đi bằng lệnh gốc của trình duyệt
                            form[0].submit();
                        });

                        $('.btn-delete-cart').on('click', function () {
                            var cartDetailId = $(this).attr('data-cart-detail-id');
                            $('#delete-cart-form').attr('action', '/delete-cart-product/' + cartDetailId);
                        });

                        $('#delete-cart-form').on('submit', function (e) {
                            e.preventDefault();
                            var form = $(this);
                            var url = form.attr('action');
                            var data = form.serialize();

                            var submitBtn = form.find('button[type="submit"]');
                            var originalText = submitBtn.html();
                            submitBtn.prop('disabled', true).text('Đang xóa...');

                            $.ajax({
                                type: 'POST',
                                url: url,
                                data: data,
                                success: function () {
                                    $('#confirmDeleteModal').modal('hide');
                                    toastr.options = { "closeButton": true, "progressBar": true, "positionClass": "toast-top-right", "timeOut": "1500" };
                                    toastr.success('Xóa sản phẩm thành công!', 'Thành công');
                                    setTimeout(function () {
                                        window.location.reload();
                                    }, 1500);
                                },
                                error: function () {
                                    toastr.error('Có lỗi xảy ra, không thể xóa sản phẩm!', 'Thất bại');
                                    submitBtn.prop('disabled', false).html(originalText);
                                }
                            });
                        });
                    });
                </script>
            </body>

            </html>