<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
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

                /* Icon Giỏ Hàng & Chuông Thông Báo */
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

                /* User & Notification Dropdown */
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

                    <div class="d-flex align-items-center mt-3 mt-xl-0 gap-3">
                        <c:choose>
                            <c:when test="${not empty pageContext.request.remoteUser}">

                                <div class="dropdown">
                                    <a href="#"
                                        class="cart-icon-wrapper d-inline-flex align-items-center justify-content-center position-relative text-decoration-none"
                                        id="notificationDropdown" data-bs-toggle="dropdown" aria-expanded="false"
                                        style="width: 44px; height: 44px;">
                                        <i class="fa fa-bell fa-2x"></i>
                                        <span id="notificationBadge"
                                            class="position-absolute rounded-circle d-flex align-items-center justify-content-center bg-danger text-white d-none"
                                            style="top: 0px; right: 0px; height: 22px; min-width: 22px; font-size: 0.75rem; font-weight: bold; box-shadow: 0 2px 5px rgba(211, 47, 47, 0.4); padding: 0 4px;">
                                            0
                                        </span>
                                    </a>
                                    <ul class="dropdown-menu dropdown-menu-end p-2 user-dropdown-menu"
                                        aria-labelledby="notificationDropdown" id="notificationList"
                                        style="width: 350px; max-height: 400px; overflow-y: auto;">
                                        <li><span class="dropdown-item text-center text-muted">Đang tải thông
                                                báo...</span></li>
                                    </ul>
                                </div>

                                <a href="/cart"
                                    class="cart-icon-wrapper d-inline-flex align-items-center justify-content-center position-relative text-decoration-none"
                                    style="width: 44px; height: 44px;">
                                    <i class="fa fa-shopping-cart fa-2x"></i>
                                    <span
                                        class="position-absolute rounded-circle d-flex align-items-center justify-content-center cart-badge"
                                        style="top: 0px; right: 0px; height: 22px; min-width: 22px; padding: 0 4px;">
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

                                        <sec:authorize access="hasRole('ADMIN')">
                                            <li>
                                                <a href="/admin"
                                                    class="dropdown-item dropdown-item-custom rounded mt-1">
                                                    <i class="fas fa-user-shield me-2 text-warning"></i> Trang quản trị
                                                    Admin
                                                </a>
                                            </li>
                                        </sec:authorize>

                                        <sec:authorize access="hasRole('EMPLOYEE')">
                                            <li>
                                                <a href="/admin/product"
                                                    class="dropdown-item dropdown-item-custom rounded mt-1">
                                                    <i class="fas fa-tasks me-2 text-info"></i> Trang quản lý Nhân viên
                                                </a>
                                            </li>
                                        </sec:authorize>

                                        <li>
                                            <form method="post" action="/logout" class="m-0 p-0 mt-1">
                                                <input type="hidden" name="${_csrf.parameterName}"
                                                    value="${_csrf.token}" />
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
            </nav>

            <script>
                document.addEventListener("DOMContentLoaded", function () {
                    // 1. Logic kiểm tra và thêm class active cho thanh Menu
                    let currentPath = window.location.pathname;
                    let navLinks = document.querySelectorAll('.navbar-nav .nav-link-custom');

                    navLinks.forEach(link => link.classList.remove('active'));
                    if (currentPath.startsWith("/product")) {
                        document.querySelector('.navbar-nav a[href="/products"]')?.classList.add('active');
                    } else if (currentPath.startsWith("/about") || currentPath.startsWith("/policy")) {
                        document.querySelector('.navbar-nav a[href="/about"]')?.classList.add('active');
                    } else if (currentPath === "/") {
                        document.querySelector('.navbar-nav a[href="/"]')?.classList.add('active');
                    }

                    // 2. Logic gọi AJAX lấy thông báo (Chỉ chạy khi User đã đăng nhập)
                    const isUserLoggedIn = "${not empty pageContext.request.remoteUser}" === "true";
                    if (isUserLoggedIn) {
                        fetchNotifications();
                        // Thiết lập chạy ngầm cập nhật sau mỗi 30 giây để bắt dữ liệu mới mà không cần F5
                        setInterval(fetchNotifications, 30000);
                    }

                    function fetchNotifications() {
                        fetch('/api/notifications')
                            .then(response => {
                                if (!response.ok) throw new Error('Unauthorized');
                                return response.json();
                            })
                            .then(data => {
                                updateNotificationUI(data.notifications, data.unreadCount);
                            })
                            .catch(err => console.log('Chưa đăng nhập hoặc lỗi hệ thống tải thông báo.'));
                    }

                    function updateNotificationUI(notifications, unreadCount) {
                        const badge = document.getElementById('notificationBadge');
                        const list = document.getElementById('notificationList');

                        // Hiển thị badge số lượng chưa đọc
                        if (unreadCount > 0) {
                            badge.innerText = unreadCount;
                            badge.classList.remove('d-none');
                        } else {
                            badge.classList.add('d-none');
                        }

                        // Hiển thị danh sách thông báo
                        if (notifications.length === 0) {
                            list.innerHTML = '<li><span class="dropdown-item text-center text-muted">Không có thông báo nào</span></li>';
                            return;
                        }

                        list.innerHTML = '';
                        notifications.forEach(notif => {
                            const isReadClass = notif.read ? 'text-muted' : 'fw-bold bg-light';
                            const dot = notif.read ? '' : '<span class="text-danger ms-2">●</span>';

                            const li = document.createElement('li');
                            li.innerHTML = `
                    <a href="#" class="dropdown-item border-bottom py-2 \${isReadClass}" style="white-space: normal;" onclick="handleNotificationClick(event, \${notif.id}, \${notif.orderId})">
                        <div class="d-flex justify-content-between align-items-center mb-1">
                            <span class="text-primary" style="font-size: 0.95rem;">\${notif.title} \${dot}</span>
                        </div>
                        <div style="font-size: 0.85rem; color: #444; line-height: 1.4;">\${notif.content}</div>
                        <div class="text-muted mt-1" style="font-size: 0.75rem;">
                            <i class="far fa-clock me-1"></i> \${notif.createdAt}
                        </div>
                    </a>
                `;
                            list.appendChild(li);
                        });
                    }

                    // Đánh dấu thông báo là đã đọc bằng POST và chuyển hướng trang chi tiết
                    window.handleNotificationClick = function (event, notifId, orderId) {
                        event.preventDefault();
                        let csrfToken = document.querySelector('input[name="_csrf"]');
                        let headers = { 'Content-Type': 'application/json' };
                        if (csrfToken) {
                            headers['X-CSRF-TOKEN'] = csrfToken.value;
                        }

                        fetch('/api/notifications/read/' + notifId, {
                            method: 'POST',
                            headers: headers
                        }).then(() => {
                            window.location.href = '/order-history/' + orderId;
                        }).catch(err => {
                            window.location.href = '/order-history/' + orderId;
                        });
                    };
                });
            </script>