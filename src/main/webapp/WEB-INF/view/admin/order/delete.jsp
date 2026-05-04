<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <title>Xóa đơn hàng với id = ${id}</title>
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
                                <div class="container mt-5">
                                    <div class="row">
                                        <div class="col-md-6 col-12 mx-auto">
                                            <div class="card mb-4">
                                                <div class="card-header text-danger">
                                                    <i class="fas fa-exclamation-triangle me-1"></i> Xác nhận xóa
                                                </div>
                                                <div class="card-body">
                                                    <div class="alert alert-danger" role="alert">
                                                        Bạn có chắc chắn muốn xóa đơn hàng có ID =
                                                        <strong>${id}</strong> không? <br />
                                                        Việc này sẽ xóa luôn tất cả các chi tiết (sản phẩm) của đơn hàng
                                                        và không thể hoàn tác!
                                                    </div>
                                                    <form:form method="post" action="/admin/order/delete"
                                                        modelAttribute="newOrder">
                                                        <div class="mb-3" style="display: none">
                                                            <form:input value="${id}" type="text" class="form-control"
                                                                path="id" />
                                                        </div>
                                                        <div class="d-flex justify-content-between">
                                                            <button class="btn btn-danger">Xác Nhận Xóa</button>
                                                            <a href="/admin/order" class="btn btn-success">Quay lại</a>
                                                        </div>
                                                    </form:form>
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