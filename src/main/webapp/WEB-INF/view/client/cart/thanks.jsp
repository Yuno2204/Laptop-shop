<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Đặt hàng thành công - Mobile Shop</title>

                <link rel="preconnect" href="https://fonts.googleapis.com">
                <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                <link
                    href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
                    rel="stylesheet">
                <link href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" rel="stylesheet">
                <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
                    rel="stylesheet">

                <link href="/client/css/bootstrap.min.css" rel="stylesheet">
                <link href="/client/css/style.css" rel="stylesheet">

                <style>
                    .thank-you-section {
                        margin-top: 150px;
                        margin-bottom: 100px;
                    }

                    .card-success {
                        border: none;
                        border-radius: 20px;
                        box-shadow: 0 0 45px rgba(0, 0, 0, .08);
                    }

                    .check-icon {
                        width: 100px;
                        height: 100px;
                        line-height: 100px;
                        background: #81c408;
                        /* Màu xanh lá đặc trưng của dự án bạn */
                        color: white;
                        font-size: 50px;
                        border-radius: 50%;
                        display: inline-block;
                        margin-bottom: 20px;
                        align-items: center;
                        justify-content: center;
                    }

                    .btn-custom {
                        padding: 15px 30px;
                        border-radius: 50px;
                        font-weight: 600;
                        transition: 0.5s;
                    }
                </style>
            </head>

            <body>
                <jsp:include page="../layout/header.jsp" />

                <div class="container-fluid thank-you-section">
                    <div class="container text-center">
                        <div class="row justify-content-center">
                            <div class="col-lg-6">
                                <div class="card card-success p-5">
                                    <div class="d-flex justify-content-center">
                                        <div class="check-icon">
                                            <i class="fa fa-check"></i>
                                        </div>
                                    </div>
                                    <h1 class="display-4 fw-bold text-dark mb-3">Thành Công!</h1>
                                    <h4 class="text-secondary mb-4">Cảm ơn bạn đã đặt hàng tại Mobile Shop</h4>
                                    <p class="mb-5 text-muted">
                                        Đơn hàng của bạn đã được tiếp nhận và đang trong quá trình xử lý.
                                        Chúng tôi sẽ liên hệ với bạn qua số điện thoại để xác nhận sớm nhất.
                                    </p>

                                    <div class="d-flex justify-content-center gap-3">
                                        <a href="/"
                                            class="btn btn-primary border-2 border-secondary btn-custom text-white">
                                            Tiếp Tục Mua Sắm
                                        </a>
                                        <a href="/order-history"
                                            class="btn btn-secondary border-2 border-primary btn-custom text-white">
                                            Lịch Sử Mua Hàng
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <jsp:include page="../layout/footer.jsp" />

                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
                <script src="/resources/client/js/main.js"></script>
            </body>

            </html>