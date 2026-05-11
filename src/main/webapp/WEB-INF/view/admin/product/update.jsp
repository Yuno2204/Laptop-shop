<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <title>Cập nhật sản phẩm</title>
                <link href="/css/styles.css" rel="stylesheet" />
            </head>

            <body class="sb-nav-fixed">

                <jsp:include page="../layout/header.jsp"></jsp:include>

                <div id="layoutSidenav">
                    <jsp:include page="../layout/sidebar.jsp"></jsp:include>

                    <div id="layoutSidenav_content">
                        <main>
                            <div class="container-fluid px-4">
                                <h1 class="mt-4">Quản lý sản phẩm</h1>

                                <div class="container mt-5">
                                    <div class="row">
                                        <div class="col-md-6 col-12 mx-auto">

                                            <h4>Cập nhật sản phẩm</h4>
                                            <hr />

                                            <form:form method="post" action="/admin/product/update"
                                                modelAttribute="newProduct" class="row" enctype="multipart/form-data">

                                                <!-- ID (ẩn) -->
                                                <form:input path="id" type="hidden" />

                                                <!-- NAME -->
                                                <div class="mb-3 col-12 col-md-6">
                                                    <label class="form-label">Tên sản phẩm:</label>

                                                    <spring:bind path="newProduct.name">
                                                        <form:input path="name"
                                                            class="form-control ${status.error ? 'is-invalid' : ''}" />

                                                        <c:if test="${status.error}">
                                                            <div class="invalid-feedback d-block">
                                                                ${status.errorMessages[0]}
                                                            </div>
                                                        </c:if>
                                                    </spring:bind>
                                                </div>

                                                <!-- PRICE -->
                                                <div class="mb-3 col-12 col-md-6">
                                                    <label class="form-label">Giá:</label>

                                                    <spring:bind path="newProduct.price">
                                                        <form:input path="price" type="number" step="0.01"
                                                            class="form-control ${status.error ? 'is-invalid' : ''}" />

                                                        <c:if test="${status.error}">
                                                            <div class="invalid-feedback d-block">
                                                                ${status.errorMessages[0]}
                                                            </div>
                                                        </c:if>
                                                    </spring:bind>
                                                </div>

                                                <!-- QUANTITY -->
                                                <div class="mb-3 col-12 col-md-6">
                                                    <label class="form-label">Số lượng:</label>

                                                    <spring:bind path="newProduct.quantity">
                                                        <form:input path="quantity" type="number"
                                                            class="form-control ${status.error ? 'is-invalid' : ''}" />

                                                        <c:if test="${status.error}">
                                                            <div class="invalid-feedback d-block">
                                                                ${status.errorMessages[0]}
                                                            </div>
                                                        </c:if>
                                                    </spring:bind>
                                                </div>

                                                <!-- SHORT DESC -->
                                                <div class="mb-3 col-12 col-md-6">
                                                    <label class="form-label">Mô tả ngắn:</label>

                                                    <spring:bind path="newProduct.shortDesc">
                                                        <form:input path="shortDesc"
                                                            class="form-control ${status.error ? 'is-invalid' : ''}" />

                                                        <c:if test="${status.error}">
                                                            <div class="invalid-feedback d-block">
                                                                ${status.errorMessages[0]}
                                                            </div>
                                                        </c:if>
                                                    </spring:bind>
                                                </div>

                                                <!-- DETAIL DESC -->
                                                <div class="mb-3 col-12">
                                                    <label for="detailDesc" class="form-label">Mô tả chi tiết:</label>
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
                                                            <form:input path="screenSize" id="screenSize" type="text"
                                                                placeholder="6.7 inch"
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
                                                            <form:input path="fastCharge" id="fastCharge" type="text"
                                                                placeholder="25W"
                                                                class="form-control ${status.error ? 'is-invalid' : ''}" />
                                                            <c:if test="${status.error}">
                                                                <div class="invalid-feedback d-block">
                                                                    ${status.errorMessages[0]}
                                                                </div>
                                                            </c:if>
                                                        </spring:bind>
                                                    </div>
                                                </div>

                                                <!-- FACTORY -->
                                                <div class="row">
                                                    <div class="mb-3 col-12 col-md-6">
                                                        <label class="form-label">Hệ điều hành:</label>
                                                        <form:select class="form-select" path="os">
                                                            <form:option value="iOS">iOS</form:option>
                                                            <form:option value="Android">Android</form:option>
                                                        </form:select>
                                                    </div>
                                                    <div class="mb-3 col-12 col-md-6">
                                                        <label class="form-label">Thương hiệu:</label>
                                                        <form:select class="form-select" path="factory">
                                                            <form:option value="Apple">Apple</form:option>
                                                            <form:option value="Samsung">Samsung</form:option>
                                                            <form:option value="Xiaomi">Xiaomi</form:option>
                                                            <form:option value="Oppo">Oppo</form:option>
                                                            <form:option value="Vivo">Vivo</form:option>
                                                            <form:option value="Nokia">Nokia</form:option>
                                                        </form:select>
                                                    </div>
                                                    <div class="mb-3 col-12 col-md-6">
                                                        <label class="form-label">Dung lượng ROM:</label>
                                                        <form:select class="form-select" path="rom">
                                                            <form:option value="≤128 GB">≤128 GB</form:option>
                                                            <form:option value="256 GB">256 GB</form:option>
                                                            <form:option value="512 GB">512 GB</form:option>
                                                            <form:option value="1 TB">1 TB</form:option>
                                                        </form:select>
                                                    </div>

                                                    <div class="mb-3 col-12 col-md-6">
                                                        <label class="form-label">RAM:</label>
                                                        <form:select class="form-select" path="ram">
                                                            <form:option value="4 GB">4 GB</form:option>
                                                            <form:option value="6 GB">6 GB</form:option>
                                                            <form:option value="8 GB">8 GB</form:option>
                                                            <form:option value="12 GB">12 GB</form:option>
                                                        </form:select>
                                                    </div>

                                                    <div class="mb-3 col-12 col-md-6">
                                                        <label class="form-label">Tần số quét:</label>
                                                        <form:select class="form-select" path="refreshRate">
                                                            <form:option value="60 Hz">60 Hz</form:option>
                                                            <form:option value="90 Hz">90 Hz</form:option>
                                                            <form:option value="120 Hz">120 Hz</form:option>
                                                            <form:option value="Trên 144 Hz">Trên 144 Hz
                                                            </form:option>
                                                        </form:select>
                                                    </div>
                                                    <div class="mb-3 col-12 col-md-6">
                                                        <label class="form-label">Nhu cầu:</label>

                                                        <form:select path="target" class="form-select">
                                                            <form:option value="Chơi game">Chơi game</form:option>
                                                            <form:option value="Cấu hình cao">Cấu hình cao</form:option>
                                                            <form:option value="Pin trâu">Pin trâu</form:option>
                                                            <form:option value="Chụp ảnh đẹp">Chụp ảnh đẹp</form:option>
                                                        </form:select>
                                                    </div>
                                                </div>
                                                <!-- IMAGE -->
                                                <div class="mb-3 col-12">
                                                    <label class="form-label">Ảnh sản phẩm:</label>
                                                    <input type="file" name="imagesFile" class="form-control"
                                                        accept="image/*" />

                                                    <c:if test="${not empty newProduct.image}">
                                                        <div class="mb-2">
                                                            <img src="/images/product/${newProduct.image}"
                                                                alt="Ảnh sản phẩm"
                                                                style="max-width: 300px; max-height: 300px; margin-top: 10px; border: 1px solid #ddd; padding: 4px;" />
                                                        </div>
                                                    </c:if>


                                                </div>

                                                <!-- BUTTON -->
                                                <div class="d-flex justify-content-between">
                                                    <button type="submit" class="btn btn-warning">Cập nhật</button>
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

            </body>

            </html>