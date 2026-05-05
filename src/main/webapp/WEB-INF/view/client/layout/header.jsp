<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <nav class="navbar navbar-expand-xl shadow-sm fixed-top bg-white">
            <div class="container px-0">
                <a href="/" class="navbar-brand">
                    <h1 class="text-primary fs-2 fw-bold mb-0">LongHang Mobile</h1>
                </a>
                <button class="navbar-toggler py-2 px-3" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarCollapse">
                    <span class="fa fa-bars text-primary"></span>
                </button>
                <div class="collapse navbar-collapse bg-white justify-content-between mx-5" id="navbarCollapse">
                    <div class="navbar-nav ">
                        <a href="/" class="nav-item nav-link active">Trang chủ</a>
                        <a href="/products" class="nav-item nav-link">Sản phẩm</a>
                        <a href="/contact" class="nav-item nav-link">Liên hệ</a>
                    </div>

                    <div class="d-flex m-3 me-0">
                        <c:choose>
                            <c:when test="${not empty pageContext.request.remoteUser}">

                                <a href="/cart" class="position-relative me-4 my-auto">
                                    <i class="fa fa-shopping-bag fa-2x"></i>
                                    <span
                                        class="position-absolute bg-secondary rounded-circle d-flex align-items-center justify-content-center text-dark px-1"
                                        style="top: -5px; left: 15px; height: 20px; min-width: 20px;">
                                        ${not empty sessionScope.sum ? sessionScope.sum : 0}
                                    </span>
                                </a>

                                <div class="dropdown my-auto">
                                    <a href="#" class="dropdown-toggle text-dark" role="button" id="dropdownMenuLink"
                                        data-bs-toggle="dropdown" aria-expanded="false">
                                        <i class="fas fa-user fa-2x"></i>
                                    </a>

                                    <ul class="dropdown-menu dropdown-menu-end p-3 shadow border-0"
                                        aria-labelledby="dropdownMenuLink" style="border-radius: 15px;">
                                        <li class="d-flex align-items-center flex-column border-bottom pb-3 mb-2"
                                            style="min-width: 250px;">
                                            <c:choose>
                                                <c:when test="${not empty sessionScope.avatar}">
                                                    <img style="width: 80px; height: 80px; border-radius: 50%; object-fit: cover; border: 2px solid #81c408;"
                                                        src="/images/avatar/${sessionScope.avatar}" alt="Avatar" />
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="fas fa-user-circle fa-4x text-secondary"></i>
                                                </c:otherwise>
                                            </c:choose>

                                            <div class="text-center mt-2 fw-bold text-dark fs-5">
                                                <c:out value="${sessionScope.fullName}" />
                                            </div>
                                            <small class="text-muted">${pageContext.request.remoteUser}</small>
                                        </li>

                                        <li>
                                            <a class="dropdown-item py-2" href="/profile">
                                                <i class="fas fa-user-cog me-2 text-primary"></i> Quản lý tài khoản
                                            </a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item py-2" href="/order-history">
                                                <i class="fas fa-history me-2 text-info"></i> Lịch sử mua hàng
                                            </a>
                                        </li>
                                        <li>
                                            <form method="post" action="/logout" class="m-0 p-0">
                                                <input type="hidden" name="${_csrf.parameterName}"
                                                    value="${_csrf.token}" />
                                                <button class="dropdown-item text-danger py-2 mt-1" type="submit">
                                                    <i class="fas fa-sign-out-alt me-2"></i> Đăng xuất
                                                </button>
                                            </form>
                                        </li>
                                    </ul>
                                </div>
                            </c:when>

                            <c:otherwise>
                                <a href="/login"
                                    class="btn border border-secondary rounded-pill px-4 py-2 text-primary fw-bold transition-all">
                                    <i class="fas fa-sign-in-alt me-2"></i>Đăng nhập
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </nav>