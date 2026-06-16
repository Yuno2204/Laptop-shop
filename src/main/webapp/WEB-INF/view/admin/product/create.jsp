<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="utf-8" />
                    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                    <meta name="description" content="Đinh Quang Đức - Dự án Mobileshop" />
                    <meta name="author" content="Đinh Quang Đức" />
                    <title>Thêm mới sản phẩm</title>
                    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css"
                        rel="stylesheet" />
                    <link href="/css/styles.css" rel="stylesheet" />
                    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
                    <script>
                        $(document).ready(() => {
                            const avatarFile = $("#avatarFile");
                            avatarFile.change(function (e) {
                                const imgURL = URL.createObjectURL(e.target.files[0]);
                                $("#avatarPreview").attr("src", imgURL);
                                $("#avatarPreview").css({ "display": "block" });
                            });
                        }); 
                    </script>
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
                                    <h1 class="mt-4">Quản lý Sản Phẩm</h1>
                                    <ol class="breadcrumb mb-4">
                                        <li class="breadcrumb-item active"><a href="/admin">Dashboard</a></li>
                                    </ol>
                                    <div class="container mt-5">
                                        <div class="row">
                                            <div class="col-md-6 clo-12 mx-auto">
                                                <h4>Thêm mới sản phẩm</h4>
                                                <hr />
                                                <form:form method="post" action="/admin/product/create"
                                                    modelAttribute="newProduct" class="row"
                                                    enctype="multipart/form-data">
                                                    <div class="mb-3 col-12 col-md-6">
                                                        <label for="name" class="form-label">Tên sản phẩm:</label>

                                                        <spring:bind path="newProduct.name">
                                                            <form:input path="name" id="name" type="text"
                                                                class="form-control ${status.error ? 'is-invalid' : ''}" />

                                                            <c:if test="${status.error}">
                                                                <div class="invalid-feedback d-block">
                                                                    ${status.errorMessages[0]}
                                                                </div>
                                                            </c:if>
                                                        </spring:bind>
                                                    </div>

                                                    <div class="mb-3 col-12 col-md-6">
                                                        <label for="price" class="form-label">Giá sản phẩm:</label>

                                                        <spring:bind path="newProduct.price">
                                                            <form:input path="price" id="price" type="number"
                                                                class="form-control ${status.error ? 'is-invalid' : ''}" />

                                                            <c:if test="${status.error}">
                                                                <div class="invalid-feedback d-block">
                                                                    ${status.errorMessages[0]}
                                                                </div>
                                                            </c:if>
                                                        </spring:bind>
                                                    </div>

                                                    <div class="mb-3 col-12">
                                                        <label for="detailDesc" class="form-label">Mô tả chi
                                                            tiết:</label>
                                                        <spring:bind path="newProduct.detailDesc">
                                                            <form:textarea path="detailDesc" id="detailDesc" rows="10"
                                                                class="form-control ${status.error ? 'is-invalid' : ''}" />
                                                            <c:if test="${status.error}">
                                                                <div class="invalid-feedback d-block">
                                                                    ${status.errorMessages[0]}
                                                                </div>
                                                            </c:if>
                                                        </spring:bind>
                                                    </div>
                                                    <div class="row">
                                                        <div class="mb-3 col-12 col-md-6">
                                                            <label for="shortDesc" class="form-label">Mô tả
                                                                ngắn:</label>

                                                            <spring:bind path="newProduct.shortDesc">
                                                                <form:input path="shortDesc" id="shortDesc" type="text"
                                                                    class="form-control ${status.error ? 'is-invalid' : ''}" />

                                                                <c:if test="${status.error}">
                                                                    <div class="invalid-feedback d-block">
                                                                        ${status.errorMessages[0]}
                                                                    </div>
                                                                </c:if>
                                                            </spring:bind>
                                                        </div>

                                                        <div class="mb-3 col-12 col-md-6">
                                                            <label for="quantity" class="form-label">Số lượng:</label>

                                                            <spring:bind path="newProduct.quantity">
                                                                <form:input path="quantity" id="quantity" type="number"
                                                                    class="form-control ${status.error ? 'is-invalid' : ''}" />

                                                                <c:if test="${status.error}">
                                                                    <div class="invalid-feedback d-block">
                                                                        ${status.errorMessages[0]}
                                                                    </div>
                                                                </c:if>
                                                            </spring:bind>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="mb-3 col-12 col-md-6">
                                                            <label for="cpu" class="form-label">Chip xử lý:</label>
                                                            <spring:bind path="newProduct.cpu">
                                                                <form:input path="cpu" id="cpu" type="text"
                                                                    placeholder="Apple A18 Pro"
                                                                    class="form-control ${status.error ? 'is-invalid' : ''}" />
                                                                <c:if test="${status.error}">
                                                                    <div class="invalid-feedback d-block">
                                                                        ${status.errorMessages[0]}
                                                                    </div>
                                                                </c:if>
                                                            </spring:bind>
                                                        </div>

                                                        <div class="mb-3 col-12 col-md-6">
                                                            <label for="screenSize" class="form-label">Kích thước màn
                                                                hình:</label>
                                                            <spring:bind path="newProduct.screenSize">
                                                                <form:input path="screenSize" id="screenSize"
                                                                    type="text" placeholder="6.7 inch"
                                                                    class="form-control ${status.error ? 'is-invalid' : ''}" />
                                                                <c:if test="${status.error}">
                                                                    <div class="invalid-feedback d-block">
                                                                        ${status.errorMessages[0]}
                                                                    </div>
                                                                </c:if>
                                                            </spring:bind>
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="mb-3 col-12 col-md-6">
                                                            <label for="battery" class="form-label">Dung lượng
                                                                Pin:</label>
                                                            <spring:bind path="newProduct.battery">
                                                                <form:input path="battery" id="battery" type="text"
                                                                    placeholder="5000 mAh"
                                                                    class="form-control ${status.error ? 'is-invalid' : ''}" />
                                                                <c:if test="${status.error}">
                                                                    <div class="invalid-feedback d-block">
                                                                        ${status.errorMessages[0]}
                                                                    </div>
                                                                </c:if>
                                                            </spring:bind>
                                                        </div>

                                                        <div class="mb-3 col-12 col-md-6">
                                                            <label for="fastCharge" class="form-label">Sạc nhanh
                                                                (W):</label>
                                                            <spring:bind path="newProduct.fastCharge">
                                                                <form:input path="fastCharge" id="fastCharge"
                                                                    type="text" placeholder="25W"
                                                                    class="form-control ${status.error ? 'is-invalid' : ''}" />
                                                                <c:if test="${status.error}">
                                                                    <div class="invalid-feedback d-block">
                                                                        ${status.errorMessages[0]}
                                                                    </div>
                                                                </c:if>
                                                            </spring:bind>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-4 mb-3">
                                                            <label class="form-label">Hệ điều hành:</label>
                                                            <form:select class="form-select" path="os">
                                                                <form:option value="iOS">iOS</form:option>
                                                                <form:option value="Android">Android</form:option>
                                                            </form:select>
                                                        </div>
                                                        <div class="col-md-4 mb-3">
                                                            <label class="form-label">Thương hiệu:</label>
                                                            <form:select class="form-select" path="factory">
                                                                <form:option value="Apple">Apple</form:option>
                                                                <form:option value="Samsung">Samsung</form:option>
                                                                <form:option value="Xiaomi">Xiaomi</form:option>
                                                            </form:select>
                                                        </div>
                                                        <div class="col-md-4 mb-3">
                                                            <label class="form-label">Dung lượng ROM:</label>
                                                            <form:select class="form-select" path="rom">
                                                                <form:option value="≤128 GB">≤128 GB</form:option>
                                                                <form:option value="256 GB">256 GB</form:option>
                                                                <form:option value="512 GB">512 GB</form:option>
                                                                <form:option value="1 TB">1 TB</form:option>
                                                            </form:select>
                                                        </div>

                                                        <div class="col-md-4 mb-3">
                                                            <label class="form-label">RAM:</label>
                                                            <form:select class="form-select" path="ram">
                                                                <form:option value="4 GB">4 GB</form:option>
                                                                <form:option value="6 GB">6 GB</form:option>
                                                                <form:option value="8 GB">8 GB</form:option>
                                                                <form:option value="12 GB">12 GB</form:option>
                                                            </form:select>
                                                        </div>

                                                        <div class="col-md-4 mb-3">
                                                            <label class="form-label">Tần số quét:</label>
                                                            <form:select class="form-select" path="refreshRate">
                                                                <form:option value="60 Hz">60 Hz</form:option>
                                                                <form:option value="90 Hz">90 Hz</form:option>
                                                                <form:option value="120 Hz">120 Hz</form:option>
                                                                <form:option value="Trên 144 Hz">Trên 144 Hz
                                                                </form:option>
                                                            </form:select>
                                                        </div>
                                                        <div class="col-md-4 mb-3">
                                                            <label class="form-label">Nhu cầu:</label>
                                                            <form:select class="form-select" path="target">
                                                                <form:option value="Chơi game">Chơi game</form:option>
                                                                <form:option value="Cấu hình cao">Cấu hình cao
                                                                </form:option>
                                                                <form:option value="Pin trâu">Pin trâu</form:option>
                                                                <form:option value="Chụp ảnh đẹp">Chụp ảnh đẹp
                                                                </form:option>
                                                                <form:option value="Mỏng nhẹ">Mỏng nhẹ</form:option>
                                                                <form:option value="Nhỏ gọn, dễ cầm nắm">Nhỏ gọn, dễ cầm
                                                                    nắm
                                                                </form:option>
                                                                <form:option value="Livestream">Livestream</form:option>
                                                            </form:select>
                                                        </div>
                                                    </div>

                                                    <div class="mb-3 col-12 col-md-6">
                                                        <label for="avatarFile" class="form-label">Ảnh:</label>
                                                        <input class="form-control" type="file" id="avatarFile"
                                                            accept=".png, .jpg, .jpeg" name="imagesFile" />
                                                        <form:errors path="image" cssClass="text-danger" />
                                                    </div>
                                                    <div class="col-12 mb-3">
                                                        <img style="max-height: 250px; display: none;"
                                                            alt="avatar preview" id="avatarPreview" />
                                                    </div>
                                                    <div class="d-flex justify-content-between">
                                                        <button type="submit" class="btn btn-primary">Thêm mới</button>
                                                        <a href="/admin/product" class="btn btn-success">Quay lại</a>
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
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                        crossorigin="anonymous"></script>
                    <script src="/js/scripts.js"></script>
                </body>

                </html>