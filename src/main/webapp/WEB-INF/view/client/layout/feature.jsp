<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <style>
            .feature-wrapper {
                background-color: #fcfcfc;
            }

            .feature-card {
                background: #ffffff;
                border-radius: 20px;
                padding: 35px 20px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.03);
                border: 1px solid rgba(0, 0, 0, 0.02);
                transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
                height: 100%;
                cursor: pointer;
            }

            /* Hiệu ứng khi di chuột (Nổi lên và hiện viền đỏ mờ) */
            .feature-card:hover {
                transform: translateY(-12px);
                box-shadow: 0 15px 35px rgba(211, 47, 47, 0.12);
                border-color: rgba(211, 47, 47, 0.1);
            }

            .feature-icon-box {
                width: 85px;
                height: 85px;
                background: linear-gradient(135deg, #fff1f1 0%, #ffebeb 100%);
                color: #d32f2f;
                /* Đỏ chủ đạo */
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto 25px;
                transition: all 0.4s ease;
            }

            /* Đảo ngược màu icon khi di chuột */
            .feature-card:hover .feature-icon-box {
                background: linear-gradient(135deg, #d32f2f 0%, #ff5252 100%);
                color: #ffffff;
                transform: scale(1.1) rotate(5deg);
                box-shadow: 0 10px 20px rgba(211, 47, 47, 0.25);
            }

            .feature-title {
                font-weight: 800;
                color: #2b2b2b;
                font-size: 1.15rem;
                margin-bottom: 10px;
            }

            .feature-desc {
                color: #777;
                font-size: 0.95rem;
                margin: 0;
            }
        </style>

        <div class="container-fluid feature-wrapper py-5">
            <div class="container py-5">
                <div class="row g-4">

                    <div class="col-md-6 col-lg-3">
                        <div class="feature-card text-center">
                            <div class="feature-icon-box">
                                <i class="fas fa-shipping-fast fa-2x"></i>
                            </div>
                            <div class="feature-content">
                                <h5 class="feature-title">Miễn Phí Vận Chuyển</h5>
                                <p class="feature-desc">Hỏa tốc trong 2h nội thành</p>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6 col-lg-3">
                        <div class="feature-card text-center">
                            <div class="feature-icon-box">
                                <i class="fas fa-shield-alt fa-2x"></i>
                            </div>
                            <div class="feature-content">
                                <h5 class="feature-title">Thanh Toán An Toàn</h5>
                                <p class="feature-desc">Bảo mật giao dịch 100%</p>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6 col-lg-3">
                        <div class="feature-card text-center">
                            <div class="feature-icon-box">
                                <i class="fas fa-sync fa-2x"></i>
                            </div>
                            <div class="feature-content">
                                <h5 class="feature-title">Đổi Trả 30 Ngày</h5>
                                <p class="feature-desc">Lỗi 1 đổi 1 miễn phí</p>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6 col-lg-3">
                        <div class="feature-card text-center">
                            <div class="feature-icon-box">
                                <i class="fas fa-headset fa-2x"></i>
                            </div>
                            <div class="feature-content">
                                <h5 class="feature-title">Hỗ Trợ 24/7</h5>
                                <p class="feature-desc">Tư vấn nhiệt tình tận tâm</p>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>