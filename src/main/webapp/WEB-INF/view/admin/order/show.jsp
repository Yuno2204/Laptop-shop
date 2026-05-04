<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="utf-8" />
                    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                    <meta name="description" content="Đinh Quang Đức - Dự án Mobileshop" />
                    <meta name="author" content="Đinh Quang Đức" />
                    <title>Danh sách đơn hàng</title>
                    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css"
                        rel="stylesheet" />
                    <link href="/css/styles.css" rel="stylesheet" />
                    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
                        crossorigin="anonymous"></script>
                </head>

                <body class="sb-nav-fixed">
                    <jsp:include page="../layout/header.jsp"></jsp:include>
                    <div id="layoutSidenav">
                        <jsp:include page="../layout/sidebar.jsp"></jsp:include>
                        <div id="layoutSidenav_content">
                            <main>
                                <div class="container-fluid px-4">
                                    <h1 class="mt-4">Quản Lý Đơn hàng</h1>
                                    <ol class="breadcrumb mb-4">
                                        <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                                        <li class="breadcrumb-item active">Order</li>
                                    </ol>

                                    <div class="card mb-4">
                                        <div class="card-header d-flex justify-content-between">
                                            <div>
                                                <i class="fas fa-table me-1"></i>
                                                Danh sách đơn hàng
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <table id="datatablesSimple" class="table table-bordered table-striped">
                                                <thead>
                                                    <tr>
                                                        <th>ID</th>
                                                        <th>Người nhận</th>
                                                        <th>Số điện thoại</th>
                                                        <th>Tổng tiền</th>
                                                        <th>Trạng thái</th>
                                                        <th>Hành động</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="order" items="${orders}">
                                                        <tr>
                                                            <td>${order.id}</td>
                                                            <td>${order.receiverName}</td>
                                                            <td>${order.receiverPhone}</td>
                                                            <td>
                                                                <fmt:formatNumber type="number"
                                                                    value="${order.totalPrice}" /> đ
                                                            </td>
                                                            <td>
                                                                <span
                                                                    class="badge bg-${order.status == 'PENDING' ? 'secondary' : (order.status == 'SHIPPING' ? 'info' : 'success')}">
                                                                    ${order.status}
                                                                </span>
                                                            </td>
                                                            <td>
                                                                <a href="/admin/order/${order.id}"
                                                                    class="btn btn-success">Chi tiết</a>
                                                                <a href="/admin/order/update/${order.id}"
                                                                    class="btn btn-warning mx-2">Cập nhật</a>
                                                                <a href="/admin/order/delete/${order.id}"
                                                                    class="btn btn-danger">Xóa</a>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
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