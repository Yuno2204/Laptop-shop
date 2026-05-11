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
        <title>Cập nhật thông tin người dùng</title>
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
                    <div class="col-md-6 clo-12 mx-auto">
                      <h4>Cập nhật thông tin người dùng</h4>
                      <hr />
                      <form:form method="post" action="/admin/user/update" modelAttribute="newUser">
                        <div class="mb-3" style="display: none">
                          <label class="form-label">ID:</label>
                          <form:input type="text" class="form-control" path="id" />
                        </div>

                        <div class="mb-3">
                          <label class="form-label">Email:</label>
                          <form:input type="email" class="form-control" path="email" disabled="true" />
                        </div>
                        <div class="mb-3">
                          <label class="form-label">Số điện thoại:</label>
                          <form:input type="text" class="form-control" path="phone" />
                        </div>
                        <div class="mb-3">
                          <label class="form-label">Họ và tên:</label>
                          <form:input type="text" class="form-control" path="fullName" />
                        </div>
                        <div class="row">
                          <div class="col-md-6 mb-3">
                            <label class="form-label">Giới tính:</label>
                            <form:select path="gender" class="form-select">
                              <form:option value="Nam">Nam</form:option>
                              <form:option value="Nữ">Nữ</form:option>
                              <form:option value="Khác">Khác</form:option>
                            </form:select>
                          </div>
                          <div class="col-md-6 mb-3">
                            <label class="form-label">Ngày sinh:</label>
                            <form:input type="date" path="dateOfBirth" class="form-control" />
                          </div>
                        </div>
                        <div class="mb-3">
                          <label class="form-label">Địa chỉ:</label>
                          <form:input type="text" class="form-control" path="address" />
                        </div>
                        <div class="d-flex justify-content-between">
                          <button type="submit" class="btn btn-warning">Cập nhật</button>
                          <a href="/admin/user" class="btn btn-success">Quay lại</a>
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