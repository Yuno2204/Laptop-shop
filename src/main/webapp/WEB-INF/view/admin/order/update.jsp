<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <title>Cập nhật trạng thái đơn hàng</title>
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
                                <h1 class="mt-4">Quản lý đơn hàng</h1>
                                <div class="container mt-5">
                                    <div class="row">
                                        <div class="col-md-6 col-12 mx-auto">
                                            <h4>Cập nhật trạng thái đơn hàng #${newOrder.id}</h4>
                                            <hr />
                                            <form:form method="post" action="/admin/order/update"
                                                modelAttribute="newOrder">
                                                <div class="mb-3" style="display: none;">
                                                    <form:input path="id" />
                                                </div>

                                                <div class="mb-3">
                                                    <label class="form-label">Người nhận:</label>
                                                    <input type="text" class="form-control"
                                                        value="${newOrder.receiverName}" disabled />
                                                </div>

                                                <div class="mb-3">
                                                    <label class="form-label">Cập nhật trạng thái:</label>
                                                    <form:select class="form-select" path="status">
                                                        <form:option value="PENDING">PENDING</form:option>
                                                        <form:option value="SHIPPING">SHIPPING</form:option>
                                                        <form:option value="DELIVERED">DELIVERED</form:option>
                                                        <form:option value="CANCELLED">CANCELLED</form:option>
                                                    </form:select>
                                                </div>

                                                <div class="d-flex justify-content-between">
                                                    <button type="submit" class="btn btn-warning">Cập nhật</button>
                                                    <a href="/admin/order" class="btn btn-success">Quay lại</a>
                                                </div>
                                            </form:form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </main>
                        <jsp:include page="../layout/footer.jsp"></jsp:include>
                    </div>
                </div>
            </body>

            </html>