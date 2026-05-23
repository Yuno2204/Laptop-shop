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
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script>
          // Script để preview ảnh khi chọn file mới
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
                    <div class="col-md-8 col-12 mx-auto">
                      <h4>Cập nhật thông tin người dùng</h4>
                      <hr />
                      <form:form method="post" action="/admin/user/update" modelAttribute="newUser" class="row"
                        enctype="multipart/form-data">

                        <form:input type="hidden" path="id" />
                        <form:input type="hidden" path="password" />

                        <div class="mb-3 col-12 col-md-6">
                          <label class="form-label">Email:</label>
                          <form:input type="email" class="form-control bg-light" path="email" readonly="true" />
                          <form:errors path="email" cssClass="text-danger d-block mt-1" />
                        </div>

                        <div class="mb-3 col-12 col-md-6">
                          <label class="form-label">Họ và tên <span class="text-danger">*</span>:</label>
                          <form:input type="text" class="form-control" path="fullName" />
                          <form:errors path="fullName" cssClass="text-danger d-block mt-1" />
                        </div>

                        <div class="mb-3 col-12 col-md-6">
                          <label class="form-label">Số điện thoại <span class="text-danger">*</span>:</label>
                          <form:input type="text" class="form-control" path="phone" />
                          <form:errors path="phone" cssClass="text-danger d-block mt-1" />
                        </div>

                        <div class="mb-3 col-12 col-md-6">
                          <label class="form-label">Giới tính <span class="text-danger">*</span>:</label>
                          <form:select path="gender" class="form-select">
                            <form:option value="Male">Nam</form:option>
                            <form:option value="Female">Nữ</form:option>
                            <form:option value="Other">Khác</form:option>
                          </form:select>
                          <form:errors path="gender" cssClass="text-danger d-block mt-1" />
                        </div>

                        <div class="mb-3 col-12 col-md-6">
                          <label class="form-label">Ngày sinh <span class="text-danger">*</span>:</label>
                          <form:input type="date" path="dateOfBirth" class="form-control" />
                          <form:errors path="dateOfBirth" cssClass="text-danger d-block mt-1" />
                        </div>

                        <div class="mb-3 col-12 col-md-6">
                          <label class="form-label">Vai trò <span class="text-danger">*</span>:</label>
                          <form:select class="form-select" path="role.name">
                            <form:option value="USER">USER</form:option>
                            <form:option value="ADMIN">ADMIN</form:option>
                            <form:option value="EMPLOYEE">EMPLOYEE</form:option>
                          </form:select>
                        </div>

                        <div class="mb-3 col-12">
                          <label class="form-label">Địa chỉ <span class="text-danger">*</span>:</label>
                          <form:input type="text" class="form-control" path="address" />
                          <form:errors path="address" cssClass="text-danger d-block mt-1" />
                        </div>

                        <div class="mb-3 col-12 col-md-6">
                          <label for="avatarFile" class="form-label">Cập nhật ảnh đại diện:</label>
                          <input class="form-control" type="file" id="avatarFile" accept=".png, .jpg, .jpeg"
                            name="imagesFile" />
                          <small class="text-muted">Để trống nếu muốn giữ nguyên ảnh cũ</small>
                        </div>

                        <div class="col-12 mb-3">
                          <c:choose>
                            <%-- TRƯỜNG HỢP 1: Nếu người dùng ĐÃ CÓ ảnh đại diện -> Hiện ảnh --%>
                              <c:when test="${not empty newUser.avatar}">
                                <img src="/images/avatar/${newUser.avatar}" id="avatarPreview" alt="avatar preview"
                                  style="max-height: 250px; border: 1px solid #ddd; padding: 4px; display: block;" />
                              </c:when>

                              <%-- TRƯỜNG HỢP 2: Nếu người dùng CHƯA CÓ ảnh đại diện -> Ẩn thẻ img đi --%>
                                <c:otherwise>
                                  <img id="avatarPreview" alt="avatar preview"
                                    style="max-height: 250px; border: 1px solid #ddd; padding: 4px; display: none;" />
                                </c:otherwise>
                          </c:choose>
                        </div>

                        <div class="d-flex justify-content-between w-100 mt-3">
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