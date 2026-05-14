<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="utf-8">
                <title>${pageTitle} - LongHang Mobile</title>
                <meta content="width=device-width, initial-scale=1.0" name="viewport">

                <link rel="preconnect" href="https://fonts.googleapis.com">
                <link
                    href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@700;800&display=swap"
                    rel="stylesheet">
                <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
                <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
                    rel="stylesheet">

                <link href="/client/css/bootstrap.min.css" rel="stylesheet">
                <link href="/client/css/style.css" rel="stylesheet">

                <style>
                    :root {
                        --primary-red: #d32f2f;
                        /* Màu đỏ thương hiệu mới */
                        --dark-red: #b71c1c;
                        --light-red: #ffebee;
                        --text-dark: #212121;
                    }

                    body {
                        font-family: 'Open Sans', sans-serif;
                        color: var(--text-dark);
                        background-color: #fcfcfc;
                    }

                    /* Header Banner Custom */
                    .info-header {
                        background: linear-gradient(rgba(0, 0, 0, 0.75), rgba(183, 28, 28, 0.4)), url('/client/img/anhnen.jpg');
                        background-size: cover;
                        background-position: center;
                        padding: 100px 0 60px;
                        color: white;
                        text-align: center;
                    }

                    .content-wrapper {
                        margin-top: -60px;
                        margin-bottom: 80px;
                    }

                    .main-card {
                        border: none;
                        border-radius: 20px;
                        box-shadow: 0 25px 50px rgba(0, 0, 0, 0.12);
                        border-top: 8px solid var(--primary-red);
                    }

                    /* Typography & Accents */
                    h2.main-title {
                        color: var(--dark-red);
                        font-weight: 800;
                        margin-bottom: 35px;
                        text-transform: uppercase;
                        border-bottom: 2px solid #eee;
                        padding-bottom: 15px;
                    }

                    h3.sub-title {
                        color: var(--primary-red);
                        font-weight: 700;
                        margin: 45px 0 25px;
                        display: flex;
                        align-items: center;
                    }

                    h3.sub-title i {
                        margin-right: 15px;
                        font-size: 1.3em;
                    }

                    .rich-text {
                        font-size: 1.08rem;
                        line-height: 2;
                        text-align: justify;
                    }

                    .highlight-box {
                        background: var(--light-red);
                        border-left: 6px solid var(--primary-red);
                        padding: 30px;
                        border-radius: 12px;
                        margin: 30px 0;
                    }

                    /* Tables */
                    .custom-table {
                        border-radius: 12px;
                        overflow: hidden;
                        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.06);
                    }

                    .custom-table thead {
                        background-color: var(--primary-red);
                        color: white;
                    }

                    .table-hover tbody tr:hover {
                        background-color: var(--light-red);
                    }

                    /* FAQ Section */
                    .faq-card {
                        border: 1px solid #eee;
                        border-radius: 12px;
                        margin-bottom: 15px;
                        transition: 0.3s;
                    }

                    .faq-card:hover {
                        border-color: var(--primary-red);
                        transform: translateX(5px);
                    }

                    .faq-header {
                        padding: 20px;
                        font-weight: 700;
                        color: var(--text-dark);
                        cursor: pointer;
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                    }

                    .faq-header i {
                        color: var(--primary-red);
                    }

                    .faq-body {
                        padding: 0 20px 20px;
                        color: #555;
                    }

                    /* Icons Group */
                    .feature-icon-red {
                        font-size: 3.5rem;
                        color: var(--primary-red);
                        margin-bottom: 20px;
                        transition: 0.4s;
                    }

                    .feature-card:hover .feature-icon-red {
                        transform: scale(1.1);
                        color: var(--dark-red);
                    }

                    .breadcrumb-item a {
                        color: #fff;
                        text-decoration: none;
                        opacity: 0.8;
                    }

                    .breadcrumb-item.active {
                        color: var(--primary-red) !important;
                        font-weight: bold;
                    }
                </style>
            </head>

            <body>
                <jsp:include page="../layout/header.jsp" />

                <div class="container-fluid info-header">
                    <h1 class="display-3 text-white fw-bold animate__animated animate__fadeInDown">${pageTitle}</h1>
                    <nav aria-label="breadcrumb">

                    </nav>
                </div>

                <div class="container content-wrapper">
                    <div class="row justify-content-center">
                        <div class="col-lg-11">
                            <div class="card main-card p-4 p-md-5 bg-white">
                                <div class="rich-text">

                                    <c:choose>
                                        <%--========================GIỚI THIỆU========================--%>
                                            <c:when test="${viewType == 'about'}">
                                                <h2 class="main-title text-center">Hệ Thống Bán Lẻ LongHang Mobile</h2>
                                                <p class="lead text-center mb-5 fw-normal">Sứ mệnh của chúng tôi là mang
                                                    những sản phẩm công nghệ đỉnh cao với mức giá dễ tiếp cận nhất đến
                                                    tay người tiêu dùng Việt Nam.</p>

                                                <h3 class="sub-title"><i class="fas fa-history"></i> Quá Trình Hình
                                                    Thành</h3>
                                                <p>Được thành lập từ tháng 05/2021, <strong>LongHang Mobile</strong> bắt
                                                    đầu từ một cửa hàng sửa chữa phần cứng chuyên sâu tại trung tâm Hà
                                                    Nội. Với kiến thức kỹ thuật vững chắc, chúng tôi hiểu rõ từng linh
                                                    kiện bên trong mỗi thiết bị. Đó là lý do tại sao mọi máy điện thoại
                                                    được bán ra tại hệ thống đều phải trải qua quy trình kiểm tra
                                                    "Full-Stress Test" 48 tiếng trước khi lên kệ.</p>

                                                <div class="row g-4 my-5 text-center">
                                                    <div class="col-md-4 feature-card">
                                                        <i class="fas fa-award feature-icon-red"></i>
                                                        <h4>Chất Lượng Số 1</h4>
                                                        <p class="small text-muted">Mọi sản phẩm cam kết zin 100%, không
                                                            qua sửa chữa hay thay thế linh kiện kém chất lượng.</p>
                                                    </div>
                                                    <div class="col-md-4 feature-card">
                                                        <i class="fas fa-shipping-fast feature-icon-red"></i>
                                                        <h4>Giao Hàng Thần Tốc</h4>
                                                        <p class="small text-muted">Hỗ trợ ship COD toàn quốc, kiểm tra
                                                            hàng thoải mái trước khi thanh toán.</p>
                                                    </div>
                                                    <div class="col-md-4 feature-card">
                                                        <i class="fas fa-headset feature-icon-red"></i>
                                                        <h4>Hỗ Trợ 24/7</h4>
                                                        <p class="small text-muted">Đội ngũ kỹ thuật luôn sẵn sàng giải
                                                            đáp thắc mắc qua Hotline ngay cả ngày nghỉ.</p>
                                                    </div>
                                                </div>

                                                <h3 class="sub-title"><i class="fas fa-bullseye"></i> Cam Kết Cộng Đồng
                                                </h3>
                                                <p>Chúng tôi không chỉ kinh doanh vì lợi nhuận. LongHang Mobile thường
                                                    xuyên tổ chức các chương trình hỗ trợ sinh viên đổi máy cũ lấy máy
                                                    mới với mức trợ giá lên đến 2.000.000đ. Chúng tôi tin rằng công nghệ
                                                    là chìa khóa để thế hệ trẻ vươn xa hơn.</p>
                                            </c:when>

                                            <%--========================BẢO HÀNH========================--%>
                                                <c:when test="${viewType == 'warranty'}">
                                                    <h2 class="main-title">Chính Sách Bảo Hành "Đặc Quyền"</h2>
                                                    <p>Chúng tôi tự tin vào chất lượng sản phẩm của mình, vì vậy
                                                        LongHang Mobile mang đến gói bảo hành dài nhất thị trường hiện
                                                        nay.</p>

                                                    <h3 class="sub-title"><i class="fas fa-id-card"></i> Gói Bảo Hành
                                                        Tiêu Chuẩn</h3>
                                                    <div class="table-responsive custom-table">
                                                        <table class="table table-hover align-middle">
                                                            <thead>
                                                                <tr>
                                                                    <th>Hạng Mục</th>
                                                                    <th>Máy Mới (Fullbox)</th>
                                                                    <th>Máy Cũ (Likenew)</th>
                                                                    <th>Linh Kiện Thay Thế</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <tr>
                                                                    <td>Phần cứng (Main)</td>
                                                                    <td>15 Tháng</td>
                                                                    <td>12 Tháng</td>
                                                                    <td>06 Tháng</td>
                                                                </tr>
                                                                <tr>
                                                                    <td>Nguồn & Màn hình</td>
                                                                    <td>06 Tháng</td>
                                                                    <td>03 Tháng</td>
                                                                    <td>03 Tháng</td>
                                                                </tr>
                                                                <tr>
                                                                    <td>Pin (Thay mới nếu dưới 80%)</td>
                                                                    <td>12 Tháng</td>
                                                                    <td>06 Tháng</td>
                                                                    <td>06 Tháng</td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </div>

                                                    <div class="highlight-box">
                                                        <h4 class="text-danger fw-bold"><i
                                                                class="fas fa-exclamation-triangle"></i> Lưu ý quan
                                                            trọng:</h4>
                                                        <ul>
                                                            <li>Khách hàng vui lòng giữ tem bảo hành nguyên vẹn, không
                                                                rách rời hoặc chắp vá.</li>
                                                            <li>Mọi dữ liệu cá nhân khách hàng tự chịu trách nhiệm sao
                                                                lưu trước khi gửi máy bảo hành.</li>
                                                            <li>Thời gian xử lý bảo hành: Từ 1-3 ngày làm việc (không
                                                                tính CN).</li>
                                                        </ul>
                                                    </div>
                                                </c:when>

                                                <%--========================ĐỔI TRẢ========================--%>
                                                    <c:when test="${viewType == 'return'}">
                                                        <h2 class="main-title">Chính Sách Đổi Trả - Hoàn Tiền</h2>
                                                        <p>Sự hài lòng của quý khách là ưu tiên hàng đầu. Nếu máy có lỗi
                                                            hoặc đơn giản bạn thấy không phù hợp, hãy để chúng tôi hỗ
                                                            trợ.</p>

                                                        <h3 class="sub-title"><i class="fas fa-undo-alt"></i> Quy Định
                                                            "1 Đổi 1"</h3>
                                                        <p>Trong vòng <strong>30 ngày đầu tiên</strong> kể từ ngày mua,
                                                            nếu thiết bị phát sinh lỗi phần cứng từ nhà sản xuất (không
                                                            bao gồm lỗi do người dùng), LongHang Mobile sẽ đổi ngay một
                                                            chiếc máy khác cùng tình trạng mà không thu bất kỳ khoản phí
                                                            nào.</p>

                                                        <h3 class="sub-title"><i class="fas fa-wallet"></i> Phí Thu Lại
                                                            / Lên Đời</h3>
                                                        <div class="table-responsive custom-table">
                                                            <table class="table table-bordered text-center">
                                                                <thead class="bg-dark text-white">
                                                                    <tr>
                                                                        <th>Thời gian</th>
                                                                        <th>Lỗi NSX</th>
                                                                        <th>Lên Đời (Máy Cao Hơn)</th>
                                                                        <th>Trả Máy (Hoàn Tiền)</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <tr>
                                                                        <td>1 - 7 Ngày</td>
                                                                        <td>Đổi máy mới</td>
                                                                        <td>Khấu trừ 0%</td>
                                                                        <td>Khấu trừ 10%</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>8 - 30 Ngày</td>
                                                                        <td>Đổi máy mới</td>
                                                                        <td>Khấu trừ 10%</td>
                                                                        <td>Khấu trừ 20%</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>Trên 30 Ngày</td>
                                                                        <td>Bảo hành</td>
                                                                        <td>Theo giá thị trường</td>
                                                                        <td>Thỏa thuận trực tiếp</td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </c:when>

                                                    <%--========================ĐIỀU KHOẢN========================--%>
                                                        <c:when test="${viewType == 'terms'}">
                                                            <h2 class="main-title">Điều Khoản Sử Dụng Dịch Vụ</h2>
                                                            <p>Khi bạn sử dụng dịch vụ tại LongHang Mobile, bạn đồng ý
                                                                tuân thủ các quy định dưới đây để đảm bảo quyền lợi đôi
                                                                bên.</p>

                                                            <h4 class="mt-4 fw-bold"><i
                                                                    class="fas fa-user-check me-2"></i> 1. Trách nhiệm
                                                                người mua</h4>
                                                            <p>Quý khách cần cung cấp đúng số điện thoại và địa chỉ giao
                                                                hàng để chúng tôi phục vụ tốt nhất. Mọi hành vi giả mạo
                                                                đặt hàng gây thiệt hại cho shop sẽ bị xử lý theo quy
                                                                định của pháp luật hiện hành.</p>

                                                            <h4 class="mt-4 fw-bold"><i
                                                                    class="fas fa-money-bill-wave me-2"></i> 2. Thanh
                                                                toán và Bảo mật</h4>
                                                            <p>Chúng tôi cam kết bảo mật tuyệt đối thông tin thẻ tín
                                                                dụng và dữ liệu cá nhân của khách hàng thông qua chuẩn
                                                                SSL quốc tế. Giá niêm yết trên website là giá cuối cùng
                                                                đã bao gồm các loại thuế.</p>

                                                            <h4 class="mt-4 fw-bold"><i class="fas fa-gavel me-2"></i>
                                                                3. Quyền sở hữu trí tuệ</h4>
                                                            <p>Toàn bộ hình ảnh sản phẩm và nội dung bài viết được thực
                                                                hiện bởi đội ngũ Media của LongHang Mobile. Nghiêm cấm
                                                                mọi hành vi sao chép cho mục đích thương mại khi chưa có
                                                                sự đồng ý bằng văn bản.</p>
                                                        </c:when>

                                                        <%--========================FAQ========================--%>
                                                            <c:when test="${viewType == 'faq'}">
                                                                <h2 class="main-title text-center">Trung Tâm Hỗ Trợ
                                                                    Khách Hàng</h2>

                                                                <div class="faq-card">
                                                                    <div class="faq-header">Q1: Tôi ở xa thì mua hàng và
                                                                        thanh toán như thế nào? <i
                                                                            class="fas fa-chevron-down"></i></div>
                                                                    <div class="faq-body">Dạ, shop hỗ trợ ship COD toàn
                                                                        quốc. Quý khách chỉ cần đặt hàng trên web, shop
                                                                        sẽ gọi xác nhận. Khi hàng đến, quý khách được mở
                                                                        hộp kiểm tra đúng máy, đúng màu rồi mới thanh
                                                                        toán tiền cho nhân viên bưu điện.</div>
                                                                </div>

                                                                <div class="faq-card">
                                                                    <div class="faq-header">Q2: Shop có hỗ trợ trả góp
                                                                        0% không? <i class="fas fa-chevron-down"></i>
                                                                    </div>
                                                                    <div class="faq-body">Có ạ! Shop hỗ trợ trả góp 0%
                                                                        qua thẻ tín dụng của 26 ngân hàng lớn. Ngoài ra
                                                                        còn hỗ trợ trả góp qua CMND/CCCD thông qua các
                                                                        công ty tài chính như HomeCredit, FE Credit với
                                                                        tỷ lệ duyệt lên đến 95%.</div>
                                                                </div>

                                                                <div class="faq-card">
                                                                    <div class="faq-header">Q3: Sản phẩm cũ tại shop có
                                                                        còn chống nước không? <i
                                                                            class="fas fa-chevron-down"></i></div>
                                                                    <div class="faq-body">Vì là máy cũ đã qua sử dụng,
                                                                        áp suất chống nước có thể không còn 100% như máy
                                                                        mới sản xuất. Do đó, shop khuyến cáo quý khách
                                                                        không nên mang máy đi bơi hoặc ngâm nước. Shop
                                                                        sẽ không bảo hành lỗi vào nước ạ.</div>
                                                                </div>

                                                                <div class="faq-card">
                                                                    <div class="faq-header">Q4: Thời gian giao hàng mất
                                                                        bao lâu? <i class="fas fa-chevron-down"></i>
                                                                    </div>
                                                                    <div class="faq-body">Nội thành Hà Nội shop giao
                                                                        ngay trong 2h. Các tỉnh thành khác thời gian
                                                                        nhận hàng từ 2-4 ngày làm việc tùy khu vực.
                                                                    </div>
                                                                </div>
                                                            </c:when>

                                                            <c:otherwise>
                                                                <div class="text-center py-5">
                                                                    <i
                                                                        class="fas fa-tools display-1 text-muted mb-4"></i>
                                                                    <h3>Tính năng đang bảo trì</h3>
                                                                    <p>Vui lòng quay lại sau ít phút.</p>
                                                                </div>
                                                            </c:otherwise>
                                    </c:choose>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <jsp:include page="../layout/footer.jsp" />

                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>