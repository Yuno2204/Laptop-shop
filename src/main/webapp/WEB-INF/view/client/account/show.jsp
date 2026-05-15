<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

                <html lang="en">

                <head>
                    <meta charset="UTF-8" />
                    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                    <title>HomePage</title>
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
                </head>

                <body>
                    <jsp:include page="../layout/header.jsp" />

                    <div class="container-fluid py-5 mt-5 bg-light">
                        <div class="container py-5">
                            <div class="row g-4">
                                <div class="col-lg-4">
                                    <div class="card shadow border-0 text-center p-4 rounded-4">
                                        <img src="/images/avatar/${user.avatar}"
                                            class="rounded-circle mx-auto img-thumbnail mb-3"
                                            style="width: 150px; height: 150px; object-fit: cover;">
                                        <h4 class="fw-bold">${user.fullName}</h4>
                                        <p class="text-muted mb-0"><i class="fas fa-envelope me-2"></i>${user.email}</p>
                                    </div>
                                </div>

                                <div class="col-lg-8">
                                    <div class="card shadow border-0 p-4 rounded-4">
                                        <c:if test="${not empty error}">
                                            <div class="alert alert-danger border-0 shadow-sm">${error}</div>
                                        </c:if>
                                        <c:if test="${param.success == 'profile' || not empty success}">
                                            <div class="alert alert-success border-0 shadow-sm">
                                                ${not empty success ? success : 'Cập nhật thông tin thành công!'}
                                            </div>
                                        </c:if>

                                        <ul class="nav nav-pills mb-4" id="pills-tab" role="tablist">
                                            <li class="nav-item" role="presentation">
                                                <button class="nav-link active rounded-pill me-2 fw-bold px-4"
                                                    id="pills-profile-tab" data-bs-toggle="pill"
                                                    data-bs-target="#pills-profile" type="button" role="tab"
                                                    aria-controls="pills-profile" aria-selected="true">
                                                    Thông tin cá nhân
                                                </button>
                                            </li>
                                            <li class="nav-item" role="presentation">
                                                <button class="nav-link rounded-pill fw-bold px-4"
                                                    id="pills-password-tab" data-bs-toggle="pill"
                                                    data-bs-target="#pills-password" type="button" role="tab"
                                                    aria-controls="pills-password" aria-selected="false">
                                                    Đổi mật khẩu
                                                </button>
                                            </li>
                                        </ul>

                                        <div class="tab-content" id="pills-tabContent">
                                            <div class="tab-pane fade show active" id="pills-profile" role="tabpanel"
                                                aria-labelledby="pills-profile-tab" tabindex="0">
                                                <form:form action="/account/update" method="post" modelAttribute="user">
                                                    <form:hidden path="id" />
                                                    <form:hidden path="password" />
                                                    <form:hidden path="avatar" />

                                                    <div class="row g-3">
                                                        <div class="col-12">
                                                            <label class="form-label fw-bold">Email (Không thể thay
                                                                đổi)</label>
                                                            <form:input path="email" class="form-control bg-light p-2"
                                                                readonly="true" />
                                                            <form:errors path="email"
                                                                cssClass="text-danger d-block mt-1" />
                                                        </div>
                                                        <div class="col-12">
                                                            <label class="form-label fw-bold">Họ và tên <span
                                                                    class="text-danger">*</span></label>
                                                            <form:input path="fullName" class="form-control p-2" />
                                                            <form:errors path="fullName"
                                                                cssClass="text-danger d-block mt-1" />
                                                        </div>
                                                        <div class="col-md-6">
                                                            <label class="form-label fw-bold">Số điện thoại <span
                                                                    class="text-danger">*</span></label>
                                                            <form:input path="phone" class="form-control p-2" />
                                                            <form:errors path="phone"
                                                                cssClass="text-danger d-block mt-1" />
                                                        </div>
                                                        <div class="col-md-6">
                                                            <label class="form-label fw-bold">Ngày sinh <span
                                                                    class="text-danger">*</span></label>
                                                            <form:input type="date" path="dateOfBirth"
                                                                class="form-control p-2" />
                                                            <form:errors path="dateOfBirth"
                                                                cssClass="text-danger d-block mt-1" />
                                                        </div>
                                                        <div class="col-md-6">
                                                            <label class="form-label fw-bold">Giới tính <span
                                                                    class="text-danger">*</span></label>
                                                            <form:select path="gender" class="form-select p-2">
                                                                <form:option value="Male">Nam</form:option>
                                                                <form:option value="Female">Nữ</form:option>
                                                                <form:option value="Other">Khác</form:option>
                                                            </form:select>
                                                            <form:errors path="gender"
                                                                cssClass="text-danger d-block mt-1" />
                                                        </div>
                                                        <div class="col-12">
                                                            <label class="form-label fw-bold">Địa chỉ <span
                                                                    class="text-danger">*</span></label>
                                                            <form:input path="address" class="form-control p-2"
                                                                rows="3" />
                                                            <form:errors path="address"
                                                                cssClass="text-danger d-block mt-1" />
                                                        </div>
                                                        <div class="col-12 text-end mt-4">
                                                            <button type="submit"
                                                                class="btn btn-primary px-5 rounded-pill shadow-sm">Lưu
                                                                cập nhật</button>
                                                        </div>
                                                    </div>
                                                </form:form>
                                            </div>

                                            <div class="tab-pane fade" id="pills-password" role="tabpanel"
                                                aria-labelledby="pills-password-tab" tabindex="0">
                                                <c:if test="${not empty pwdError}">
                                                    <div class="alert alert-danger border-0 shadow-sm"><i
                                                            class="fas fa-exclamation-circle me-2"></i>${pwdError}</div>
                                                </c:if>
                                                <c:if test="${not empty pwdSuccess}">
                                                    <div class="alert alert-success border-0 shadow-sm"><i
                                                            class="fas fa-check-circle me-2"></i>${pwdSuccess}</div>
                                                </c:if>

                                                <form action="/account/change-password" method="POST">
                                                    <input type="hidden" name="${_csrf.parameterName}"
                                                        value="${_csrf.token}" />

                                                    <div class="mb-3">
                                                        <label class="form-label fw-bold">Mật khẩu hiện tại</label>
                                                        <input type="password" name="oldPassword"
                                                            class="form-control p-2" required
                                                            placeholder="Nhập mật khẩu cũ" />
                                                    </div>
                                                    <div class="mb-3">
                                                        <label class="form-label fw-bold">Mật khẩu mới</label>
                                                        <input type="password" name="newPassword"
                                                            class="form-control p-2" required
                                                            placeholder="Tối thiểu 8 ký tự" minlength="8" />
                                                    </div>
                                                    <div class="mb-3">
                                                        <label class="form-label fw-bold">Xác nhận mật khẩu mới</label>
                                                        <input type="password" name="confirmPassword"
                                                            class="form-control p-2" required
                                                            placeholder="Nhập lại mật khẩu mới" minlength="8" />
                                                    </div>
                                                    <div class="text-end mt-4">
                                                        <button type="submit"
                                                            class="btn btn-danger px-5 rounded-pill shadow-sm"><i
                                                                class="fas fa-key me-2"></i>Cập nhật mật khẩu</button>
                                                    </div>
                                                </form>
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
                        document.addEventListener("DOMContentLoaded", function () {
                            const urlParams = new URLSearchParams(window.location.search);
                            const tab = urlParams.get('tab');

                            if (tab === 'password') {
                                // Sử dụng API chuẩn của Bootstrap
                                var triggerEl = document.querySelector('#pills-password-tab');
                                if (triggerEl) {
                                    var tabInstance = new bootstrap.Tab(triggerEl);
                                    tabInstance.show();
                                }
                            }
                        });
                    </script>
                </body>

                </html>