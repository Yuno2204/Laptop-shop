<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="utf-8" />
            <meta name="viewport" content="width=device-width, initial-scale=1" />
            <title>Đăng nhập - Mobile Shop</title>

            <link href="/css/styles.css" rel="stylesheet" />
            <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        </head>

        <body class="bg-primary">

            <div id="layoutAuthentication">
                <div id="layoutAuthentication_content">

                    <main>
                        <div class="container">
                            <div class="row justify-content-center">
                                <div class="col-lg-5">

                                    <div class="card shadow-lg border-0 rounded-lg mt-5">

                                        <!-- HEADER -->
                                        <div class="card-header">
                                            <h3 class="text-center font-weight-light my-4">Đăng nhập</h3>
                                        </div>

                                        <!-- BODY -->
                                        <div class="card-body">

                                            <!-- ERROR -->
                                            <c:if test="${param.error != null}">
                                                <div class="alert alert-danger text-center">
                                                    Email hoặc mật khẩu không đúng
                                                </div>
                                            </c:if>

                                            <!-- LOGOUT -->
                                            <c:if test="${param.logout != null}">
                                                <div class="alert alert-success text-center">
                                                    Đăng xuất thành công
                                                </div>
                                            </c:if>

                                            <!-- FORM -->
                                            <form method="post" action="/login">

                                                <!-- CSRF -->
                                                <input type="hidden" name="${_csrf.parameterName}"
                                                    value="${_csrf.token}" />

                                                <!-- EMAIL -->
                                                <div class="form-floating mb-3">
                                                    <input class="form-control" id="inputEmail" type="text"
                                                        name="username" placeholder="Nhập email" />
                                                    <label for="inputEmail">Email</label>
                                                </div>

                                                <!-- PASSWORD -->
                                                <div class="form-floating mb-3">
                                                    <input class="form-control" id="inputPassword" type="password"
                                                        name="password" placeholder="Nhập mật khẩu" />
                                                    <label for="inputPassword">Mật khẩu</label>
                                                </div>

                                                <!-- REMEMBER -->
                                                <div class="form-check mb-3">
                                                    <input class="form-check-input" id="inputRememberPassword"
                                                        type="checkbox" name="remember-me" />
                                                    <label class="form-check-label" for="inputRememberPassword">
                                                        Ghi nhớ đăng nhập
                                                    </label>
                                                </div>

                                                <!-- BUTTON -->
                                                <div class="d-flex justify-content-center align-items-center mt-4 mb-0">
                                                    <button class="btn btn-primary" type="submit">
                                                        Đăng nhập
                                                    </button>
                                                </div>

                                            </form>
                                        </div>
                                        <!-- FOOTER -->
                                        <div class="card-footer text-center py-3">
                                            <div class="small">
                                                <a href="/register">Chưa có tài khoản? Đăng ký</a>
                                            </div>
                                        </div>


                                    </div>
                                </div>
                            </div>
                    </main>

                </div>



            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
            <script src="/js/scripts.js"></script>

        </body>

        </html>