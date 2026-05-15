<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

                <!DOCTYPE html>
                <html lang="vi">

                <head>
                    <meta charset="utf-8" />
                    <meta name="viewport" content="width=device-width, initial-scale=1" />
                    <title>Đăng ký tài khoản - LongHang Mobile</title>

                    <link rel="preconnect" href="https://fonts.googleapis.com">
                    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                    <link
                        href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@700;800&display=swap"
                        rel="stylesheet">
                    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
                        crossorigin="anonymous"></script>

                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
                        rel="stylesheet">

                    <style>
                        /* NỀN TRANG CÓ LỚP PHỦ MỜ */
                        body {
                            background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.7)), url('/client/img/anhnen.jpg') center/cover no-repeat fixed;
                            font-family: 'Open Sans', sans-serif;
                            min-height: 100vh;
                            display: flex;
                            align-items: center;
                            position: relative;
                            padding: 40px 0;
                            /* Cách lề trên dưới cho màn hình nhỏ có thể cuộn */
                        }

                        /* Nút quay về trang chủ */
                        .btn-back-home {
                            position: absolute;
                            top: 25px;
                            left: 25px;
                            background: rgba(255, 255, 255, 0.15);
                            color: #fff;
                            padding: 10px 20px;
                            border-radius: 50px;
                            text-decoration: none;
                            font-weight: 600;
                            font-size: 1.05rem;
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

                        /* CARD HIỆU ỨNG KÍNH MỜ */
                        .register-card {
                            border: none;
                            border-radius: 24px;
                            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.4);
                            overflow: hidden;
                            background: rgba(255, 255, 255, 0.95);
                            backdrop-filter: blur(15px);
                        }

                        .register-header {
                            background: linear-gradient(90deg, #d32f2f, #ff5252);
                            color: white;
                            padding: 30px 20px;
                            text-align: center;
                        }

                        .register-header h2 {
                            font-family: 'Raleway', sans-serif;
                            font-weight: 800;
                            font-size: 2rem;
                            margin: 0;
                            letter-spacing: 1px;
                            text-transform: uppercase;
                        }

                        .register-header p {
                            margin-top: 10px;
                            margin-bottom: 0;
                            font-size: 1.05rem;
                            opacity: 0.95;
                        }

                        .card-body {
                            padding: 40px 40px 30px 40px;
                        }

                        /* STYLE CHUNG CHO INPUT VÀ SELECT */
                        .form-floating label {
                            color: #777;
                            font-size: 1.05rem;
                            padding: 1rem;
                        }

                        .form-control,
                        .form-select {
                            border-radius: 12px;
                            border: 2px solid #e0e0e0;
                            height: 60px;
                            font-size: 1.1rem;
                            background: #fafafa;
                        }

                        /* Chỉnh riêng padding cho form-floating input */
                        .form-floating>.form-control {
                            padding: 1rem;
                        }

                        .form-control:focus,
                        .form-select:focus {
                            border-color: #d32f2f;
                            box-shadow: 0 0 0 4px rgba(211, 47, 47, 0.1);
                            background: #fff;
                        }

                        .form-label-custom {
                            font-weight: 600;
                            color: #666;
                            margin-bottom: 8px;
                            font-size: 1.05rem;
                        }

                        /* NÚT ĐĂNG KÝ */
                        .btn-register {
                            background-color: #d32f2f;
                            color: white;
                            border: none;
                            border-radius: 50px;
                            padding: 16px;
                            font-weight: bold;
                            font-size: 1.2rem;
                            text-transform: uppercase;
                            letter-spacing: 1px;
                            transition: all 0.3s ease;
                            width: 100%;
                            box-shadow: 0 8px 15px rgba(211, 47, 47, 0.2);
                        }

                        .btn-register:hover {
                            background-color: #b71c1c;
                            color: white;
                            transform: translateY(-3px);
                            box-shadow: 0 12px 20px rgba(211, 47, 47, 0.4);
                        }

                        /* FOOTER */
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

                        .invalid-feedback {
                            font-size: 0.9rem;
                            font-weight: 600;
                            margin-top: 5px;
                            padding-left: 5px;
                        }
                    </style>
                </head>

                <body>

                    <a href="/" class="btn-back-home d-none d-md-block">
                        <i class="fas fa-arrow-left me-2"></i> Trang chủ
                    </a>

                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-xl-8 col-lg-9 col-md-11">
                                <div class="register-card shadow-lg">

                                    <div class="register-header">
                                        <h2>Đăng ký tài khoản</h2>
                                        <p>Trở thành thành viên của LongHang Mobile ngay hôm nay</p>
                                    </div>

                                    <div class="card-body">

                                        <form:form method="post" action="/register" modelAttribute="registerUser"
                                            enctype="multipart/form-data">

                                            <div class="mb-4">
                                                <label class="form-label-custom ms-1"><i
                                                        class="fas fa-user-circle me-2 text-danger"></i>Ảnh đại diện
                                                    (Tùy chọn)</label>
                                                <input type="file" name="avatarFile" class="form-control"
                                                    accept="image/png, image/jpeg"
                                                    style="height: auto; padding: 12px;" />
                                            </div>

                                            <div class="row g-3 mb-3">
                                                <div class="col-md-6">
                                                    <spring:bind path="registerUser.firstName">
                                                        <div class="form-floating">
                                                            <form:input path="firstName"
                                                                class="form-control ${status.error ? 'is-invalid' : ''}"
                                                                placeholder="Nhập họ" />
                                                            <label><i class="fas fa-user me-2 text-muted"></i>Họ</label>
                                                            <c:if test="${status.error}">
                                                                <div class="invalid-feedback d-block">
                                                                    ${status.errorMessages[0]}</div>
                                                            </c:if>
                                                        </div>
                                                    </spring:bind>
                                                </div>
                                                <div class="col-md-6">
                                                    <spring:bind path="registerUser.lastName">
                                                        <div class="form-floating">
                                                            <form:input path="lastName"
                                                                class="form-control ${status.error ? 'is-invalid' : ''}"
                                                                placeholder="Nhập tên" />
                                                            <label><i
                                                                    class="fas fa-id-badge me-2 text-muted"></i>Tên</label>
                                                            <c:if test="${status.error}">
                                                                <div class="invalid-feedback d-block">
                                                                    ${status.errorMessages[0]}</div>
                                                            </c:if>
                                                        </div>
                                                    </spring:bind>
                                                </div>
                                            </div>

                                            <div class="mb-3">
                                                <spring:bind path="registerUser.email">
                                                    <div class="form-floating">
                                                        <form:input path="email"
                                                            class="form-control ${status.error ? 'is-invalid' : ''}"
                                                            placeholder="example@gmail.com" />
                                                        <label><i class="fas fa-envelope me-2 text-muted"></i>Địa chỉ
                                                            Email</label>
                                                        <c:if test="${status.error}">
                                                            <div class="invalid-feedback d-block">
                                                                ${status.errorMessages[0]}</div>
                                                        </c:if>
                                                    </div>
                                                </spring:bind>
                                            </div>

                                            <div class="row g-3 mb-3">
                                                <div class="col-md-6">
                                                    <spring:bind path="registerUser.address">
                                                        <div class="form-floating">
                                                            <form:input path="address"
                                                                class="form-control ${status.error ? 'is-invalid' : ''}"
                                                                placeholder="Nhập địa chỉ" />
                                                            <label><i
                                                                    class="fas fa-map-marker-alt me-2 text-muted"></i>Địa
                                                                chỉ</label>
                                                            <c:if test="${status.error}">
                                                                <div class="invalid-feedback d-block">
                                                                    ${status.errorMessages[0]}</div>
                                                            </c:if>
                                                        </div>
                                                    </spring:bind>
                                                </div>
                                                <div class="col-md-6">
                                                    <spring:bind path="registerUser.phone">
                                                        <div class="form-floating">
                                                            <form:input path="phone"
                                                                class="form-control ${status.error ? 'is-invalid' : ''}"
                                                                placeholder="Nhập số điện thoại" />
                                                            <label><i class="fas fa-phone-alt me-2 text-muted"></i>Số
                                                                điện thoại</label>
                                                            <c:if test="${status.error}">
                                                                <div class="invalid-feedback d-block">
                                                                    ${status.errorMessages[0]}</div>
                                                            </c:if>
                                                        </div>
                                                    </spring:bind>
                                                </div>
                                            </div>

                                            <div class="row g-3 mb-3">
                                                <div class="col-md-6">
                                                    <spring:bind path="registerUser.gender">
                                                        <div class="form-floating">
                                                            <form:select path="gender"
                                                                class="form-select ${status.error ? 'is-invalid' : ''}">
                                                                <form:option value="Nam">Nam</form:option>
                                                                <form:option value="Nữ">Nữ</form:option>
                                                                <form:option value="Khác">Khác</form:option>
                                                            </form:select>
                                                            <label><i class="fas fa-venus-mars me-2 text-muted"></i>Giới
                                                                tính</label>
                                                            <c:if test="${status.error}">
                                                                <div class="invalid-feedback d-block">
                                                                    ${status.errorMessages[0]}</div>
                                                            </c:if>
                                                        </div>
                                                    </spring:bind>
                                                </div>
                                                <div class="col-md-6">
                                                    <spring:bind path="registerUser.dateOfBirth">
                                                        <div class="form-floating">
                                                            <form:input type="date" path="dateOfBirth"
                                                                class="form-control ${status.error ? 'is-invalid' : ''}" />
                                                            <label><i
                                                                    class="fas fa-calendar-alt me-2 text-muted"></i>Ngày
                                                                sinh</label>
                                                            <c:if test="${status.error}">
                                                                <div class="invalid-feedback d-block">
                                                                    ${status.errorMessages[0]}</div>
                                                            </c:if>
                                                        </div>
                                                    </spring:bind>
                                                </div>
                                            </div>

                                            <div class="row g-3 mb-4">
                                                <div class="col-md-6">
                                                    <spring:bind path="registerUser.password">
                                                        <div class="form-floating">
                                                            <form:password path="password"
                                                                class="form-control ${status.error ? 'is-invalid' : ''}"
                                                                placeholder="Mật khẩu" />
                                                            <label><i class="fas fa-lock me-2 text-muted"></i>Mật
                                                                khẩu</label>
                                                            <c:if test="${status.error}">
                                                                <div class="invalid-feedback d-block">
                                                                    ${status.errorMessages[0]}</div>
                                                            </c:if>
                                                        </div>
                                                    </spring:bind>
                                                </div>
                                                <div class="col-md-6">
                                                    <spring:bind path="registerUser.confirmPassword">
                                                        <div class="form-floating">
                                                            <form:password path="confirmPassword"
                                                                class="form-control ${status.error ? 'is-invalid' : ''}"
                                                                placeholder="Nhập lại mật khẩu" />
                                                            <label><i class="fas fa-shield-alt me-2 text-muted"></i>Nhập
                                                                lại mật khẩu</label>
                                                            <c:if test="${status.error}">
                                                                <div class="invalid-feedback d-block">
                                                                    ${status.errorMessages[0]}</div>
                                                            </c:if>
                                                        </div>
                                                    </spring:bind>
                                                </div>
                                            </div>

                                            <div class="mt-5 mb-2">
                                                <button class="btn-register" type="submit">
                                                    Tạo tài khoản <i class="fas fa-user-plus ms-2"></i>
                                                </button>
                                            </div>

                                        </form:form>
                                    </div>

                                    <div class="card-footer text-center">
                                        <div class="small">
                                            <span class="text-muted">Đã có tài khoản?</span>
                                            <a href="/login" class="ms-1">Đăng nhập ngay</a>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>

                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                        crossorigin="anonymous"></script>

                </body>

                </html>