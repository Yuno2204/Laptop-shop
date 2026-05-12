<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                <title>Quản lý đơn hàng - MobileShop</title>
                <link href="/css/styles.css" rel="stylesheet" />
                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
                <style>
                    .nav-tabs .nav-link {
                        color: #495057;
                        font-weight: 600;
                    }

                    .nav-tabs .nav-link.active {
                        color: #0d6efd;
                        border-bottom: 3px solid #0d6efd;
                    }
                </style>
            </head>

            <body class="sb-nav-fixed">
                <jsp:include page="../layout/header.jsp"></jsp:include>
                <div id="layoutSidenav">
                    <jsp:include page="../layout/sidebar.jsp"></jsp:include>
                    <div id="layoutSidenav_content">
                        <main>
                            <div class="container-fluid px-4">
                                <h1 class="mt-4">Quản Lý Đơn Hàng</h1>
                                <ol class="breadcrumb mb-4">
                                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                                    <li class="breadcrumb-item active">Order</li>
                                </ol>

                                <ul class="nav nav-tabs mb-3" id="orderTab" role="tablist">
                                    <li class="nav-item" role="presentation">
                                        <button class="nav-link active" id="orders-tab" data-bs-toggle="tab"
                                            data-bs-target="#orders" type="button" role="tab">
                                            <i class="fas fa-list-ul me-2"></i>Quản lý đơn hàng
                                        </button>
                                    </li>
                                    <li class="nav-item" role="presentation">
                                        <button class="nav-link" id="revenue-tab" data-bs-toggle="tab"
                                            data-bs-target="#revenue" type="button" role="tab">
                                            <i class="fas fa-chart-line me-2"></i>Doanh thu
                                        </button>
                                    </li>
                                </ul>

                                <div class="tab-content" id="orderTabContent">

                                    <div class="tab-pane fade show active" id="orders" role="tabpanel">
                                        <div class="card shadow-sm border-0">
                                            <div
                                                class="card-header d-flex justify-content-between align-items-center bg-white py-3">
                                                <h5 class="mb-0">Danh sách đơn hàng</h5>
                                                <div class="d-flex align-items-center justify-content-end ">

                                                    <div class="search-box-modern mb-0" style="width: 350px;">
                                                        <i class="fas fa-search search-icon"></i>
                                                        <input type="text" id="searchInput" data-type="order"
                                                            placeholder="Tìm kiếm người nhận hoặc SĐT..."
                                                            autocomplete="off">
                                                        <div class="spinner-border text-primary" id="searchSpinner"
                                                            role="status"></div>
                                                    </div>

                                                    <a href="/admin/order/export"
                                                        class="btn btn-success shadow-sm text-nowrap">
                                                        <i class="fas fa-file-excel me-2"></i> Xuất Excel
                                                    </a>

                                                </div>
                                            </div>
                                            <div class="card-body">
                                                <div class="table-responsive">
                                                    <table class="table table-bordered table-hover align-middle">
                                                        <thead class="table-light">
                                                            <tr>
                                                                <th>ID</th>
                                                                <th>Người nhận</th>
                                                                <th>SĐT</th>
                                                                <th>Địa chỉ</th>
                                                                <th>Tổng tiền</th>
                                                                <th>Trạng thái</th>
                                                                <th>Thao tác</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody id="tableBody">
                                                            <c:forEach var="order" items="${orders}">
                                                                <tr>
                                                                    <td>${order.id}</td>
                                                                    <td>${order.receiverName}</td>
                                                                    <td>${order.receiverPhone}</td>
                                                                    <td>${order.receiverAddress}</td>
                                                                    <td>
                                                                        <fmt:formatNumber value="${order.totalPrice}"
                                                                            type="number" /> đ
                                                                    </td>
                                                                    <td>
                                                                        <c:choose>
                                                                            <c:when
                                                                                test="${order.status == 'DELIVERED' || order.status == 'SUCCESS'}">
                                                                                <span
                                                                                    class="badge bg-success">${order.status}</span>
                                                                            </c:when>
                                                                            <c:when test="${order.status == 'PENDING'}">
                                                                                <span
                                                                                    class="badge bg-warning text-dark">${order.status}</span>
                                                                            </c:when>
                                                                            <c:when
                                                                                test="${order.status == 'CANCELLED'}">
                                                                                <span
                                                                                    class="badge bg-danger">${order.status}</span>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <span
                                                                                    class="badge bg-primary">${order.status}</span>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </td>
                                                                    <td>
                                                                        <a href="/admin/order/${order.id}"
                                                                            class="btn btn-success btn-sm">Xem</a>
                                                                        <a href="/admin/order/update/${order.id}"
                                                                            class="btn btn-warning btn-sm">Sửa</a>
                                                                        <a href="/admin/order/delete/${order.id}"
                                                                            class="btn btn-danger btn-sm">Xóa</a>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="tab-pane fade" id="revenue" role="tabpanel">
                                        <div class="card shadow-sm border-0">
                                            <div class="card-header bg-white py-3">
                                                <h5 class="mb-0">Thống kê doanh thu (Đơn hàng thành công)</h5>
                                            </div>
                                            <div class="card-body">
                                                <div class="row g-3 mb-4">
                                                    <div class="col-md-3">
                                                        <label class="form-label fw-bold">Từ ngày</label>
                                                        <input type="date" id="startDate" name="startDate"
                                                            class="form-control">
                                                    </div>
                                                    <div class="col-md-3">
                                                        <label class="form-label fw-bold">Đến ngày</label>
                                                        <input type="date" id="endDate" name="endDate"
                                                            class="form-control">
                                                    </div>
                                                    <div class="col-md-6 d-flex align-items-end">
                                                        <button type="button" class="btn btn-primary px-4"
                                                            onclick="filterRevenueAJAX()">
                                                            <i class="fas fa-filter me-2"></i>Lọc doanh thu
                                                        </button>
                                                        <button type="button" class="btn btn-success px-4 ms-auto"
                                                            onclick="exportExcel()">
                                                            <i class="fas fa-file-excel me-2"></i>Xuất Excel
                                                        </button>
                                                    </div>
                                                </div>

                                                <div class="table-responsive">
                                                    <table class="table table-bordered align-middle">
                                                        <thead class="table-light text-center">
                                                            <tr>
                                                                <th>Mã đơn</th>
                                                                <th>Khách hàng</th>
                                                                <th>SĐT</th>
                                                                <th>Ngày đặt</th>
                                                                <th>Ngày nhận</th>
                                                                <th>Tổng tiền</th>
                                                                <th>Trạng thái</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody id="revenueTableBody">
                                                            <c:forEach items="${revenueOrders}" var="order">
                                                                <tr>
                                                                    <td class="text-center">${order.id}</td>
                                                                    <td>${order.receiverName}</td>
                                                                    <td>${order.receiverPhone}</td>
                                                                    <td class="text-center">${order.orderDate}</td>
                                                                    <td class="text-center">${order.deliveredDate}</td>
                                                                    <td class="text-end fw-bold">
                                                                        <fmt:formatNumber value="${order.totalPrice}"
                                                                            type="number" /> đ
                                                                    </td>
                                                                    <td class="text-center">
                                                                        <span class="badge bg-success">DELIVERED</span>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                            <c:if test="${empty revenueOrders}">
                                                                <tr>
                                                                    <td colspan="7" class="text-center py-4 text-muted">
                                                                        Không có dữ liệu doanh thu trong khoảng thời
                                                                        gian này.
                                                                    </td>
                                                                </tr>
                                                            </c:if>
                                                        </tbody>
                                                        <tfoot>
                                                            <tr class="table-warning">
                                                                <th colspan="5" class="text-end fs-5"
                                                                    id="totalRevenueDisplay">TỔNG DOANH THU:
                                                                </th>
                                                                <th colspan="2" class="text-danger fs-5">
                                                                    <fmt:formatNumber value="${totalRevenue}"
                                                                        type="number" /> đ
                                                                </th>
                                                            </tr>
                                                        </tfoot>
                                                    </table>
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
                <script>
                    // Logic để giữ tab "Doanh thu" active sau khi bấm Lọc (Nếu bạn dùng submit form truyền thống)
                    window.onload = function () {
                        const urlParams = new URLSearchParams(window.location.search);
                        if (urlParams.get('startDate') || urlParams.get('activeTab') === 'revenue') {
                            var revenueTab = new bootstrap.Tab(document.querySelector('#revenue-tab'));
                            revenueTab.show();
                        }
                    };

                    function exportExcel() {
                        const start = document.querySelector('input[name="startDate"]').value;
                        const end = document.querySelector('input[name="endDate"]').value;
                        if (!start || !end) return alert("Vui lòng chọn khoảng ngày để xuất Excel!");
                        window.location.href = "/admin/order/revenue/export?startDate=" + start + "&endDate=" + end;
                    }
                </script>
            </body>

            </html>