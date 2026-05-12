<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Lịch sử đơn hàng - Mobile Shop</title>
                <link href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" rel="stylesheet">
                <link href="/client/css/bootstrap.min.css" rel="stylesheet">
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
                        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
                    }

                    .table-main thead {
                        background-color: #ff025b;
                        color: white;
                        border: none;
                    }

                    .status-badge {
                        padding: 6px 15px;
                        border-radius: 50px;
                        font-size: 0.8rem;
                        font-weight: 600;
                        display: inline-block;
                    }

                    .btn-view-detail {
                        border-radius: 50px;
                        padding: 5px 20px;
                        font-weight: 600;
                        transition: all 0.3s;
                    }

                    .btn-view-detail:hover {
                        background-color: #ff025b;
                        color: white;
                        border-color: #ff025b;
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
                                    <li class="breadcrumb-item active" aria-current="page">Đơn hàng của tôi</li>
                                </ol>
                            </nav>
                            <h2 class="mb-4 fw-bold">Lịch sử mua hàng</h2>

                            <c:if test="${empty orders}">
                                <div class="card border-0 shadow-sm p-5 text-center rounded-4">
                                    <i class="fas fa-shopping-bag fa-4x mb-4 text-light"></i>
                                    <p class="lead text-muted">Bạn chưa có đơn đặt hàng nào trong lịch sử.</p>
                                    <div class="mt-3">
                                        <a href="/" class="btn btn-primary btn-lg rounded-pill px-5 shadow">Mua sắm
                                            ngay</a>
                                    </div>
                                </div>
                            </c:if>

                            <c:if test="${not empty orders}">
                                <div class="table-responsive table-main bg-white">
                                    <table class="table table-hover align-middle mb-0">
                                        <thead>
                                            <tr class="text-center">
                                                <th class="py-3">Mã đơn</th>
                                                <th class="py-3 text-start">Thông tin & Ngày đặt</th>
                                                <th class="py-3">Tổng cộng</th>
                                                <th class="py-3">Trạng thái</th>
                                                <th class="py-3">Thao tác</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="order" items="${orders}">
                                                <tr class="text-center">
                                                    <td class="fw-bold text-dark">#${order.id}</td>
                                                    <td class="text-start">
                                                        <div class="fw-bold">${order.receiverName}</div>
                                                        <small class="text-muted"><i
                                                                class="far fa-calendar-alt me-1"></i>${order.formattedOrderDate}</small>
                                                    </td>
                                                    <td class="text-danger fw-bold">
                                                        <fmt:formatNumber type="number" value="${order.totalPrice}" /> đ
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${order.status == 'PENDING'}">
                                                                <span class="status-badge bg-secondary text-white">Chờ
                                                                    xác nhận</span>
                                                            </c:when>
                                                            <c:when test="${order.status == 'SHIPPING'}">
                                                                <span class="status-badge bg-info text-white">Đang
                                                                    giao</span>
                                                            </c:when>
                                                            <c:when
                                                                test="${order.status == 'DELIVERED' || order.status == 'SUCCESS'}">
                                                                <span class="status-badge bg-success text-white">Hoàn
                                                                    thành</span>
                                                            </c:when>
                                                            <c:when test="${order.status == 'CANCELLED'}">
                                                                <span class="status-badge bg-danger text-white">Đã
                                                                    hủy</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span
                                                                    class="status-badge bg-primary text-white">${order.status}</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <a href="/order-history/${order.id}"
                                                            class="btn btn-outline-info btn-sm btn-view-detail shadow-sm">
                                                            <i class="fas fa-eye me-1"></i> Chi tiết
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
            </body>

            </html>