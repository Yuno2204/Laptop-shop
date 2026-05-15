<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="utf-8" />
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                <title>Quản lý tồn kho - Admin</title>
                <link href="/css/styles.css" rel="stylesheet" />
                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
                <style>
                    .product-img-sm {
                        width: 50px;
                        height: 50px;
                        object-fit: cover;
                        border-radius: 8px;
                        border: 1px solid #eee;
                    }

                    .table-middle td {
                        vertical-align: middle;
                    }

                    .pagination .page-link {
                        color: #81c408;
                    }

                    .pagination .page-item.active .page-link {
                        background-color: #81c408;
                        border-color: #81c408;
                        color: white;
                    }
                </style>
            </head>

            <body class="sb-nav-fixed">
                <jsp:include page="../layout/header.jsp" />
                <div id="layoutSidenav">
                    <jsp:include page="../layout/sidebar.jsp" />

                    <div id="layoutSidenav_content">
                        <main>
                            <div class="container-fluid px-4">
                                <h1 class="mt-4">Quản lý tồn kho</h1>
                                <ol class="breadcrumb mb-4">
                                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                                    <li class="breadcrumb-item active">Kho hàng</li>
                                </ol>

                                <c:if test="${not empty successMsg}">
                                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                                        <i class="fas fa-check-circle me-1"></i> ${successMsg}
                                        <button type="button" class="btn-close" data-bs-dismiss="alert"
                                            aria-label="Close"></button>
                                    </div>
                                </c:if>

                                <div class="card mb-4 shadow-sm border-0">
                                    <div
                                        class="card-header bg-white py-3 fw-bold d-flex justify-content-between align-items-center">
                                        <div>
                                            <i class="fas fa-boxes me-1 text-primary"></i> Danh sách hàng hóa trong kho
                                        </div>
                                        <a href="/admin/inventory/export" class="btn btn-success btn-sm fw-bold">
                                            <i class="fas fa-file-excel me-1"></i> Xuất Excel
                                        </a>
                                    </div>
                                    <div class="card-body">
                                        <div class="table-responsive">
                                            <table class="table table-hover table-middle mb-0">
                                                <thead class="table-light">
                                                    <tr>
                                                        <th>ID</th>
                                                        <th>Ảnh</th>
                                                        <th>Tên sản phẩm</th>
                                                        <th class="text-center">Số lượng tồn</th>
                                                        <th class="text-center">Trạng thái</th>
                                                        <th class="text-center">Hành động</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="product" items="${products}">
                                                        <tr>
                                                            <td>${product.id}</td>
                                                            <td>
                                                                <img src="/images/product/${product.image}"
                                                                    class="product-img-sm" alt="">
                                                            </td>
                                                            <td class="fw-bold text-dark">${product.name}</td>
                                                            <td class="text-center fw-bold fs-5">${product.quantity}
                                                            </td>
                                                            <td class="text-center">
                                                                <c:choose>
                                                                    <c:when test="${product.quantity == 0}">
                                                                        <span
                                                                            class="badge bg-danger rounded-pill px-3 py-2">Hết
                                                                            hàng</span>
                                                                    </c:when>
                                                                    <c:when test="${product.quantity <= 30}">
                                                                        <span
                                                                            class="badge bg-warning text-dark rounded-pill px-3 py-2">Sắp
                                                                            hết hàng</span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span
                                                                            class="badge bg-success rounded-pill px-3 py-2">Sẵn
                                                                            hàng</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                            <td class="text-center">
                                                                <button class="btn btn-sm btn-primary px-3"
                                                                    data-bs-toggle="modal" data-bs-target="#importModal"
                                                                    data-id="${product.id}" data-name="${product.name}"
                                                                    data-qty="${product.quantity}"
                                                                    onclick="setModalData(this)">
                                                                    <i class="fas fa-plus-circle me-1"></i> Nhập kho
                                                                </button>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>

                                        <c:if test="${totalPages > 1}">
                                            <nav aria-label="Page navigation" class="mt-4">
                                                <ul class="pagination justify-content-center">
                                                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                                        <a class="page-link"
                                                            href="/admin/inventory?page=${currentPage - 1}"
                                                            aria-label="Previous">
                                                            <span aria-hidden="true">&laquo;</span>
                                                        </a>
                                                    </li>

                                                    <c:forEach begin="1" end="${totalPages}" varStatus="loop">
                                                        <li
                                                            class="page-item ${currentPage == loop.index ? 'active' : ''}">
                                                            <a class="page-link"
                                                                href="/admin/inventory?page=${loop.index}">${loop.index}</a>
                                                        </li>
                                                    </c:forEach>

                                                    <li
                                                        class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                                        <a class="page-link"
                                                            href="/admin/inventory?page=${currentPage + 1}"
                                                            aria-label="Next">
                                                            <span aria-hidden="true">&raquo;</span>
                                                        </a>
                                                    </li>
                                                </ul>
                                            </nav>
                                        </c:if>
                                        <style>
                                            /* CSS làm đẹp nút phân trang theo màu chủ đạo của bạn */
                                            .pagination .page-link {
                                                color: #6cd5ff;
                                                border-radius: 5px;
                                                margin: 0 2px;
                                            }

                                            .pagination .page-item.active .page-link {
                                                background-color: #6cd5ff;
                                                border-color: #6cd5ff;
                                                color: white;
                                            }

                                            .pagination .page-item.disabled .page-link {
                                                color: #ccc;
                                            }
                                        </style>
                                    </div>
                                </div>
                            </div>
                        </main>
                        <jsp:include page="../layout/footer.jsp" />
                    </div>
                </div>

                <div class="modal fade" id="importModal" tabindex="-1" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content border-0 shadow">
                            <form action="/admin/inventory/import" method="post">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                <input type="hidden" name="productId" id="modalProductId">

                                <div class="modal-header bg-primary text-white">
                                    <h5 class="modal-title"><i class="fas fa-truck-loading me-2"></i>Nhập hàng vào kho
                                    </h5>
                                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                                        aria-label="Close"></button>
                                </div>
                                <div class="modal-body p-4 text-center">
                                    <h5 id="modalProductName" class="fw-bold mb-1">Tên sản phẩm</h5>
                                    <p class="text-muted mb-4">Tồn kho hiện tại: <span id="modalCurrentQty"
                                            class="text-primary fw-bold">0</span></p>

                                    <div class="form-group">
                                        <label class="form-label fw-bold">Số lượng nhập thêm:</label>
                                        <input type="number" class="form-control form-control-lg text-center"
                                            name="addQuantity" min="1" value="1" required>
                                    </div>
                                </div>
                                <div class="modal-footer bg-light border-0">
                                    <button type="button" class="btn btn-secondary px-4"
                                        data-bs-dismiss="modal">Hủy</button>
                                    <button type="submit" class="btn btn-primary px-4 fw-bold">Xác nhận nhập
                                        kho</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                    crossorigin="anonymous"></script>
                <script src="/js/scripts.js"></script>

                <script>
                    function setModalData(button) {
                        // Trích xuất dữ liệu từ các thuộc tính data-* của nút bấm
                        const id = button.getAttribute('data-id');
                        const name = button.getAttribute('data-name');
                        const qty = button.getAttribute('data-qty');

                        // Gắn dữ liệu vào các thẻ trong Modal
                        document.getElementById('modalProductId').value = id;
                        document.getElementById('modalProductName').innerText = name;
                        document.getElementById('modalCurrentQty').innerText = qty;

                        // Tự động reset ô nhập số lượng về 1 mỗi khi mở
                        document.querySelector('input[name="addQuantity"]').value = 1;
                    }
                </script>
            </body>

            </html>