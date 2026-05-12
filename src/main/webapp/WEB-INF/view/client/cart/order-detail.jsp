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
                <style>
                    .timeline-section {
                        border-left: 2px solid #e9ecef;
                        padding-left: 20px;
                        position: relative;
                    }

                    .timeline-item {
                        position: relative;
                        padding-bottom: 1.5rem;
                    }

                    .timeline-item::before {
                        content: "";
                        position: absolute;
                        left: -29px;
                        top: 5px;
                        width: 16px;
                        height: 16px;
                        border-radius: 50%;
                        background: #fff;
                        border: 3px solid #dee2e6;
                        z-index: 1;
                    }

                    .timeline-item.active::before {
                        background: #ff025b;
                        border-color: #ff025b;
                    }

                    .timeline-item .alert {
                        padding: 12px 15px;
                        margin-bottom: 0;
                        border: none;
                        background-color: #f8f9fa;
                        border-radius: 12px;
                    }

                    .product-img {
                        width: 60px;
                        height: 60px;
                        object-fit: cover;
                        border-radius: 8px;
                    }
                </style>
            </head>

            <body>
                <jsp:include page="../layout/header.jsp" />

                <div class="container-fluid py-5 mt-5 bg-light" style="min-height: 80vh;">
                    <div class="container py-5">
                        <div class="row">
                            <div class="col-12 mb-4">
                                <c:if test="${not empty success}">
                                    <div class="alert alert-success border-0 shadow-sm">
                                        <i class="fas fa-check-circle me-2"></i>${success}
                                    </div>
                                </c:if>
                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger border-0 shadow-sm">
                                        <i class="fas fa-exclamation-circle me-2"></i>${error}
                                    </div>
                                </c:if>
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="/">Trang chủ</a></li>
                                        <li class="breadcrumb-item"><a href="/order-history">Đơn hàng</a></li>
                                        <li class="breadcrumb-item active">Chi tiết #${order.id}</li>
                                    </ol>
                                </nav>
                            </div>

                            <div class="col-lg-5 mb-4">
                                <div class="card shadow-sm border-0 rounded-4 p-4 h-100">
                                    <h4 class="fw-bold mb-4 border-bottom pb-2">Thông tin giao hàng</h4>
                                    <c:set var="isPending" value="${order.status == 'PENDING'}" />

                                    <form action="/order-history/update" method="POST">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                        <input type="hidden" name="orderId" value="${order.id}" />

                                        <div class="mb-3">
                                            <label class="fw-bold text-muted small text-uppercase">Người nhận</label>
                                            <input type="text" name="receiverName"
                                                class="form-control rounded-pill px-3 mt-1"
                                                value="${order.receiverName}" ${!isPending ? 'readonly' : 'required' }>
                                        </div>
                                        <div class="mb-3">
                                            <label class="fw-bold text-muted small text-uppercase">Số điện thoại</label>
                                            <input type="text" name="receiverPhone"
                                                class="form-control rounded-pill px-3 mt-1"
                                                value="${order.receiverPhone}" ${!isPending ? 'readonly' : 'required' }>
                                        </div>
                                        <div class="mb-4">
                                            <label class="fw-bold text-muted small text-uppercase">Địa chỉ</label>
                                            <textarea name="receiverAddress" class="form-control rounded-4 px-3 mt-1"
                                                rows="3" ${!isPending ? 'readonly' : 'required'
                                                }>${order.receiverAddress}</textarea>
                                        </div>

                                        <c:if test="${isPending}">
                                            <button type="submit"
                                                class="btn btn-primary w-100 rounded-pill mb-3 shadow-sm">
                                                <i class="fas fa-save me-2"></i>Cập nhật thông tin
                                            </button>
                                            <button type="button" class="btn btn-outline-danger w-100 rounded-pill"
                                                onclick="if(confirm('Bạn có chắc chắn muốn hủy đơn hàng này?')) document.getElementById('cancelForm').submit();">
                                                <i class="fas fa-times-circle me-2"></i>Hủy đơn hàng
                                            </button>
                                        </c:if>
                                    </form>

                                    <form id="cancelForm" action="/order-history/cancel" method="POST"
                                        style="display: none;">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                        <input type="hidden" name="orderId" value="${order.id}" />
                                    </form>
                                </div>
                            </div>

                            <div class="col-lg-7">

                                <div class="card shadow-sm border-0 rounded-4 p-4 mb-4">
                                    <div class="d-flex justify-content-between align-items-center mb-4">
                                        <h4 class="fw-bold mb-0">Lịch trình đơn hàng</h4>
                                        <span class="badge bg-dark rounded-pill px-3 py-2 text-uppercase"
                                            style="font-size: 0.75rem;">
                                            Trạng thái: ${order.status}
                                        </span>
                                    </div>

                                    <div class="timeline-section ms-2">
                                        <div class="timeline-item active">
                                            <div class="alert alert-light border-0 shadow-sm">
                                                <div class="fw-bold text-dark">Đặt hàng thành công</div>
                                                <small class="text-muted">
                                                    <i class="far fa-calendar-alt me-1"></i> Ngày đặt:
                                                    ${order.formattedOrderDate}
                                                </small>
                                            </div>
                                        </div>

                                        <c:if test="${not empty order.formattedShippingDate}">
                                            <div class="timeline-item active">
                                                <div class="alert alert-light border-0 shadow-sm">
                                                    <div class="fw-bold text-info">Đơn hàng đang được giao</div>
                                                    <small class="text-muted">Ngày giao:
                                                        ${order.formattedShippingDate}</small><br />
                                                    <c:if test="${not empty order.formattedExpectedDeliveryDate}">
                                                        <small class="text-primary fw-bold">Dự kiến nhận:
                                                            ${order.formattedExpectedDeliveryDate}</small>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </c:if>

                                        <c:if test="${not empty order.formattedDeliveredDate}">
                                            <div class="timeline-item active">
                                                <div class="alert alert-light border-0 shadow-sm">
                                                    <div class="fw-bold text-success">Giao hàng thành công</div>
                                                    <small class="text-muted">Ngày nhận:
                                                        ${order.formattedDeliveredDate}</small>
                                                </div>
                                            </div>
                                        </c:if>

                                        <c:if test="${order.status == 'CANCELLED'}">
                                            <div class="timeline-item active">
                                                <div class="alert alert-danger border-0 shadow-sm">
                                                    <div class="fw-bold text-danger">Đơn hàng đã bị hủy</div>
                                                    <c:if test="${not empty order.formattedCancelledDate}">
                                                        <small class="text-danger">Ngày hủy:
                                                            ${order.formattedCancelledDate}</small>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>

                                <div class="card shadow-sm border-0 rounded-4 p-4">
                                    <h4 class="fw-bold mb-4 border-bottom pb-2">Sản phẩm đã mua</h4>
                                    <div class="table-responsive">
                                        <table class="table table-borderless align-middle">
                                            <thead>
                                                <tr class="text-muted small text-uppercase">
                                                    <th>Sản phẩm</th>
                                                    <th class="text-center">Số lượng</th>
                                                    <th class="text-end">Thành tiền</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="detail" items="${order.orderDetails}">
                                                    <tr>
                                                        <td>
                                                            <div class="d-flex align-items-center">
                                                                <img src="/images/product/${detail.product.image}"
                                                                    class="product-img me-3 border shadow-sm">
                                                                <div>
                                                                    <div class="fw-bold text-dark">
                                                                        ${detail.product.name}</div>
                                                                    <small class="text-muted">
                                                                        <fmt:formatNumber value="${detail.price}"
                                                                            type="number" /> đ
                                                                    </small>
                                                                </div>
                                                            </div>
                                                        </td>
                                                        <td class="text-center fw-bold">x${detail.quantity}</td>
                                                        <td class="text-danger fw-bold text-end">
                                                            <fmt:formatNumber value="${detail.price * detail.quantity}"
                                                                type="number" /> đ
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>

                                    <div class="d-flex justify-content-between align-items-center mt-4 border-top pt-3">
                                        <span class="fw-bold text-muted text-uppercase">Tổng thanh toán:</span>
                                        <h3 class="text-danger fw-bold mb-0">
                                            <fmt:formatNumber value="${order.totalPrice}" type="number" /> VNĐ
                                        </h3>
                                    </div>

                                    <div class="text-end mt-4">
                                        <a href="/order-history"
                                            class="btn btn-outline-danger rounded-pill px-4 shadow-sm">
                                            <i class="fas fa-arrow-left me-2"></i>Quay lại danh sách
                                        </a>
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