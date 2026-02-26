<%@page contentType="text/html" pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%> <%@taglib
uri="http://www.springframework.org/tags/form" prefix="form"%>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Xóa người dùng với id = ${id}</title>
    <!-- Latest compiled and minified CSS -->
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />

    <!-- Latest compiled JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    <!-- jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  </head>
  <body>
    <div class="container mt-5">
      <div class="row">
        <div class="clo-12 mx-auto">
          <h3>Xóa người dùng với id = ${id}</h3>
          <hr />
             <div class="alert alert-danger" role="alert">
                  Bạn có chắn chắc muốn xóa người dùng không?
            </div>
            <form:form  method="post" action="/admin/user/delete" modelAttribute="newUser">
                <div class="mb-3" style="display: none">
                <label class="form-label">ID:</label>
                <form:input value="${id}" type="text" class="form-control" path="id" />
                </div>
                <div class="d-flex justify-content-between">
                <button class="btn btn-danger">Xác Nhận</button>
                <a href="/admin/user"  class="btn btn-success">Quay lại</a>
                </div>
            </form:form>
        </div>
      </div>
    </div>
  </body>
</html>
