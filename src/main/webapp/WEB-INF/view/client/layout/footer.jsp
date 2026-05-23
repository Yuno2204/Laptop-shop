<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <div class="container-fluid bg-dark text-white-50 footer pt-5 mt-5">
            <div class="container py-5">
                <div class="row g-5">
                    <div class="col-lg-3 col-md-6">
                        <div class="footer-item">
                            <h4 class="text-light mb-4">Về Chúng Tôi</h4>
                            <p class="mb-4 text-white-50">LongHang Mobile chuyên mua bán, sửa chữa điện thoại di động.
                                Chuyên phụ kiện, linh kiện chính hãng.</p>
                            <a href="/about" class="btn btn-outline-primary py-2 px-4 rounded-pill transition-all">Xem
                                Thêm</a>
                        </div>
                    </div>

                    <div class="col-lg-3 col-md-6">
                        <div class="d-flex flex-column text-start footer-item">
                            <h4 class="text-light mb-4">Chính Sách</h4>
                            <a class="btn-link text-white-50 mb-2 text-decoration-none transition-all"
                                href="/policy/return"><i class="fas fa-angle-right me-2"></i>Chính sách đổi trả</a>
                            <a class="btn-link text-white-50 mb-2 text-decoration-none transition-all"
                                href="/policy/warranty"><i class="fas fa-angle-right me-2"></i>Chính sách bảo hành</a>
                            <a class="btn-link text-white-50 mb-2 text-decoration-none transition-all"
                                href="/policy/terms"><i class="fas fa-angle-right me-2"></i>Điều khoản sử dụng</a>
                            <a class="btn-link text-white-50 text-decoration-none transition-all" href="/policy/faq"><i
                                    class="fas fa-angle-right me-2"></i>Câu hỏi thường gặp</a>
                        </div>
                    </div>

                    <div class="col-lg-3 col-md-6">
                        <div class="d-flex flex-column text-start footer-item">
                            <h4 class="text-light mb-4">Tài Khoản</h4>
                            <a class="btn-link text-white-50 mb-2 text-decoration-none transition-all"
                                href="/account"><i class="fas fa-angle-right me-2"></i>Quản lý tài khoản</a>
                            <a class="btn-link text-white-50 mb-2 text-decoration-none transition-all" href="/cart"><i
                                    class="fas fa-angle-right me-2"></i>Giỏ hàng của tôi</a>
                            <a class="btn-link text-white-50 mb-2 text-decoration-none transition-all"
                                href="/order-history"><i class="fas fa-angle-right me-2"></i>Lịch sử mua hàng</a>
                        </div>
                    </div>

                    <div class="col-lg-3 col-md-6">
                        <div class="footer-item">
                            <h4 class="text-light mb-4">Liên Hệ</h4>
                            <a href="https://maps.app.goo.gl/896tvaW7w2Lx6GEC8" class="mb-2 text-white-50"><i
                                    class="fas fa-map-marker-alt me-3 text-primary"></i>
                                Ngã Tư, Việt Hùng, Hiệp Hòa, Bắc Ninh</a>
                            <p class="mb-2 text-white-50"><i
                                    class="fas fa-envelope me-3 text-primary"></i>Dienthoailonghang@gmail.com</p>
                            <p class="mb-4 text-white-50"><i class="fas fa-phone-alt me-3 text-primary"></i>0826166996
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="container-fluid copyright bg-dark py-4" style="border-top: 1px solid rgba(255, 255, 255, 0.1);">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-md-6 text-center text-md-start mb-3 mb-md-0">
                        <span class="text-light">
                            <i class="fas fa-copyright text-light me-2"></i> 2026
                            <a href="https://www.facebook.com/profile.php?id=100090097931335"
                                class="text-primary fw-bold text-decoration-none">LongHang Mobile</a>. Đã đăng
                            ký bản quyền.
                        </span>
                    </div>
                    <div class="col-md-6 my-auto text-center text-md-end text-white-50">
                        Thiết kế bởi <a class="text-primary text-decoration-none fw-bold"
                            href="https://www.facebook.com/cenlove.2204">Đinh Quang Đức</a>
                    </div>
                </div>
            </div>
        </div>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                var checkJquery = setInterval(function () {
                    if (window.jQuery) {
                        clearInterval(checkJquery);
                        $(document).ready(function () {

                            // Gỡ bỏ sự kiện submit cũ (nếu có) để chống duplicate request
                            $(document).off('submit', 'form[action*="/add-product-to-cart"]');

                            // Gắn sự kiện chuẩn
                            $(document).on('submit', 'form[action*="/add-product-to-cart"]', function (e) {
                                e.preventDefault();

                                var form = $(this);
                                var $btn = form.find('button[type="submit"]');

                                // Nếu nút đang xử lý, chặn spam click
                                if ($btn.prop('disabled') || $btn.hasClass('processing')) {
                                    return false;
                                }

                                var originalText = $btn.html();

                                // Đổi UI sang trạng thái Đang thêm
                                $btn.addClass('processing');
                                $btn.prop('disabled', true).html('<i class="fa fa-spinner fa-spin"></i> Đang thêm...');

                                $.ajax({
                                    type: 'POST',
                                    url: form.attr('action'),
                                    data: form.serialize(),
                                    dataType: 'json',
                                    success: function (response) {
                                        if (typeof toastr !== 'undefined') toastr.clear();

                                        if (response.success === true) {
                                            // Update Badge UI
                                            var $badge = $('.fa-shopping-bag, .fa-shopping-cart').siblings('.badge, .position-absolute');
                                            if ($badge.length) {
                                                $badge.text(response.cartCount);
                                            }

                                            if (typeof toastr !== 'undefined') {
                                                toastr.success(response.message, 'Thành công');
                                            }
                                        } else {
                                            // Lỗi: Vượt tồn kho
                                            if (typeof toastr !== 'undefined') {
                                                toastr.error(response.message, 'Từ chối');
                                            }

                                            if (response.message.includes('đạt giới hạn') || response.message.includes('không đủ')) {
                                                $btn.prop('disabled', true).html('<i class="fa fa-ban"></i> Đã hết hàng');
                                                return; // Giữ nguyên trạng thái khóa
                                            }
                                        }
                                    },
                                    error: function (xhr) {
                                        if (typeof toastr !== 'undefined') toastr.clear();
                                        if (xhr.status === 401) {
                                            if (typeof toastr !== 'undefined') toastr.warning('Vui lòng đăng nhập!');
                                            setTimeout(function () { window.location.href = '/login'; }, 1500);
                                        } else {
                                            if (typeof toastr !== 'undefined') toastr.error('Lỗi kết nối máy chủ!');
                                        }
                                    },
                                    complete: function () {
                                        // Phục hồi nút bấm nếu không bị khóa cứng (bởi lỗi tồn kho)
                                        $btn.removeClass('processing');
                                        if (!$btn.prop('disabled') || $btn.html().includes('Đang thêm')) {
                                            $btn.prop('disabled', false).html(originalText);
                                        }
                                    }
                                });
                            });
                        });
                    }
                }, 100);
            });
        </script>