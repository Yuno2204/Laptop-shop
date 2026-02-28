<%@page contentType="text/html" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
      <!DOCTYPE html>
      <html lang="en">

      <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="Đinh Quang Đức - Dự án laptopshop" />
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
                <h1 class="mt-4">Quản lý Users</h1>
                <ol class="breadcrumb mb-4">
                  <li class="breadcrumb-item active"><a href="/admin">Dashboard</a></li>
                </ol>
                <div class="container mt-5">
                  <div class="row">
                    <div class="clo-12 mx-auto">
                      <div class="d-flex justify-content-between">
                        <h3>Danh sách người dùng</h3>
                        <a href="/admin/user/create" class="btn btn-primary">
                          Thêm người dùng</a>
                      </div>
                      <hr />
                      <table class="table table-bordered table-hover">
                        <thead>
                          <tr>
                            <th>ID</th>
                            <th>Email</th>
                            <th>Full Name</th>
                            <th>Role</th>
                            <th>Action</th>
                          </tr>
                        </thead>
                        <tbody>
                          <c:forEach var="user" items="${users1}">
                            <tr>
                              <th>${user.id}</th>
                              <td>${user.email}</td>
                              <td>${user.fullName}</td>
                              <td>${user.role.name}</td>
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