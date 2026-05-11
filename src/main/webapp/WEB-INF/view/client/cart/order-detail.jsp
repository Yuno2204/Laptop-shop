<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8" />
                <title>Chi tiết đơn hàng #${order.id}</title>
                <link href="/client/css/bootstrap.min.css" rel="stylesheet">
                <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
                <link href="/client/css/style.css" rel="stylesheet">
            </head>

            <body>
                <jsp:include page="../layout/header.jsp" />

                <div class="container-fluid py-5 mt-5 bg-light">
                    <div class="container py-5">
                        <div class="row">
                            <div class="col-12 mb-3">
                                <c:if test="${not empty success}">
                                    <div class="alert alert-success border-0 shadow-sm"><i
                                            class="fas fa-check-circle me-2"></i>${success}</div>
                                </c:if>
                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger border-0 shadow-sm"><i
                                            class="fas fa-exclamation-circle me-2"></i>${error}</div>
                                </c:if>
                            </div>

                            <div class="col-lg-5 mb-4">
                                <div class="card shadow border-0 rounded-4 p-4 h-100">
                                    <h4 class="fw-bold mb-4">Thông tin giao hàng</h4>

                                    <c:set var="isPending" value="${order.status == 'PENDING'}" />

                                    <form action="/order-history/update" method="POST">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                        <input type="hidden" name="orderId" value="${order.id}" />

                                        <div class="mb-3">
                                            <label class="fw-bold">Tên người nhận</label>
                                            <input type="text" name="receiverName" class="form-control"
                                                value="${order.receiverName}" ${!isPending ? 'readonly' : 'required' }>
                                        </div>
                                        <div class="mb-3">
                                            <label class="fw-bold">Số điện thoại</label>
                                            <input type="text" name="receiverPhone" class="form-control"
                                                value="${order.receiverPhone}" ${!isPending ? 'readonly' : 'required' }>
                                        </div>
                                        <div class="mb-3">
                                            <label class="fw-bold">Địa chỉ nhận hàng</label>
                                            <textarea name="receiverAddress" class="form-control" rows="3" ${!isPending
                                                ? 'readonly' : 'required' }>${order.receiverAddress}</textarea>
                                        </div>

                                        <c:if test="${isPending}">
                                            <div class="alert alert-info py-2"><small>Bạn có thể thay đổi thông tin khi
                                                    đơn hàng đang chờ xác nhận.</small></div>
                                            <button type="submit" class="btn btn-primary w-100 rounded-pill"><i
                                                    class="fas fa-save me-2"></i>Cập nhật thông tin</button>
                                        </c:if>
                                    </form>

                                    <c:if test="${isPending}">
                                        <form action="/order-history/cancel" method="POST" class="mt-3"
                                            onsubmit="return confirm('Bạn có chắc chắn muốn hủy đơn hàng này?');">
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                            <input type="hidden" name="orderId" value="${order.id}" />
                                            <button type="submit" class="btn btn-outline-danger w-100 rounded-pill"><i
                                                    class="fas fa-times-circle me-2"></i>Hủy đơn hàng</button>
                                        </form>
                                    </c:if>
                                </div>
                            </div>

                            <div class="col-lg-7">
                                <div class="card shadow border-0 rounded-4 p-4">
                                    <div class="d-flex justify-content-between align-items-center mb-4">
                                        <h4 class="fw-bold mb-0">Mã đơn: #${order.id}</h4>

                                        <c:choose>
                                            <c:when test="${order.status == 'PENDING'}"><span
                                                    class="badge bg-warning text-dark fs-6 px-3 py-2">Chờ xác
                                                    nhận</span></c:when>
                                            <c:when test="${order.status == 'SHIPPING'}"><span
                                                    class="badge bg-info text-dark fs-6 px-3 py-2">Đang giao hàng</span>
                                            </c:when>
                                            <c:when
                                                test="${order.status == 'DELIVERED' || order.status == 'COMPLETED'}">
                                                <span class="badge bg-success fs-6 px-3 py-2">Đã hoàn thành</span>
                                            </c:when>
                                            <c:when test="${order.status == 'CANCELLED'}"><span
                                                    class="badge bg-danger fs-6 px-3 py-2">Đã hủy</span></c:when>
                                        </c:choose>
                                    </div>

                                    <div class="table-responsive">
                                        <table class="table align-middle">
                                            <thead class="table-light">
                                                <tr>
                                                    <th>Sản phẩm</th>
                                                    <th>Đơn giá</th>
                                                    <th>SL</th>
                                                    <th>Thành tiền</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="detail" items="${order.orderDetails}">
                                                    <tr>
                                                        <td>
                                                            <div class="d-flex align-items-center">
                                                                <img src="/images/product/${detail.product.image}"
                                                                    alt="img"
                                                                    style="width: 50px; height: 50px; object-fit: cover;"
                                                                    class="rounded me-3">
                                                                <span class="fw-bold">${detail.product.name}</span>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <fmt:formatNumber value="${detail.price}" type="number" /> đ
                                                        </td>
                                                        <td>${detail.quantity}</td>
                                                        <td class="text-danger fw-bold">
                                                            <fmt:formatNumber value="${detail.price * detail.quantity}"
                                                                type="number" /> đ
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>

                                    <div class="d-flex justify-content-between mt-4 border-top pt-3">
                                        <h5 class="fw-bold">Tổng cộng:</h5>
                                        <h4 class="text-danger fw-bold">
                                            <fmt:formatNumber value="${order.totalPrice}" type="number" /> VNĐ
                                        </h4>
                                    </div>

                                    <div class="text-end mt-4">
                                        <a href="/order-history" class="btn btn-secondary rounded-pill px-4"><i
                                                class="fas fa-arrow-left me-2"></i>Quay lại lịch sử</a>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>

                <jsp:include page="../layout/footer.jsp" />
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>