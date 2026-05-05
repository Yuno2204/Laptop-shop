<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Lịch sử mua hàng - Mobile Shop</title>

                <link rel="preconnect" href="https://fonts.googleapis.com">
                <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                <link
                    href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
                    rel="stylesheet">
                <link href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" rel="stylesheet">
                <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
                    rel="stylesheet">
                <link href="/client/css/bootstrap.min.css" rel="stylesheet">

                <!-- Template Stylesheet -->
                <link href="/client/css/style.css" rel="stylesheet">

                <style>
                    .order-history-section {
                        margin-top: 150px;
                        margin-bottom: 100px;
                        min-height: 60vh;
                    }

                    .table-main {
                        border-radius: 15px;
                        overflow: hidden;
                        box-shadow: 0 0 20px rgba(0, 0, 0, 0.05);
                    }

                    .table-main thead {
                        background-color: #ff025b;
                        color: white;
                    }

                    .status-badge {
                        padding: 5px 12px;
                        border-radius: 50px;
                        font-size: 0.85rem;
                        font-weight: 600;
                    }
                </style>
            </head>

            <body>
                <jsp:include page="../layout/header.jsp" />

                <div class="container order-history-section">
                    <div class="row">
                        <div class="col-12">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="/">Trang chủ</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Lịch sử đơn hàng</li>
                                </ol>
                            </nav>
                            <h2 class="mb-4 fw-bold">Đơn hàng của bạn</h2>

                            <c:if test="${empty orders}">
                                <div class="alert alert-info p-4 text-center">
                                    <i class="fas fa-shopping-basket fa-3x mb-3 text-secondary"></i>
                                    <p class="lead">Bạn chưa có đơn hàng nào.</p>
                                    <a href="/" class="btn btn-primary text-white px-4 py-2 mt-2"
                                        style="border-radius: 50px;">Mua sắm ngay</a>
                                </div>
                            </c:if>

                            <c:if test="${not empty orders}">
                                <div class="table-responsive table-main">
                                    <table class="table table-hover align-middle mb-0">
                                        <thead>
                                            <tr class="text-center">
                                                <th scope="col">Mã đơn</th>
                                                <th scope="col">Người nhận</th>
                                                <th scope="col">Tổng tiền</th>
                                                <th scope="col">Trạng thái</th>
                                                <th scope="col">Thao tác</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="order" items="${orders}">
                                                <tr class="text-center">
                                                    <td class="fw-bold">#${order.id}</td>
                                                    <td>${order.receiverName}</td>
                                                    <td class="text-danger fw-bold">
                                                        <fmt:formatNumber type="number" value="${order.totalPrice}" /> đ
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${order.status == 'PENDING'}">
                                                                <span class="status-badge bg-secondary text-white">Chờ
                                                                    xử lý</span>
                                                            </c:when>
                                                            <c:when test="${order.status == 'SHIPPING'}">
                                                                <span class="status-badge bg-info text-white">Đang
                                                                    giao</span>
                                                            </c:when>
                                                            <c:when test="${order.status == 'DELIVERED'}">
                                                                <span class="status-badge bg-success text-white">Đã
                                                                    giao</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span
                                                                    class="status-badge bg-danger text-white">${order.status}</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <a href="/order-detail/${order.id}"
                                                            class="btn btn-outline-primary btn-sm px-3"
                                                            style="border-radius: 20px;">
                                                            <i class="fas fa-eye me-1"></i>Chi tiết
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>

                <jsp:include page="../layout/footer.jsp" />

                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
                <script src="/client/js/main.js"></script>
            </body>

            </html>