<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

            <div id="layoutSidenav_nav">
                <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                    <div class="sb-sidenav-menu">
                        <div class="nav pt-3">

                            <sec:authorize access="hasRole('ADMIN')">
                                <div class="sb-sidenav-menu-heading">Hệ thống</div>
                                <a class="nav-link" href="/admin">
                                    <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                                    Dashboard
                                </a>
                            </sec:authorize>

                            <div class="sb-sidenav-menu-heading">Quản lý</div>

                            <sec:authorize access="hasRole('ADMIN')">
                                <a class="nav-link" href="/admin/user">
                                    <div class="sb-nav-link-icon"><i class="fas fa-users"></i></div>
                                    Người dùng
                                </a>
                            </sec:authorize>

                            <a class="nav-link" href="/admin/product">
                                <div class="sb-nav-link-icon"><i class="fas fa-box"></i></div>
                                Sản phẩm
                            </a>

                            <a class="nav-link" href="/admin/order">
                                <div class="sb-nav-link-icon"><i class="fas fa-receipt"></i></div>
                                Đơn hàng
                            </a>

                            <a class="nav-link" href="/admin/inventory">
                                <div class="sb-nav-link-icon"><i class="fas fa-warehouse"></i></div>
                                Quản lý tồn kho
                            </a>

                        </div>
                    </div>

                    <div class="sb-sidenav-footer">
                        <div class="small">Đang đăng nhập:</div>
                        <i class="fas fa-circle text-success me-1" style="font-size: 10px;"></i>
                        ${not empty sessionScope.fullName ? sessionScope.fullName : "Chưa đăng nhập"}
                    </div>
                </nav>
            </div>

            <script>
                document.addEventListener("DOMContentLoaded", function () {
                    const path = window.location.pathname;
                    document.querySelectorAll('.sb-sidenav .nav-link').forEach(link => {
                        const href = link.getAttribute('href');
                        if (path === href || (href !== '/admin' && path.startsWith(href))) {
                            link.classList.add('active');
                        }
                    });
                });
            </script>