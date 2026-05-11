<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                <meta name="description" content="Đinh Quang Đức - Dự án Mobileshop" />
                <meta name="author" content="Đinh Quang Đức" />
                <title>Thông tin chi tiết sản phẩm với id = ${id}</title>
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
                                <h1 class="mt-4">Quản lý Sản phẩm</h1>
                                <ol class="breadcrumb mb-4">
                                    <li class="breadcrumb-item active"><a href="/admin">Dashboard</a></li>
                                </ol>
                                <div class="container mt-5">
                                    <div class="row">
                                        <div class="clo-12 mx-auto">
                                            <div class="d-flex justify-content-between">
                                                <h3>Thông tin chi tiết sản phẩm với id = ${id}</h3>
                                            </div>
                                            <hr />
                                            <div class="card" style="width: 60%">
                                                <div class="card-header">Thông tin sản phẩm</div>

                                                <ul class="list-group list-group-flush">
                                                    <li class="list-group-item">ID: ${product.id}</li>
                                                    <li class="list-group-item">Tên sản phẩm: ${product.name}</li>
                                                    <li class="list-group-item">Giá: ${product.price}</li>
                                                    <li class="list-group-item">Số lượng: ${product.quantity}</li>
                                                    <li class="list-group-item">Thương hiệu: ${product.factory}</li>
                                                    <li class="list-group-item">Nhu cầu: ${product.target}</li>

                                                    <li class="list-group-item">Hệ điều hành: ${product.os}</li>
                                                    <li class="list-group-item">Chip xử lý: ${not empty product.cpu ?
                                                        product.cpu : 'Đang cập nhật'}</li>
                                                    <li class="list-group-item">RAM: ${product.ram}</li>
                                                    <li class="list-group-item">Dung lượng ROM: ${product.rom}</li>
                                                    <li class="list-group-item">Kích thước màn hình: ${not empty
                                                        product.screenSize ? product.screenSize : 'Đang cập nhật'}</li>
                                                    <li class="list-group-item">Tần số quét màn hình:
                                                        ${product.refreshRate}</li>
                                                    <li class="list-group-item">Dung lượng Pin: ${not empty
                                                        product.battery ? product.battery : 'Đang cập nhật'}</li>
                                                    <li class="list-group-item">Hỗ trợ sạc nhanh: ${not empty
                                                        product.fastCharge ? product.fastCharge : 'Đang cập nhật'}</li>

                                                    <li class="list-group-item">Mô tả ngắn: ${product.shortDesc}</li>
                                                    <li class="list-group-item">
                                                        Mô tả chi tiết:
                                                        <div
                                                            style="white-space: pre-line; color: #000; margin-top: 10px;">
                                                            ${product.detailDesc}
                                                        </div>
                                                    </li>
                                                    <li class="list-group-item">Đã bán: ${product.sold}</li>
                                                    <li class="list-group-item">
                                                        Ảnh:
                                                        <br />
                                                        <c:if test="${not empty product.image}">
                                                            <img src="/images/product/${product.image}"
                                                                alt="${product.name}"
                                                                style="max-width: 300px; max-height: 300px; margin-top: 10px;" />
                                                        </c:if>
                                                    </li>
                                                </ul>
                                            </div>
                                            <a href="/admin/product" class="btn btn-success mt-3">Quay lại</a>
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