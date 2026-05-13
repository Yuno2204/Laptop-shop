<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <style>
            /* Custom UI cho Hero Banner - Tông Đỏ LongHang Mobile */
            .hero-wrapper {
                background: linear-gradient(135deg, #fff1f1 0%, #ffffff 100%);
                position: relative;
                overflow: hidden;
                border-bottom: 1px solid #ffebeb;
            }

            /* Hiệu ứng mờ ảo phía sau (Blur blobs) */
            .hero-wrapper::before {
                content: '';
                position: absolute;
                width: 400px;
                height: 400px;
                background: rgba(211, 47, 47, 0.05);
                border-radius: 50%;
                top: -100px;
                left: -100px;
                filter: blur(60px);
                z-index: 0;
            }

            .hero-content {
                position: relative;
                z-index: 1;
            }

            /* Gradient Text Đỏ */
            .text-gradient-red {
                background: linear-gradient(90deg, #d32f2f, #ff1744);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                font-weight: 900;
            }

            /* Nút bấm Custom */
            .btn-red-gradient {
                background: linear-gradient(45deg, #d32f2f, #ff5252);
                color: white !important;
                border: none;
                transition: all 0.3s ease;
            }

            .btn-red-gradient:hover {
                transform: translateY(-3px);
                box-shadow: 0 10px 20px rgba(211, 47, 47, 0.3);
            }

            .btn-outline-red {
                border: 2px solid #d32f2f;
                color: #d32f2f;
                font-weight: 600;
                background: transparent;
                transition: all 0.3s;
            }

            .btn-outline-red:hover {
                background: #d32f2f;
                color: white;
            }

            /* Carousel Custom */
            .carousel-custom-frame {
                border-radius: 30px;
                box-shadow: 0 30px 60px rgba(0, 0, 0, 0.08);
                border: 6px solid white;
                background-color: #fff;
            }

            /* Hiệu ứng lơ lửng cho ảnh trong slider */
            .floating-img {
                animation: float 4s ease-in-out infinite;
            }

            @keyframes float {
                0% {
                    transform: translateY(0px);
                }

                50% {
                    transform: translateY(-15px);
                }

                100% {
                    transform: translateY(0px);
                }
            }

            /* Trust badges (Yếu tố tâm lý UX) */
            .trust-badges {
                font-size: 0.9rem;
                color: #555;
            }

            .trust-badges i {
                color: #28a745;
            }
        </style>

        <div class="container-fluid py-5 mb-5 hero-wrapper">
            <div class="container py-5 hero-content">
                <div class="row g-5 align-items-center">

                    <div class="col-md-12 col-lg-7">
                        <br>

                        <h1 class="mb-4 display-3 fw-bolder text-dark" style="line-height: 1.25;">
                            Đỉnh Cao Công Nghệ <br />
                            <span class="text-gradient-red">Giá Rẻ Vô Địch</span>
                        </h1>

                        <p class="mb-5 fs-5 text-secondary" style="max-width: 90%;">
                            Khám phá bộ sưu tập công nghệ mới nhất tại LongHang Mobile. Từ Flagship thời thượng đến phụ
                            kiện cao cấp, mua sắm thông minh - nâng tầm trải nghiệm của bạn!
                        </p>

                        <div class="d-flex align-items-center gap-3 flex-wrap mb-4">
                            <a href="/products" class="btn btn-red-gradient px-5 py-3 rounded-pill fw-bold shadow-sm">
                                <i class="fas fa-shopping-cart me-2"></i> Mua Sắm Ngay
                            </a>
                            <a href="#khuyen-mai" class="btn btn-outline-red px-4 py-3 rounded-pill shadow-sm">
                                <i class="fas fa-fire me-2"></i> Xem Khuyến Mãi
                            </a>
                        </div>

                        <div class="trust-badges d-flex gap-4 fw-medium mt-2">
                            <span><i class="fas fa-check-circle me-1"></i> Freeship toàn quốc</span>
                            <span><i class="fas fa-check-circle me-1"></i> Trả góp 0%</span>
                            <span><i class="fas fa-check-circle me-1"></i> Lỗi 1 đổi 1</span>
                        </div>
                    </div>

                    <div class="col-md-12 col-lg-5">
                        <div id="carouselId"
                            class="carousel slide carousel-fade position-relative carousel-custom-frame overflow-hidden"
                            data-bs-ride="carousel" data-bs-interval="4000">

                            <div class="carousel-indicators mb-2">
                                <button type="button" data-bs-target="#carouselId" data-bs-slide-to="0"
                                    class="active bg-danger" aria-current="true" aria-label="Slide 1"></button>
                                <button type="button" data-bs-target="#carouselId" data-bs-slide-to="1"
                                    class="bg-danger" aria-label="Slide 2"></button>
                                <button type="button" data-bs-target="#carouselId" data-bs-slide-to="2"
                                    class="bg-danger" aria-label="Slide 3"></button>
                            </div>

                            <div class="carousel-inner" role="listbox">
                                <div class="carousel-item active p-4">
                                    <img src="/client/img/hero-img-1.png"
                                        class="img-fluid w-100 object-fit-contain floating-img" style="height: 350px;"
                                        alt="Gaming">
                                    <span
                                        class="position-absolute top-0 end-0 m-3 badge bg-danger px-3 py-2 fs-6 rounded-pill shadow-sm">
                                        <i class="fas fa-gamepad me-1"></i> Gaming
                                    </span>
                                </div>

                                <div class="carousel-item p-4">
                                    <img src="/client/img/hero-img-3.png"
                                        class="img-fluid w-100 object-fit-contain floating-img" style="height: 350px;"
                                        alt="Laptop">
                                    <span
                                        class="position-absolute top-0 end-0 m-3 badge bg-dark px-3 py-2 fs-6 rounded-pill shadow-sm">
                                        <i class="fas fa-laptop me-1"></i> Laptop Pro
                                    </span>
                                </div>

                                <div class="carousel-item p-4">
                                    <img src="/client/img/hero-img-2.png"
                                        class="img-fluid w-100 object-fit-contain floating-img" style="height: 350px;"
                                        alt="Phụ kiện">
                                    <span class="position-absolute top-0 end-0 m-3 badge"
                                        style="background: #e91e63; padding: .5rem 1rem; font-size: 1rem; border-radius: 50rem; box-shadow: 0 .125rem .25rem rgba(0,0,0,.075);">
                                        <i class="fas fa-headphones-alt me-1"></i> Âm Thanh
                                    </span>
                                </div>
                            </div>

                            <button class="carousel-control-prev" type="button" data-bs-target="#carouselId"
                                data-bs-slide="prev" style="width: 10%;">
                                <span class="carousel-control-prev-icon bg-danger rounded-circle p-2 shadow-sm"
                                    aria-hidden="true" style="width: 2rem; height: 2rem;"></span>
                                <span class="visually-hidden">Previous</span>
                            </button>
                            <button class="carousel-control-next" type="button" data-bs-target="#carouselId"
                                data-bs-slide="next" style="width: 10%;">
                                <span class="carousel-control-next-icon bg-danger rounded-circle p-2 shadow-sm"
                                    aria-hidden="true" style="width: 2rem; height: 2rem;"></span>
                                <span class="visually-hidden">Next</span>
                            </button>
                        </div>
                    </div>

                </div>
            </div>
        </div>