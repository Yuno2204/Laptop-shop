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
        <title>Danh sách người dùng</title>
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
                <h1 class="mt-4">Quản Lý Người Dùng</h1>
                <ol class="breadcrumb mb-4">
                  <li class="breadcrumb-item active"><a href="/admin">Dashboard</a></li>
                  <li class="breadcrumb-item active">User</li>
                </ol>
                <div class="container mt-5">
                  <div class="row">
                    <div class="clo-12 mx-auto">
                      <div class="d-flex justify-content-between">
                        <h3>Danh sách người dùng</h3>
                        <div class="d-flex justify-content-between align-items-center mb-4">
                          <div>
                          </div>

                          <div class="d-flex align-items-center gap-3">
                            <div class="search-box-modern mb-0" style="width: 350px;">
                              <i class="fas fa-search search-icon"></i>
                              <input type="text" id="searchInput" data-type="user" placeholder="Tìm kiếm người dùng..."
                                autocomplete="off">
                              <div class="spinner-border text-primary" id="searchSpinner" role="status"></div>
                            </div>

                            <a href="/admin/user/create" class="btn btn-primary px-4">
                              <i class="fas fa-plus me-2"></i>Thêm mới
                            </a>
                            <a href="/admin/user/export" class="btn btn-success shadow-sm">
                              <i class="fas fa-file-excel me-2"></i> Xuất Excel
                            </a>
                          </div>
                        </div>
                      </div>
                      <hr />
                      <table class="table table-bordered table-hover">
                        <thead>
                          <tr>
                            <th>ID</th>
                            <th>Email</th>
                            <th>Họ và tên</th>
                            <th>Số điện thoại</th>
                            <th>Vai trò</th>
                            <th>Chúc năng</th>
                          </tr>
                        </thead>
                        <tbody id="tableBody">
                          <c:forEach var="user" items="${users1}">
                            <tr>
                              <th>${user.id}</th>
                              <td>${user.email}</td>
                              <td>${user.fullName}</td>
                              <td>${user.phone}</td>
                              <td>
                                <c:choose>
                                  <c:when test="${user.role.name == 'ADMIN'}">
                                    <span class="badge bg-primary">${user.role.name}</span>
                                  </c:when>
                                  <c:otherwise>
                                    <span class="badge bg-info text-dark">${user.role.name}</span>
                                  </c:otherwise>
                                </c:choose>
                              </td>
                              <td>
                                <a href="/admin/user/${user.id}" class="btn btn-success">Xem chi tiết</a>
                                <a href="/admin/user/update/${user.id}" class="btn btn-warning mx-2">Cập nhật</a>
                                <a href="/admin/user/delete/${user.id}" class="btn btn-danger">Xóa</a>
                              </td>
                            </tr>
                          </c:forEach>
                        </tbody>
                      </table>
                    </div>
                  </div>
                </div>
                <c:if test="${totalPages > 1}">
                  <nav aria-label="Page navigation" class="mt-4">
                    <ul class="pagination justify-content-center">
                      <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                        <a class="page-link" href="/admin/user?page=${currentPage - 1}" aria-label="Previous">
                          <span aria-hidden="true">&laquo;</span>
                        </a>
                      </li>

                      <c:forEach begin="1" end="${totalPages}" varStatus="loop">
                        <li class="page-item ${currentPage == loop.index ? 'active' : ''}">
                          <a class="page-link" href="/admin/user?page=${loop.index}">${loop.index}</a>
                        </li>
                      </c:forEach>

                      <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                        <a class="page-link" href="/admin/user?page=${currentPage + 1}" aria-label="Next">
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
            </main>
            <jsp:include page="../layout/footer.jsp"></jsp:include>
          </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
          crossorigin="anonymous"></script>
        <script src="/js/scripts.js"></script>
      </body>

      </html>