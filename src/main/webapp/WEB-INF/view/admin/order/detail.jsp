<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                <title>Chi tiết đơn hàng #${id}</title>
                <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
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
                                <h1 class="mt-4">Chi tiết Đơn hàng</h1>
                                <div class="container mt-5">
                                    <div class="row">
                                        <div class="col-md-10 col-12 mx-auto">
                                            <div class="card mb-4">
                                                <div class="card-header">
                                                    <i class="fas fa-info-circle me-1"></i>
                                                    Thông tin đơn hàng #${id}
                                                </div>
                                                <div class="card-body">
                                                    <div class="row mb-4">
                                                        <div class="col-md-6">
                                                            <h5>Thông tin giao hàng</h5>
                                                            <ul class="list-group list-group-flush">
                                                                <li class="list-group-item"><strong>Người nhận:</strong>
                                                                    ${order.receiverName}</li>
                                                                <li class="list-group-item"><strong>Điện thoại:</strong>
                                                                    ${order.receiverPhone}</li>
                                                                <li class="list-group-item"><strong>Địa chỉ:</strong>
                                                                    ${order.receiverAddress}</li>
                                                                <li class="list-group-item"><strong>Trạng thái:</strong>
                                                                    ${order.status}</li>
                                                            </ul>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <h5>Tổng kết</h5>
                                                            <ul class="list-group list-group-flush">
                                                                <li class="list-group-item"><strong>Khách hàng
                                                                        đặt:</strong> ${order.user.fullName}</li>
                                                                <li class="list-group-item text-danger">
                                                                    <strong>Tổng thanh toán:</strong>
                                                                    <fmt:formatNumber type="number"
                                                                        value="${order.totalPrice}" /> đ
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </div>

                                                    <h5>Sản phẩm đã mua</h5>
                                                    <table class="table table-bordered">
                                                        <thead class="table-light">
                                                            <tr>
                                                                <th>Sản phẩm</th>
                                                                <th>Đơn giá</th>
                                                                <th>Số lượng</th>
                                                                <th>Thành tiền</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach var="detail" items="${orderDetails}">
                                                                <tr>
                                                                    <td>${detail.product.name}</td>
                                                                    <td>
                                                                        <fmt:formatNumber type="number"
                                                                            value="${detail.price}" /> đ
                                                                    </td>
                                                                    <td>${detail.quantity}</td>
                                                                    <td>
                                                                        <fmt:formatNumber type="number"
                                                                            value="${detail.price * detail.quantity}" />
                                                                        đ
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </tbody>
                                                    </table>

                                                    <a href="/admin/order" class="btn btn-success mt-3">Quay lại</a>
                                                </div>
                                            </div>
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
                <script src="/js/scripts.js"></script>
            </body>

            </html>