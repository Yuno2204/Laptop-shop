<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark shadow-sm">
            <a class="navbar-brand ps-3 fw-bold" href="/admin">
                <i class="fas fa-mobile-alt text-primary me-2"></i>LongHang
            </a>

            <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0 text-white-50" id="sidebarToggle"
                href="#!">
                <i class="fas fa-bars fs-5"></i>
            </button>

            <div class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0"></div>

            <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle d-flex align-items-center" id="navbarDropdown" href="#"
                        role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <span class="d-none d-md-inline-block me-2">
                            ${sessionScope.fullName != null ? sessionScope.fullName : 'Guest'}
                        </span>
                        <i class="fas fa-user-circle fs-4"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end shadow border-0 mt-2" aria-labelledby="navbarDropdown">
                        <li>
                            <form action="/logout" method="post" id="logoutForm" style="display:none;">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            </form>
                            <a class="dropdown-item text-danger" href="javascript:void(0);"
                                onclick="document.getElementById('logoutForm').submit();">
                                <i class="fas fa-sign-out-alt me-2"></i>Đăng xuất
                            </a>
                        </li>
                    </ul>
                </li>
            </ul>
        </nav>