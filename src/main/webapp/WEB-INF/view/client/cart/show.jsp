<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="utf-8">
                <title>Giỏ hàng - Mobileshop</title>
                <meta content="width=device-width, initial-scale=1.0" name="viewport">
                <meta content="" name="keywords">
                <meta content="" name="description">

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

                    /* CSS khóa nút bấm khi vượt tồn kho */
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
                            <c:when test="${empty cartDetails}">
                                <div class="row justify-content-center py-5 text-center">
                                    <div class="col-md-6">
                                        <i class="fas fa-shopping-bag text-light mb-4" style="font-size: 8rem;"></i>
                                        <h2 class="mb-3">Giỏ hàng của bạn đang trống!</h2>
                                        <p class="text-muted mb-4">Có vẻ như bạn chưa chọn được sản phẩm nào. Hãy khám
                                            phá thêm các sản phẩm hấp dẫn của Mobileshop nhé.</p>
                                        <a href="/"
                                            class="btn btn-primary rounded-pill py-3 px-5 fw-bold text-white shadow-sm">
                                            <i class="fas fa-arrow-left me-2"></i> Tiếp tục mua sắm
                                        </a>
                                    </div>
                                </div>
                            </c:when>

                            <c:otherwise>
                                <div class="row g-5">
                                    <div class="col-lg-8">
                                        <div class="table-responsive bg-white rounded shadow-sm p-4">
                                            <table class="table table-hover table-cart align-middle mb-0">
                                                <thead class="table-light">
                                                    <tr>
                                                        <th scope="col" style="width: 50px;" class="text-center">
                                                            <input class="form-check-input" type="checkbox"
                                                                id="selectAll"
                                                                style="transform: scale(1.3); cursor: pointer;">
                                                        </th>
                                                        <th scope="col" colspan="2">Sản phẩm</th>
                                                        <th scope="col" class="text-center">Đơn giá</th>
                                                        <th scope="col" class="text-center">Số lượng</th>
                                                        <th scope="col" class="text-end">Thành tiền</th>
                                                        <th scope="col" class="text-center">Xóa</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="cartDetail" items="${cartDetails}"
                                                        varStatus="status">
                                                        <tr>
                                                            <td class="text-center align-middle">
                                                                <input class="form-check-input item-checkbox"
                                                                    type="checkbox" value="${cartDetail.id}"
                                                                    data-price="${cartDetail.price}"
                                                                    style="transform: scale(1.3); cursor: pointer;">
                                                            </td>
                                                            <td style="width: 100px;">
                                                                <a href="/product/${cartDetail.product.id}">
                                                                    <img src="/images/product/${cartDetail.product.image}"
                                                                        class="img-fluid rounded cart-item-img" alt="">
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
                                                                    <fmt:formatNumber type="number"
                                                                        value="${cartDetail.price}" /> đ
                                                                </p>
                                                            </td>
                                                            <td>
                                                                <div class="input-group quantity mx-auto"
                                                                    style="width: 100px;">
                                                                    <div class="input-group-btn">
                                                                        <button type="button"
                                                                            class="btn btn-sm btn-minus rounded-circle bg-light border">
                                                                            <i class="fa fa-minus"></i>
                                                                        </button>
                                                                    </div>
                                                                    <input type="text"
                                                                        class="form-control form-control-sm text-center border-0"
                                                                        value="${cartDetail.quantity}"
                                                                        data-cart-detail-id="${cartDetail.id}"
                                                                        data-cart-detail-price="${cartDetail.price}"
                                                                        data-cart-detail-index="${status.index}"
                                                                        data-stock="${cartDetail.product.quantity}">
                                                                    <div class="input-group-btn">
                                                                        <button type="button"
                                                                            class="btn btn-sm btn-plus rounded-circle bg-light border">
                                                                            <i class="fa fa-plus"></i>
                                                                        </button>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                            <td class="text-end">
                                                                <p class="mb-0 text-primary fw-bold"
                                                                    data-cart-detail-id="${cartDetail.id}">
                                                                    <fmt:formatNumber type="number"
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
                                            <a href="/" class="btn btn-outline-primary rounded-pill py-2 px-4">
                                                <i class="fas fa-arrow-left me-2"></i> Tiếp tục chọn đồ
                                            </a>
                                        </div>
                                    </div>

                                    <div class="col-lg-4">
                                        <div class="cart-summary-card bg-white p-4">
                                            <h4 class="mb-4 fw-bold">Thông tin Đơn hàng</h4>

                                            <div class="d-flex justify-content-between mb-3 text-muted">
                                                <span>Tạm tính (<span id="selected-count-display">0</span> SP):</span>
                                                <p class="mb-0 fw-bold text-dark" id="sub-total-display">0 đ</p>
                                            </div>
                                            <div class="d-flex justify-content-between mb-3 text-muted">
                                                <span>Phí vận chuyển:</span>
                                                <p class="mb-0 fw-bold text-success">0 đ</p>
                                            </div>

                                            <hr class="my-4">

                                            <div class="d-flex justify-content-between mb-4">
                                                <h5 class="mb-0 fw-bold">Tổng thanh toán:</h5>
                                                <p class="mb-0 fw-bold text-primary h5" id="total-price-display">0 đ</p>
                                            </div>

                                            <form action="/confirm-checkout" method="post" id="confirm-checkout-form">
                                                <input type="hidden" name="${_csrf.parameterName}"
                                                    value="${_csrf.token}" />
                                                <div style="display: none;">
                                                    <c:forEach var="cartDetail" items="${cartDetails}"
                                                        varStatus="status">
                                                        <input type="hidden" name="cartDetails[${status.index}].id"
                                                            value="${cartDetail.id}" />
                                                        <input type="hidden"
                                                            name="cartDetails[${status.index}].quantity"
                                                            value="${cartDetail.quantity}"
                                                            id="hidden-qty-${cartDetail.id}" />
                                                    </c:forEach>
                                                </div>
                                                <button
                                                    class="btn btn-primary rounded-pill w-100 py-3 fw-bold text-uppercase shadow"
                                                    type="button" id="btn-confirm-checkout">
                                                    Xác nhận đơn hàng <i class="fas fa-arrow-right ms-2"></i>
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
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
                                    <button type="submit" class="btn btn-danger">Xóa</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>

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
                    // HÀM TÍNH TOÁN LẠI TỔNG TIỀN VÀ SỐ LƯỢNG SP ĐƯỢC CHỌN
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

                        var formattedTotal = total.toLocaleString('vi-VN') + ' đ';
                        $('#sub-total-display').text(formattedTotal);
                        $('#total-price-display').text(formattedTotal);
                        $('#selected-count-display').text(count);
                    }

                    // HÀM KIỂM TRA TỒN KHO VÀ UI NÚT CỘNG/TRỪ
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

                    $(document).ready(function () {

                        // Chạy kiểm tra tồn kho ban đầu khi vừa load trang
                        $('input[data-cart-detail-id]').each(function () {
                            checkMaxStockUI($(this));
                        });

                        // 1. CHỨC NĂNG CHECKBOX VÀ TÍNH TIỀN THỜI GIAN THỰC
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

                        // 2. XỬ LÝ NHẬP SỐ LƯỢNG BẰNG TAY VÀ NÚT CỘNG/TRỪ (CÓ VALIDATE TỒN KHO)
                        $('input[data-cart-detail-id]').on('change input', function () {
                            var $input = $(this);
                            var id = $input.attr('data-cart-detail-id');
                            var maxStock = parseInt($input.attr('data-stock'));
                            var currentVal = parseInt($input.val());

                            if (isNaN(currentVal) || currentVal < 1) {
                                currentVal = 1;
                                $input.val(currentVal);
                            } else if (currentVal > maxStock) {
                                toastr.warning('Trong kho chỉ còn tối đa ' + maxStock + ' sản phẩm!', 'Vượt tồn kho');
                                currentVal = maxStock;
                                $input.val(currentVal);
                            }

                            $('#hidden-qty-' + id).val(currentVal);
                            calcSelectedTotal();
                            checkMaxStockUI($input);
                        });

                        $('.btn-plus').on('click', function () {
                            var $input = $(this).closest('.quantity').find('input[type="text"]');
                            setTimeout(function () {
                                var currentVal = parseInt($input.val());
                                var maxStock = parseInt($input.attr('data-stock'));

                                if (currentVal > maxStock) {
                                    toastr.warning('Trong kho chỉ còn tối đa ' + maxStock + ' sản phẩm!', 'Vượt tồn kho');
                                    $input.val(maxStock);
                                    currentVal = maxStock;
                                }

                                var id = $input.attr('data-cart-detail-id');
                                $('#hidden-qty-' + id).val(currentVal);
                                calcSelectedTotal();
                                checkMaxStockUI($input);
                            }, 50);
                        });

                        $('.btn-minus').on('click', function () {
                            var $input = $(this).closest('.quantity').find('input[type="text"]');
                            setTimeout(function () {
                                var currentVal = parseInt($input.val());
                                var id = $input.attr('data-cart-detail-id');
                                $('#hidden-qty-' + id).val(currentVal);
                                calcSelectedTotal();
                                checkMaxStockUI($input);
                            }, 50);
                        });

                        // 3. CHỨC NĂNG VALIDATE VÀ GỬI FORM THANH TOÁN
                        $('#btn-confirm-checkout').on('click', function (e) {
                            e.preventDefault();
                            var selectedIds = [];
                            $('.item-checkbox:checked').each(function () {
                                selectedIds.push($(this).val());
                            });

                            if (selectedIds.length === 0) {
                                toastr.warning('Vui lòng chọn ít nhất một sản phẩm để đặt hàng!', 'Chưa chọn sản phẩm');
                                return;
                            }

                            var form = $('#confirm-checkout-form');
                            form.find('input[name="selectedCartDetailIds"]').remove();

                            selectedIds.forEach(function (id) {
                                form.append('<input type="hidden" name="selectedCartDetailIds" value="' + id + '">');
                            });

                            form.submit();
                        });

                        // 4. CHỨC NĂNG XÓA SẢN PHẨM QUA AJAX
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
                                    toastr.options = {
                                        "closeButton": true,
                                        "progressBar": true,
                                        "positionClass": "toast-top-right",
                                        "timeOut": "1500"
                                    };
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