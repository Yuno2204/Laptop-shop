<%@page contentType="text/html" pageEncoding="UTF-8" %>

    <style>
        /* UX/UI Footer Cao Cấp */
        .footer-custom {
            background-color: #ffffff;
            border-top: 1px solid #edf2f9;
            padding: 1.5rem 0;
            box-shadow: 0 -5px 20px rgba(0, 0, 0, 0.02);
        }

        .footer-text {
            color: #a1a5b7;
            font-weight: 500;
            font-size: 0.9rem;
        }

        .footer-link {
            color: #a1a5b7;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 6px 12px;
            border-radius: 8px;
            background: #f8f9fa;
        }

        .footer-link:hover {
            color: #009ef7;
            background: rgba(0, 158, 247, 0.08);
            transform: translateY(-2px);
        }
    </style>

    <footer class="mt-auto footer-custom">
        <div class="container-fluid px-4">
            <div class="d-flex flex-column flex-md-row align-items-center justify-content-between small">
                <div class="footer-text mb-2 mb-md-0">
                    Bản quyền &copy; <span class="fw-bold" style="color: #3f4254;">Đinh Quang Đức</span> 2026. Thiết kế
                    bằng <i class="fas fa-heart text-danger mx-1"></i>
                </div>
                <div class="d-flex gap-3">
                    <a href="https://www.facebook.com/cenlove.2204" target="_blank" class="footer-link">
                        <i class="fab fa-facebook-f text-primary"></i> Facebook
                    </a>
                    <a href="https://github.com/Yuno2204" target="_blank" class="footer-link">
                        <i class="fab fa-github text-dark"></i> Github
                    </a>
                </div>
            </div>
        </div>
    </footer>