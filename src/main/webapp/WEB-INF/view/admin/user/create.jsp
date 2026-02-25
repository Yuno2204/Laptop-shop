<%@page contentType="text/html" pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
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
        <div class="col-md-6 clo-12 mx-auto">
          <h4>Create New User</h4>
          <hr />
          <form>
            <div class="mb-3">
              <label class="form-label">Email:</label>
              <input type="email" class="form-control" />
            </div>
            <div class="mb-3">
              <label class="form-label">Password:</label>
              <input type="password" class="form-control" />
            </div>
            <div class="mb-3">
              <label class="form-label">Phone number:</label>
              <input type="text" class="form-control" />
            </div>
            <div class="mb-3">
              <label class="form-label">Full Name:</label>
              <input type="text" class="form-control" />
            </div>
            <div class="mb-3">
              <label class="form-label">Address:</label>
              <input type="text" class="form-control" />
            </div>

            <button type="submit" class="btn btn-primary">Submit</button>
          </form>
        </div>
      </div>
    </div>
  </body>
</html>
