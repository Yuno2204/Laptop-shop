<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="utf-8" />
                    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                    <meta name="description" content="" />
                    <meta name="author" content="" />
                    <title>Register</title>
                    <link href="css/styles.css" rel="stylesheet" />
                    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
                        crossorigin="anonymous"></script>
                </head>

                <body class="bg-primary">
                    <div id="layoutAuthentication">
                        <div id="layoutAuthentication_content">
                            <main>
                                <div class="container">
                                    <div class="row justify-content-center">
                                        <div class="col-lg-7">
                                            <div class="card shadow-lg border-0 rounded-lg mt-5">
                                                <div class="card-header">
                                                    <h3 class="text-center font-weight-light my-4">Create Account</h3>
                                                </div>
                                                <div class="card-body">
                                                    <form:form method="post" action="/register"
                                                        modelAttribute="registerUser" enctype="multipart/form-data">
                                                        <div class="mb-3">
                                                            <label class="form-label">Ảnh đại diện (Avatar)</label>
                                                            <input type="file" name="avatarFile" class="form-control"
                                                                accept="image/png, image/jpeg" />
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-md-6 mb-3">
                                                                <spring:bind path="registerUser.firstName">
                                                                    <label class="form-label">Họ</label>
                                                                    <form:input path="firstName"
                                                                        class="form-control ${status.error ? 'is-invalid' : ''}"
                                                                        placeholder="Nhập họ" />
                                                                    <c:if test="${status.error}">
                                                                        <div class="invalid-feedback d-block">
                                                                            ${status.errorMessages[0]}
                                                                        </div>
                                                                    </c:if>
                                                                </spring:bind>
                                                            </div>

                                                            <div class="col-md-6 mb-3">
                                                                <spring:bind path="registerUser.lastName">
                                                                    <label class="form-label">Tên</label>
                                                                    <form:input path="lastName"
                                                                        class="form-control ${status.error ? 'is-invalid' : ''}"
                                                                        placeholder="Nhập tên" />
                                                                    <c:if test="${status.error}">
                                                                        <div class="invalid-feedback d-block">
                                                                            ${status.errorMessages[0]}
                                                                        </div>
                                                                    </c:if>
                                                                </spring:bind>
                                                            </div>
                                                        </div>

                                                        <!-- Email -->
                                                        <div class="mb-3">
                                                            <spring:bind path="registerUser.email">
                                                                <label class="form-label">Email</label>
                                                                <form:input path="email"
                                                                    class="form-control ${status.error ? 'is-invalid' : ''}"
                                                                    placeholder="example@gmail.com" />
                                                                <c:if test="${status.error}">
                                                                    <div class="invalid-feedback d-block">
                                                                        ${status.errorMessages[0]}
                                                                    </div>
                                                                </c:if>
                                                            </spring:bind>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-md-6 mb-3">
                                                                <spring:bind path="registerUser.address">
                                                                    <label class="form-label">Địa chỉ</label>
                                                                    <form:input path="address"
                                                                        class="form-control ${status.error ? 'is-invalid' : ''}"
                                                                        placeholder="Nhập địa chỉ cụ thể" />
                                                                    <c:if test="${status.error}">
                                                                        <div class="invalid-feedback d-block">
                                                                            ${status.errorMessages[0]}</div>
                                                                    </c:if>
                                                                </spring:bind>
                                                            </div>
                                                            <div class="col-md-6 mb-3">
                                                                <spring:bind path="registerUser.phone">
                                                                    <label class="form-label">Số điện thoại</label>
                                                                    <form:input path="phone"
                                                                        class="form-control ${status.error ? 'is-invalid' : ''}"
                                                                        placeholder="Nhập số điện thoại" />
                                                                    <c:if test="${status.error}">
                                                                        <div class="invalid-feedback d-block">
                                                                            ${status.errorMessages[0]}</div>
                                                                    </c:if>
                                                                </spring:bind>
                                                            </div>
                                                        </div>

                                                        <div class="row">
                                                            <div class="col-md-6 mb-3">
                                                                <spring:bind path="registerUser.gender">
                                                                    <label class="form-label">Giới tính</label>
                                                                    <form:select path="gender"
                                                                        class="form-select ${status.error ? 'is-invalid' : ''}">
                                                                        <form:option value="Nam">Nam</form:option>
                                                                        <form:option value="Nữ">Nữ</form:option>
                                                                        <form:option value="Khác">Khác</form:option>
                                                                    </form:select>
                                                                    <c:if test="${status.error}">
                                                                        <div class="invalid-feedback d-block">
                                                                            ${status.errorMessages[0]}</div>
                                                                    </c:if>
                                                                </spring:bind>
                                                            </div>
                                                            <div class="col-md-6 mb-3">
                                                                <spring:bind path="registerUser.dateOfBirth">
                                                                    <label class="form-label">Ngày sinh</label>
                                                                    <form:input type="date" path="dateOfBirth"
                                                                        class="form-control ${status.error ? 'is-invalid' : ''}" />
                                                                    <c:if test="${status.error}">
                                                                        <div class="invalid-feedback d-block">
                                                                            ${status.errorMessages[0]}</div>
                                                                    </c:if>
                                                                </spring:bind>
                                                            </div>
                                                        </div>
                                                        <!-- Password -->
                                                        <div class="row">
                                                            <div class="col-md-6 mb-3">
                                                                <spring:bind path="registerUser.password">
                                                                    <label class="form-label">Mật khẩu</label>
                                                                    <form:password path="password"
                                                                        class="form-control ${status.error ? 'is-invalid' : ''}"
                                                                        placeholder="Nhập mật khẩu" />
                                                                    <c:if test="${status.error}">
                                                                        <div class="invalid-feedback d-block">
                                                                            ${status.errorMessages[0]}
                                                                        </div>
                                                                    </c:if>
                                                                </spring:bind>
                                                            </div>

                                                            <div class="col-md-6 mb-3">
                                                                <spring:bind path="registerUser.confirmPassword">
                                                                    <label class="form-label">Nhập lại mật khẩu</label>
                                                                    <form:password path="confirmPassword"
                                                                        class="form-control ${status.error ? 'is-invalid' : ''}"
                                                                        placeholder="Nhập lại mật khẩu" />
                                                                    <c:if test="${status.error}">
                                                                        <div class="invalid-feedback d-block">
                                                                            ${status.errorMessages[0]}
                                                                        </div>
                                                                    </c:if>
                                                                </spring:bind>
                                                            </div>
                                                        </div>
                                                        <div class="mt-4 mb-0">
                                                            <div class="d-grid">
                                                                <button class="btn btn-primary btn-block">
                                                                    Đăng ký
                                                                </button>
                                                            </div>
                                                        </div>
                                                    </form:form>
                                                </div>
                                                <div class=" card-footer text-center py-3">
                                                    <div class="small"><a href="/login">Have an account?
                                                            Go to login</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </main>
                        </div>

                    </div>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                        crossorigin="anonymous"></script>
                    <script src="js/scripts.js"></script>
                </body>

                </html>