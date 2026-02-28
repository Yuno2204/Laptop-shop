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
        <title>Thêm mới người dùng</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
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
                      <h4>Thêm mới người dùng</h4>
                      <hr />
                      <form:form method="post" action="/admin/user/create" modelAttribute="newUser" class="row"
                        enctype="multipart/form-data">
                        <div class="mb-3 clo-12 col-md-6">
                          <label class="form-label">Email:</label>
                          <form:input type="email" class="form-control" path="email" />
                        </div>
                        <div class="mb-3 clo-12 col-md-6">
                          <label class="form-label">Password:</label>
                          <form:input type="password" class="form-control" path="password" />
                        </div>
                        <div class="mb-3 clo-12 col-md-6">
                          <label class="form-label">Phone number:</label>
                          <form:input type="text" class="form-control" path="phone" />
                        </div>
                        <div class="mb-3 clo-12 col-md-6">
                          <label class="form-label">Full Name:</label>
                          <form:input type="text" class="form-control" path="fullName" />
                        </div>
                        <div class="mb-3 clo-12">
                          <label class="form-label">Address:</label>
                          <form:input type="text" class="form-control" path="address" />
                        </div>
                        <div class="mb-3 col-12 col-md-6">
                          <label class="form-label">Role:</label>
                          <form:select class="form-select" path="role.name">
                            <form:option value="ADMIN">ADMIN</form:option>
                            <form:option value="USER">USER</form:option>
                          </form:select>
                        </div>
                        <div class="mb-3 col-12 col-md-6">
                          <label for="avatarFile" class="form-label">Avatar:</label>
                          <input class="form-control" type="file" id="avatarFile" accept=".png, .jpg, .jpeg"
                            name="imagesFile" />
                        </div>
                        <div class="col-12 mb-3">
                          <img style="max-height: 250px; display: none;" alt="avatar preview" id="avatarPreview" />
                        </div>
                        <div class="d-flex justify-content-between">
                          <button type="submit" class="btn btn-primary">Thêm mới</button>
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