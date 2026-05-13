<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="utf-8" />
                    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                    <meta name="description" content="Đinh Quang Đức - Dự án laptopshop" />
                    <meta name="author" content="Đinh Quang Đức" />
                    <title>Dashboard</title>
                    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css"
                        rel="stylesheet" />
                    <link href="css/styles.css" rel="stylesheet" />
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
                                    <h1 class="mt-4">Dashboard</h1>
                                    <ol class="breadcrumb mb-4">
                                        <li class="breadcrumb-item active">Thống kê</li>
                                    </ol>

                                    <div class="row">

                                        <div class="col-xl-3 col-md-6">
                                            <div class="card bg-primary text-white mb-4 shadow-sm border-0">
                                                <div
                                                    class="card-body d-flex justify-content-between align-items-center">
                                                    <div>
                                                        <div class="small text-white-50 text-uppercase fw-bold mb-1">
                                                            Người dùng</div>
                                                        <div class="fs-4 fw-bold">${countUsers}</div>
                                                    </div>
                                                    <i class="fas fa-users fa-2x text-white-50"></i>
                                                </div>
                                                <div class="card-footer d-flex align-items-center justify-content-between border-top-0"
                                                    style="background-color: rgba(0,0,0,0.1);">
                                                    <a class="small text-white stretched-link text-decoration-none"
                                                        href="/admin/user">Xem chi tiết</a>
                                                    <div class="small text-white"><i class="fas fa-angle-right"></i>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-xl-3 col-md-6">
                                            <div class="card bg-warning text-white mb-4 shadow-sm border-0">
                                                <div
                                                    class="card-body d-flex justify-content-between align-items-center">
                                                    <div>
                                                        <div class="small text-white-50 text-uppercase fw-bold mb-1">Sản
                                                            phẩm</div>
                                                        <div class="fs-4 fw-bold">${countProducts}</div>
                                                    </div>
                                                    <i class="fas fa-mobile-alt fa-2x text-white-50"></i>
                                                </div>
                                                <div class="card-footer d-flex align-items-center justify-content-between border-top-0"
                                                    style="background-color: rgba(0,0,0,0.1);">
                                                    <a class="small text-white stretched-link text-decoration-none"
                                                        href="/admin/product">Xem chi tiết</a>
                                                    <div class="small text-white"><i class="fas fa-angle-right"></i>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-xl-3 col-md-6">
                                            <div class="card bg-success text-white mb-4 shadow-sm border-0">
                                                <div
                                                    class="card-body d-flex justify-content-between align-items-center">
                                                    <div>
                                                        <div class="small text-white-50 text-uppercase fw-bold mb-1">Đơn
                                                            hàng</div>
                                                        <div class="fs-4 fw-bold">${countOrders}</div>
                                                    </div>
                                                    <i class="fas fa-shopping-cart fa-2x text-white-50"></i>
                                                </div>
                                                <div class="card-footer d-flex align-items-center justify-content-between border-top-0"
                                                    style="background-color: rgba(0,0,0,0.1);">
                                                    <a class="small text-white stretched-link text-decoration-none"
                                                        href="/admin/order">Xem chi tiết</a>
                                                    <div class="small text-white"><i class="fas fa-angle-right"></i>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-xl-3 col-md-6">
                                            <div class="card bg-danger text-white mb-4 shadow-sm border-0">
                                                <div
                                                    class="card-body d-flex justify-content-between align-items-center">
                                                    <div>
                                                        <div class="small text-white-50 text-uppercase fw-bold mb-1">
                                                            Tổng doanh thu</div>
                                                        <div class="fs-4 fw-bold">
                                                            <fmt:formatNumber value="${totalRevenue}" type="number" /> đ
                                                        </div>
                                                    </div>
                                                    <i class="fas fa-money-bill-wave fa-2x text-white-50"></i>
                                                </div>
                                                <div class="card-footer d-flex align-items-center justify-content-between border-top-0"
                                                    style="background-color: rgba(0,0,0,0.1);">
                                                    <a class="small text-white stretched-link text-decoration-none"
                                                        href="/admin/order?activeTab=revenue">Xem chi tiết</a>
                                                    <div class="small text-white"><i class="fas fa-angle-right"></i>
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
                    <script src="js/scripts.js"></script>
                    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"
                        crossorigin="anonymous"></script>
                    <script src="js/chart-area-demo.js"></script>
                    <script src="js/chart-bar-demo.js"></script>
                    <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"
                        crossorigin="anonymous"></script>
                    <script src="js/datatables-simple-demo.js"></script>
                </body>

                </html>