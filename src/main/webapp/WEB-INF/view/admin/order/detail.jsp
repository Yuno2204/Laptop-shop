<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                <title>Chi tiết đơn hàng #${order.id} - Admin</title>
                <link href="/css/styles.css" rel="stylesheet" />
                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
            </head>

            <body class="sb-nav-fixed">
                <jsp:include page="../layout/header.jsp"></jsp:include>
                <div id="layoutSidenav">
                    <jsp:include page="../layout/sidebar.jsp"></jsp:include>
                    <div id="layoutSidenav_content">
                        <main>
                            <div class="container-fluid px-4">
                                <h1 class="mt-4">Quản lý Đơn hàng</h1>
                                <ol class="breadcrumb mb-4">
                                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                                    <li class="breadcrumb-item"><a href="/admin/order">Order</a></li>
                                    <li class="breadcrumb-item active">Chi tiết #${order.id}</li>
                                </ol>

                                <div class="card mb-4 shadow-sm border-0">
                                    <div class="card-header bg-white py-3">
                                        <h5 class="mb-0 fw-bold"><i class="fas fa-file-invoice me-2"></i>Thông tin chi
                                            tiết đơn hàng #${order.id}</h5>
                                    </div>
                                    <div class="card-body">
                                        <div class="row mb-4">
                                            <div class="col-md-12">
                                                <h6 class="text-uppercase fw-bold text-muted mb-3 small">Thông tin giao
                                                    hàng</h6>
                                                <ul class="list-group list-group-flush mb-4">
                                                    <li class="list-group-item px-0"><strong>Người nhận:</strong>
                                                        ${order.receiverName}</li>
                                                    <li class="list-group-item px-0"><strong>Số điện thoại:</strong>
                                                        ${order.receiverPhone}</li>
                                                    <li class="list-group-item px-0"><strong>Địa chỉ:</strong>
                                                        ${order.receiverAddress}</li>
                                                    <li class="list-group-item px-0 border-0">
                                                        <strong>Trạng thái: </strong>
                                                        <span
                                                            class="badge ${order.status == 'PENDING' ? 'bg-secondary' : 
                                                               (order.status == 'SHIPPING' ? 'bg-info' : 
                                                               (order.status == 'DELIVERED' || order.status == 'SUCCESS' ? 'bg-success' : 'bg-danger'))}">
                                                            ${order.status}
                                                        </span>
                                                    </li>
                                                </ul>

                                                <div class="status-timeline">
                                                    <div class="alert alert-secondary py-2 border-0 shadow-sm mb-2">
                                                        <i class="fas fa-calendar-alt me-2"></i>
                                                        <strong>Ngày đặt hàng:</strong> ${order.formattedOrderDate}
                                                    </div>

                                                    <c:if test="${not empty order.formattedShippingDate}">
                                                        <div class="alert alert-info py-2 border-0 shadow-sm mb-2">
                                                            <i class="fas fa-truck me-2"></i>
                                                            <strong>Giao hàng:</strong> ${order.formattedShippingDate}
                                                            <br><small class="ms-4">Dự kiến nhận:
                                                                ${order.formattedExpectedDeliveryDate}</small>
                                                        </div>
                                                    </c:if>

                                                    <c:if test="${not empty order.formattedDeliveredDate}">
                                                        <div class="alert alert-success py-2 border-0 shadow-sm mb-2">
                                                            <i class="fas fa-check-circle me-2"></i>
                                                            <strong>Hoàn thành:</strong> ${order.formattedDeliveredDate}
                                                        </div>
                                                    </c:if>

                                                    <c:if
                                                        test="${order.status == 'CANCELLED' && not empty order.formattedCancelledDate}">
                                                        <div class="alert alert-danger py-2 border-0 shadow-sm mb-2">
                                                            <i class="fas fa-times-circle me-2"></i>
                                                            <strong>Ngày hủy:</strong> ${order.formattedCancelledDate}
                                                        </div>
                                                    </c:if>
                                                </div>
                                            </div>


                                        </div>

                                        <h6 class="fw-bold mb-3"><i class="fas fa-box me-2"></i>Danh sách sản phẩm</h6>
                                        <div class="table-responsive">
                                            <table class="table table-bordered align-middle">
                                                <thead class="table-light">
                                                    <tr>
                                                        <th>Sản phẩm</th>
                                                        <th class="text-center">Đơn giá</th>
                                                        <th class="text-center">Số lượng</th>
                                                        <th class="text-end">Thành tiền</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="detail" items="${orderDetails}">
                                                        <tr>
                                                            <td>
                                                                <div class="d-flex align-items-center">
                                                                    <img src="/images/product/${detail.product.image}"
                                                                        style="width: 50px; height: 50px; object-fit: cover;"
                                                                        class="rounded me-3 border">
                                                                    <span>${detail.product.name}</span>
                                                                </div>
                                                            </td>
                                                            <td class="text-center">
                                                                <fmt:formatNumber type="number"
                                                                    value="${detail.price}" /> đ
                                                            </td>
                                                            <td class="text-center">${detail.quantity}</td>
                                                            <td class="text-end fw-bold">
                                                                <fmt:formatNumber type="number"
                                                                    value="${detail.price * detail.quantity}" /> đ
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>

                                        <div class="mt-4">
                                            <a href="/admin/order" class="btn btn-outline-secondary px-4">
                                                <i class="fas fa-arrow-left me-2"></i>Quay lại danh sách
                                            </a>
                                            <a href="/admin/order/update/${order.id}" class="btn btn-warning px-4 ms-2">
                                                <i class="fas fa-edit me-2"></i>Cập nhật trạng thái
                                            </a>

                                            <c:if test="${order.status eq 'SHIPPING'}">
                                                <a href="/admin/order/invoice/${order.id}" target="_blank"
                                                    class="btn btn-success">
                                                    <i class="fas fa-print"></i> Xuất hóa đơn vận chuyển
                                                </a>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </main>
                        <jsp:include page="../layout/footer.jsp"></jsp:include>
                    </div>
                </div>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                    crossorigin="anonymous"></script>
            </body>

            </html>