<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="utf-8" />
            <meta name="viewport" content="width=device-width, initial-scale=1" />
            <title>Đăng nhập - LongHang Mobile</title>

            <link rel="preconnect" href="https://fonts.googleapis.com">
            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
            <link
                href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@700;800&display=swap"
                rel="stylesheet">
            <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>

            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">

            <style>
                /* NỀN TRANG ĐĂNG NHẬP */
                body {
                    /* Sử dụng ảnh nền của bạn có sẵn trong thư mục, phủ thêm một lớp màu đen mờ (0.6) để dễ đọc chữ */
                    background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.7)), url('/client/img/anhnen.jpg') center/cover no-repeat fixed;
                    font-family: 'Open Sans', sans-serif;
                    min-height: 100vh;
                    display: flex;
                    align-items: center;
                    position: relative;
                }

                /* Nút quay về trang chủ (Style Kính mờ) */
                .btn-back-home {
                    position: absolute;
                    top: 30px;
                    left: 30px;
                    background: rgba(255, 255, 255, 0.15);
                    color: #fff;
                    padding: 12px 25px;
                    border-radius: 50px;
                    text-decoration: none;
                    font-weight: 600;
                    font-size: 1.1rem;
                    backdrop-filter: blur(10px);
                    border: 1px solid rgba(255, 255, 255, 0.3);
                    transition: all 0.3s ease;
                    z-index: 10;
                }

                .btn-back-home:hover {
                    background: #fff;
                    color: #d32f2f;
                    transform: translateX(-5px);
                    box-shadow: 0 6px 20px rgba(0, 0, 0, 0.3);
                }

                /* FORM CARD - TO HƠN VÀ HIỆU ỨNG KÍNH MỜ */
                .login-card {
                    border: none;
                    border-radius: 24px;
                    box-shadow: 0 25px 50px rgba(0, 0, 0, 0.4);
                    overflow: hidden;
                    background: rgba(255, 255, 255, 0.95);
                    /* Trắng hơi trong suốt */
                    backdrop-filter: blur(15px);
                }

                .login-header {
                    background: linear-gradient(90deg, #d32f2f, #ff5252);
                    color: white;
                    padding: 40px 20px;
                    text-align: center;
                }

                .login-header h2 {
                    font-family: 'Raleway', sans-serif;
                    font-weight: 800;
                    font-size: 2.2rem;
                    margin: 0;
                    letter-spacing: 1px;
                    text-transform: uppercase;
                }

                .login-header p {
                    margin-top: 12px;
                    margin-bottom: 0;
                    font-size: 1.05rem;
                    opacity: 0.95;
                }

                .card-body {
                    padding: 50px 40px 40px 40px;
                    /* Tăng khoảng cách bên trong */
                }

                /* Ô NHẬP LIỆU - LÀM TO HƠN */
                .form-floating label {
                    color: #777;
                    font-size: 1.1rem;
                    padding: 1.2rem 1rem;
                }

                .form-control {
                    border-radius: 12px;
                    border: 2px solid #e0e0e0;
                    height: 65px;
                    /* Làm ô nhập liệu cao hơn */
                    font-size: 1.15rem;
                    /* Chữ gõ vào to hơn */
                    padding: 1.2rem 1rem;
                    background: #fafafa;
                }

                .form-control:focus {
                    border-color: #d32f2f;
                    box-shadow: 0 0 0 4px rgba(211, 47, 47, 0.1);
                    background: #fff;
                }

                .form-check-label {
                    font-size: 1.05rem;
                }

                .form-check-input {
                    width: 1.2em;
                    height: 1.2em;
                    margin-top: 0.2em;
                    cursor: pointer;
                }

                .form-check-input:checked {
                    background-color: #d32f2f;
                    border-color: #d32f2f;
                }

                /* NÚT ĐĂNG NHẬP - TO VÀ NỔI BẬT */
                .btn-login {
                    background-color: #d32f2f;
                    color: white;
                    border: none;
                    border-radius: 50px;
                    padding: 16px;
                    /* Làm nút béo hơn */
                    font-weight: bold;
                    font-size: 1.2rem;
                    /* Chữ trong nút to hơn */
                    text-transform: uppercase;
                    letter-spacing: 1px;
                    transition: all 0.3s ease;
                    width: 100%;
                    box-shadow: 0 8px 15px rgba(211, 47, 47, 0.2);
                }

                .btn-login:hover {
                    background-color: #b71c1c;
                    color: white;
                    transform: translateY(-3px);
                    box-shadow: 0 12px 20px rgba(211, 47, 47, 0.4);
                }

                /* Footer Card */
                .card-footer {
                    background: #f8f9fa;
                    border-top: 1px solid #eee;
                    padding: 25px;
                    font-size: 1.1rem;
                }

                .card-footer a {
                    color: #d32f2f;
                    text-decoration: none;
                    font-weight: 700;
                    transition: 0.2s;
                }

                .card-footer a:hover {
                    color: #b71c1c;
                    text-decoration: underline;
                }

                .alert {
                    border-radius: 12px;
                    font-weight: 600;
                    font-size: 1rem;
                    padding: 15px;
                }
            </style>
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
        </head>

        <body>

            <a href="/" class="btn-back-home">
                <i class="fas fa-arrow-left me-2"></i> Trang chủ
            </a>

            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-xl-5 col-lg-6 col-md-8 col-sm-10">
                        <div class="login-card mt-4 mb-4">

                            <div class="login-header">
                                <h2>Đăng nhập</h2>
                                <p>Chào mừng quay trở lại LongHang Mobile</p>
                            </div>

                            <div class="card-body">

                                <c:if test="${param.error != null}">
                                    <div class="alert alert-danger text-center shadow-sm" role="alert">
                                        <i class="fas fa-exclamation-circle me-2"></i> Email hoặc mật khẩu không đúng!
                                    </div>
                                </c:if>

                                <c:if test="${param.logout != null}">
                                    <div class="alert alert-success text-center shadow-sm" role="alert">
                                        <i class="fas fa-check-circle me-2"></i> Bạn đã đăng xuất an toàn.
                                    </div>
                                </c:if>

                                <form method="post" action="/login">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                                    <div class="form-floating mb-4">
                                        <input class="form-control" id="inputEmail" type="text" name="username"
                                            placeholder="Nhập email" required />
                                        <label for="inputEmail"><i class="fas fa-envelope me-2"></i>Email của
                                            bạn</label>
                                    </div>

                                    <div class="form-floating mb-3">
                                        <input class="form-control" id="inputPassword" type="password" name="password"
                                            placeholder="Nhập mật khẩu" required />
                                        <label for="inputPassword"><i class="fas fa-lock me-2"></i>Mật khẩu</label>
                                    </div>

                                    <div class="form-check mb-4 mt-3 ms-1">
                                        <input class="form-check-input" id="inputRememberPassword" type="checkbox"
                                            name="remember-me" />
                                        <label class="form-check-label text-muted ms-2" style="cursor: pointer;"
                                            for="inputRememberPassword">
                                            Ghi nhớ đăng nhập
                                        </label>
                                    </div>

                                    <div class="mt-5 mb-2">
                                        <button class="btn-login" type="submit">
                                            Đăng nhập ngay <i class="fas fa-sign-in-alt ms-2"></i>
                                        </button>
                                    </div>

                                </form>
                            </div>

                            <div class="card-footer text-center">
                                <div>
                                    <span class="text-muted">Chưa có tài khoản?</span>
                                    <a href="/register" class="ms-1">Đăng ký ngay</a>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>

            <c:if test="${param.register == 'success'}">
                <script>
                    $(document).ready(function () {
                        toastr.options = {
                            "closeButton": true,
                            "progressBar": true,
                            "positionClass": "toast-top-right",
                            "timeOut": "3500" // Hiển thị lâu hơn một chút (3.5 giây) để người dùng kịp đọc
                        };

                        // Hiển thị thông báo màu xanh lá (success)
                        toastr.success('Tài khoản của bạn đã được tạo thành công! Vui lòng đăng nhập.', 'Chào mừng thành viên mới');

                        // Xóa chữ ?register=success trên thanh địa chỉ URL cho đẹp
                        if (window.history.replaceState) {
                            const url = window.location.protocol + "//" + window.location.host + window.location.pathname;
                            window.history.replaceState({ path: url }, '', url);
                        }
                    });
                </script>
            </c:if>
        </body>

        </html>