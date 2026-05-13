<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <style>
            /* Biến màu chủ đạo */
            :root {
                --nav-red: #d32f2f;
                --nav-red-hover: #b71c1c;
                --nav-light-red: #ffebee;
            }

            /* Navbar Chung */
            .navbar-custom {
                background-color: rgba(255, 255, 255, 0.98) !important;
                backdrop-filter: blur(10px);
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
                transition: all 0.3s ease;
            }

            /* Logo Brand */
            .brand-text {
                background: linear-gradient(90deg, var(--nav-red), #ff5252);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                font-weight: 900;
                letter-spacing: -0.5px;
            }

            /* Hiệu ứng gạch chân cho Menu Links */
            .nav-link-custom {
                color: #444 !important;
                font-weight: 600;
                font-size: 1.05rem;
                margin: 0 10px;
                position: relative;
                transition: color 0.3s;
            }

            .nav-link-custom:hover,
            .nav-link-custom.active {
                color: var(--nav-red) !important;
            }

            .nav-link-custom::after {
                content: '';
                position: absolute;
                width: 0;
                height: 2px;
                bottom: 0;
                left: 50%;
                transform: translateX(-50%);
                background-color: var(--nav-red);
                transition: width 0.3s ease;
            }

            .nav-link-custom:hover::after,
            .nav-link-custom.active::after {
                width: 100%;
            }

            /* Icon Giỏ Hàng */
            .cart-icon-wrapper {
                color: #333;
                transition: all 0.3s;
            }

            .cart-icon-wrapper:hover {
                color: var(--nav-red);
                transform: translateY(-2px);
            }

            .cart-badge {
                background-color: var(--nav-red);
                color: white;
                font-size: 0.75rem;
                font-weight: bold;
                box-shadow: 0 2px 5px rgba(211, 47, 47, 0.4);
            }

            /* User Dropdown */
            .user-dropdown-menu {
                border-radius: 16px;
                border: none;
                box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
                margin-top: 15px !important;
                animation: fadeInDropdown 0.3s ease forwards;
            }

            @keyframes fadeInDropdown {
                from {
                    opacity: 0;
                    transform: translateY(10px);
                }

                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .dropdown-item-custom {
                padding: 10px 20px;
                font-weight: 500;
                color: #555;
                transition: 0.2s;
            }

            .dropdown-item-custom:hover {
                background-color: var(--nav-light-red);
                color: var(--nav-red);
            }

            /* Nút Login */
            .btn-login-custom {
                border: 2px solid var(--nav-red);
                color: var(--nav-red);
                font-weight: 700;
                transition: all 0.3s ease;
            }

            .btn-login-custom:hover {
                background-color: var(--nav-red);
                color: white;
                box-shadow: 0 5px 15px rgba(211, 47, 47, 0.3);
            }

            /* Avatar User */
            .avatar-img {
                width: 70px;
                height: 70px;
                border-radius: 50%;
                object-fit: cover;
                border: 3px solid var(--nav-light-red);
                padding: 2px;
            }
        </style>

        <nav class="navbar navbar-expand-xl fixed-top navbar-custom py-2">
            <div class="container">
                <a href="/" class="navbar-brand d-flex align-items-center">
                    <h1 class="brand-text fs-2 mb-0">LongHang Mobile</h1>
                </a>

                <button class="navbar-toggler border-0 shadow-none" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarCollapse">
                    <span class="fa fa-bars fs-3" style="color: var(--nav-red);"></span>
                </button>

                <div class="collapse navbar-collapse justify-content-between" id="navbarCollapse">
                    <div class="navbar-nav mx-auto">
                        <a href="/" class="nav-item nav-link nav-link-custom">Trang chủ</a>
                        <a href="/products" class="nav-item nav-link nav-link-custom">Sản phẩm</a>
                        <a href="/about" class="nav-item nav-link nav-link-custom">Về chúng tôi</a>
                    </div>
                </div>

                <div class="d-flex align-items-center mt-3 mt-xl-0 gap-4">
                    <c:choose>
                        <c:when test="${not empty pageContext.request.remoteUser}">

                            <a href="/cart" class="position-relative cart-icon-wrapper">
                                <i class="fa fa-shopping-cart fa-2x"></i>
                                <span
                                    class="position-absolute rounded-circle d-flex align-items-center justify-content-center cart-badge px-1"
                                    style="top: -6px; right: -10px; height: 22px; min-width: 22px;">
                                    ${not empty sessionScope.sum ? sessionScope.sum : 0}
                                </span>
                            </a>

                            <div class="dropdown">
                                <a href="#"
                                    class="text-dark text-decoration-none d-flex align-items-center dropdown-toggle"
                                    role="button" id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                    <c:choose>
                                        <c:when test="${not empty sessionScope.avatar}">
                                            <img src="/images/avatar/${sessionScope.avatar}" alt="Avatar"
                                                style="width: 40px; height: 40px; border-radius: 50%; object-fit: cover; border: 2px solid var(--nav-red);">
                                        </c:when>
                                        <c:otherwise>
                                            <i class="fas fa-user-circle fa-2x" style="color: var(--nav-red);"></i>
                                        </c:otherwise>
                                    </c:choose>
                                </a>

                                <ul class="dropdown-menu dropdown-menu-end p-2 user-dropdown-menu"
                                    aria-labelledby="userDropdown">
                                    <li class="d-flex align-items-center flex-column border-bottom pb-3 mb-2 pt-2"
                                        style="min-width: 260px;">
                                        <c:choose>
                                            <c:when test="${not empty sessionScope.avatar}">
                                                <img class="avatar-img" src="/images/avatar/${sessionScope.avatar}"
                                                    alt="Avatar" />
                                            </c:when>
                                            <c:otherwise>
                                                <i class="fas fa-user-circle fa-4x" style="color: #ccc;"></i>
                                            </c:otherwise>
                                        </c:choose>
                                        <div class="text-center mt-2 fw-bold text-dark fs-5">
                                            <c:out value="${sessionScope.fullName}" />
                                        </div>
                                        <span
                                            class="badge bg-danger mt-1 rounded-pill">${pageContext.request.remoteUser}</span>
                                    </li>

                                    <li>
                                        <a class="dropdown-item dropdown-item-custom rounded" href="/account">
                                            <i class="fas fa-user-cog me-2" style="color: var(--nav-red);"></i> Quản
                                            lý tài khoản
                                        </a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item dropdown-item-custom rounded mt-1"
                                            href="/order-history">
                                            <i class="fas fa-box-open me-2 text-primary"></i> Đơn hàng của tôi
                                        </a>
                                    </li>
                                    <li>
                                        <form method="post" action="/logout" class="m-0 p-0 mt-1">
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                            <button
                                                class="dropdown-item dropdown-item-custom rounded text-danger fw-bold"
                                                type="submit">
                                                <i class="fas fa-sign-out-alt me-2"></i> Đăng xuất
                                            </button>
                                        </form>
                                    </li>
                                </ul>
                            </div>
                        </c:when>

                        <c:otherwise>
                            <a href="/login" class="btn btn-login-custom rounded-pill px-4 py-2">
                                <i class="fas fa-sign-in-alt me-2"></i>Đăng nhập
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            </div>
        </nav>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                // Lấy đường dẫn hiện tại (VD: "/", "/products", "/product/1")
                let currentPath = window.location.pathname;
                let navLinks = document.querySelectorAll('.navbar-nav .nav-link-custom');

                // 1. Xóa class active ở tất cả các thẻ
                navLinks.forEach(link => link.classList.remove('active'));

                // 2. So sánh và add lại class active vào đúng thẻ
                if (currentPath.startsWith("/product")) {
                    // Dành cho trang danh sách sản phẩm và chi tiết sản phẩm
                    document.querySelector('.navbar-nav a[href="/products"]')?.classList.add('active');
                } else if (currentPath.startsWith("/about") || currentPath.startsWith("/policy")) {
                    // Dành cho trang Về chúng tôi / Chính sách
                    document.querySelector('.navbar-nav a[href="/about"]')?.classList.add('active');
                } else if (currentPath === "/") {
                    // Dành cho trang chủ
                    document.querySelector('.navbar-nav a[href="/"]')?.classList.add('active');
                }
            });
        </script>