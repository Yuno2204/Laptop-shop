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
        <title>Thông tin chi tiết người dùng với id = ${id}</title>
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
                        <h3>Thông tin chi tiết người dùng với id = ${id}</h3>
                      </div>
                      <hr />
                      <div class="card" style="width: 60%">
                        <div class="card-header">Thông tin người dùng</div>
                        <ul class="list-group list-group-flush">
                          <li class="list-group-item text-center">
                            <c:if test="${not empty user.avatar}">
                              <img src="/images/avatar/${user.avatar}" alt="avatar"
                                style="width: 150px; height: 150px; object-fit: cover; border-radius: 50%;" />
                            </c:if>
                          </li>
                          <li class="list-group-item">ID: ${user.id}</li>
                          <li class="list-group-item">Email: ${user.email}</li>
                          <li class="list-group-item">Họ và tên: ${user.fullName}</li>
                          <li class="list-group-item">Giới tính:
                            <c:choose>
                              <c:when test="${user.gender == 'Male' || user.gender == 'MALE' || user.gender == 'male'}">
                                Nam</c:when>
                              <c:when
                                test="${user.gender == 'Female' || user.gender == 'FEMALE' || user.gender == 'female'}">
                                Nữ</c:when>
                              <c:otherwise>Khác</c:otherwise>
                            </c:choose>
                          </li>
                          <li class="list-group-item">Ngày sinh: ${user.dateOfBirth}</li>
                          <li class="list-group-item">Số điện thoại: ${user.phone}</li>
                          <li class="list-group-item">Địa chỉ: ${user.address}</li>
                        </ul>
                      </div>
                      <a href="/admin/user" class="btn btn-success mt-3">Quay lại</a>
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