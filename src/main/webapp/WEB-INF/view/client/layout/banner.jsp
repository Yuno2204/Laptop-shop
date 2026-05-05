<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <div class="container-fluid py-5 mb-5 hero-header">
            <div class="container py-5">
                <div class="row g-5 align-items-center">

                    <div class="col-md-12 col-lg-7">
                        <span class="badge bg-warning text-dark rounded-pill px-3 py-2 mb-3 shadow-sm"
                            style="font-size: 1rem;">
                            <i class="fas fa-shield-check me-1"></i> 100% Sản Phẩm Chính Hãng
                        </span>

                        <h1 class="mb-4 display-3 fw-bolder text-primary" style="line-height: 1.2;">
                            Hàng Cao Cấp <br />
                            <span class="text-secondary">Rẻ Vô Địch</span>
                        </h1>

                        <p class="mb-4 fs-5 text-muted">
                            Khám phá bộ sưu tập công nghệ mới nhất từ điện thoại, laptop đến phụ kiện xịn sò. Mua sắm
                            thông minh, nâng tầm trải nghiệm!
                        </p>

                        <div class="d-flex align-items-center gap-3">
                            <a href="/products"
                                class="btn btn-primary px-5 py-3 rounded-pill text-white shadow fw-bold transition-all">
                                <i class="fas fa-shopping-cart me-2"></i> Mua Sắm Ngay
                            </a>
                            <a href="/contact"
                                class="btn btn-outline-secondary px-5 py-3 rounded-pill shadow-sm fw-bold transition-all">
                                Liên Hệ
                            </a>
                        </div>
                    </div>

                    <div class="col-md-12 col-lg-5">
                        <div id="carouselId"
                            class="carousel slide carousel-fade position-relative shadow-lg rounded-4 overflow-hidden"
                            data-bs-ride="carousel">
                            <div class="carousel-inner" role="listbox">

                                <div class="carousel-item active">
                                    <img src="/client/img/hero-img-1.png"
                                        class="img-fluid w-100 h-100 object-fit-cover bg-light" alt="Gaming">
                                    <span
                                        class="position-absolute top-0 end-0 m-3 badge bg-danger px-4 py-2 fs-6 rounded-pill shadow">
                                        <i class="fas fa-gamepad me-1"></i> Gaming
                                    </span>
                                </div>

                                <div class="carousel-item">
                                    <img src="/client/img/hero-img-3.png"
                                        class="img-fluid w-100 h-100 object-fit-cover bg-light" alt="Laptop">
                                    <span
                                        class="position-absolute top-0 end-0 m-3 badge bg-info text-dark px-4 py-2 fs-6 rounded-pill shadow">
                                        <i class="fas fa-laptop me-1"></i> Laptop
                                    </span>
                                </div>

                                <div class="carousel-item">
                                    <img src="/client/img/hero-img-2.png"
                                        class="img-fluid w-100 h-100 object-fit-cover bg-light" alt="Phụ kiện">
                                    <span
                                        class="position-absolute top-0 end-0 m-3 badge bg-success px-4 py-2 fs-6 rounded-pill shadow">
                                        <i class="fas fa-headphones-alt me-1"></i> Phụ Kiện
                                    </span>
                                </div>
                            </div>

                            <button class="carousel-control-prev" type="button" data-bs-target="#carouselId"
                                data-bs-slide="prev">
                                <span class="carousel-control-prev-icon bg-dark rounded-circle p-3 shadow"
                                    aria-hidden="true"></span>
                                <span class="visually-hidden">Previous</span>
                            </button>
                            <button class="carousel-control-next" type="button" data-bs-target="#carouselId"
                                data-bs-slide="next">
                                <span class="carousel-control-next-icon bg-dark rounded-circle p-3 shadow"
                                    aria-hidden="true"></span>
                                <span class="visually-hidden">Next</span>
                            </button>
                        </div>
                    </div>

                </div>
            </div>
        </div>