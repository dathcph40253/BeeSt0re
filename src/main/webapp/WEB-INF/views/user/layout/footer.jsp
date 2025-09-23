<%@page contentType="text/html" pageEncoding="UTF-8" %>

<style>
/* Bootstrap Footer Styles */
.custom-footer {
    background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%);
    color: white;
    margin-top: 50px;
    padding: 0;
    position: relative;
    overflow: hidden;
}

.custom-footer::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: 4px;
    background: linear-gradient(90deg, #667eea, #764ba2, #667eea);
}

.footer-brand {
    font-size: 2rem;
    font-weight: bold;
    color: #667eea !important;
    text-decoration: none;
    text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
    margin-bottom: 1rem;
    display: block;
}

.footer-description {
    color: #bdc3c7;
    font-size: 0.9rem;
    line-height: 1.6;
}

.footer-title {
    color: white;
    font-size: 1.1rem;
    font-weight: 600;
    margin-bottom: 1rem;
    padding-bottom: 0.5rem;
    border-bottom: 2px solid #667eea;
    position: relative;
}

.footer-title::after {
    content: '';
    position: absolute;
    bottom: -2px;
    left: 0;
    width: 30px;
    height: 2px;
    background: #764ba2;
}

.footer-link {
    color: #bdc3c7;
    text-decoration: none;
    font-size: 0.9rem;
    transition: all 0.3s ease;
    display: flex;
    align-items: center;
    padding: 0.3rem 0;
}

.footer-link:hover {
    color: #667eea;
    transform: translateX(5px);
}

.footer-link i {
    margin-right: 0.5rem;
    width: 16px;
    color: #667eea;
}



.newsletter-btn {
    background: linear-gradient(45deg, #667eea, #764ba2);
    border: none;
    border-radius: 25px;
    padding: 0.7rem 1.5rem;
    color: white;
    font-weight: 500;
    transition: all 0.3s ease;
}

.newsletter-btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
}

.social-icon {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    width: 40px;
    height: 40px;
    border-radius: 50%;
    color: white;
    text-decoration: none;
    margin-right: 0.5rem;
    transition: all 0.3s ease;
}

.social-icon:hover {
    transform: translateY(-3px);
    box-shadow: 0 4px 15px rgba(0,0,0,0.3);
}

.social-icon.facebook { background: linear-gradient(45deg, #3b5998, #4267B2); }
.social-icon.instagram { background: linear-gradient(45deg, #E4405F, #C13584); }
.social-icon.youtube { background: linear-gradient(45deg, #FF0000, #CC0000); }
.social-icon.tiktok { background: linear-gradient(45deg, #000000, #333333); }

.footer-bottom {
    background: rgba(0,0,0,0.3);
    border-top: 1px solid rgba(102, 126, 234, 0.3);
    padding: 1rem 0;
    margin-top: 2rem;
}

.payment-icon {
    font-size: 1.5rem;
    color: #667eea;
    margin-right: 0.5rem;
    transition: color 0.3s ease;
}

.payment-icon:hover {
    color: #764ba2;
}

@media (max-width: 768px) {
    .footer-brand {
        font-size: 1.5rem;
        text-align: center;
    }

    .footer-title {
        font-size: 1rem;
    }

    .social-icon {
        width: 35px;
        height: 35px;
    }
}
</style>

<footer class="custom-footer">
    <div class="container py-5">
        <div class="row g-4">
            <!-- Logo và mô tả -->
            <div class="col-lg-3 col-md-6">
                <a href="/" class="footer-brand">BeeStore</a>
                <p class="footer-description">
                    Cửa hàng thời trang uy tín với những sản phẩm chất lượng cao,
                    phong cách hiện đại và giá cả hợp lý.
                </p>
            </div>

            <!-- Thông tin liên hệ -->
            <div class="col-lg-3 col-md-6">
                <h5 class="footer-title">
                    <i class="fas fa-address-book me-2"></i>
                    LIÊN HỆ
                </h5>
                <div class="d-flex flex-column">
                    <a href="#" class="footer-link">
                        <i class="fas fa-map-marker-alt"></i>
                        110 Trần Phú, Hà Đông, Hà Nội
                    </a>
                    <a href="tel:0968862222" class="footer-link">
                        <i class="fas fa-phone"></i>
                        Hotline: 0968862222
                    </a>
                    <a href="mailto:khoaivutien2k3@gmail.com" class="footer-link">
                        <i class="fas fa-envelope"></i>
                        khoaivutien2k3@gmail.com
                    </a>
                    <a href="#" class="footer-link">
                        <i class="fas fa-clock"></i>
                        Thứ 2 - CN: 8:00 - 22:00
                    </a>
                </div>
            </div>

            <!-- Chính sách -->
            <div class="col-lg-3 col-md-6">
                <h5 class="footer-title">
                    <i class="fas fa-shield-alt me-2"></i>
                    CHÍNH SÁCH
                </h5>
                <div class="d-flex flex-column">
                    <a href="/policy/member" class="footer-link">
                        <i class="fas fa-user-check"></i>
                        Chính sách thành viên
                    </a>
                    <a href="/policy/return" class="footer-link">
                        <i class="fas fa-undo"></i>
                        Chính sách đổi trả
                    </a>
                    <a href="/policy/shipping" class="footer-link">
                        <i class="fas fa-shipping-fast"></i>
                        Chính sách vận chuyển
                    </a>
                    <a href="/policy/privacy" class="footer-link">
                        <i class="fas fa-lock"></i>
                        Chính sách bảo mật
                    </a>
                </div>
            </div>

            <!-- Đăng ký nhận tin -->
            <div class="col-lg-3 col-md-6">
                <h5 class="footer-title">
                    <i class="fas fa-bell me-2"></i>
                    ĐĂNG KÝ NHẬN TIN
                </h5>
                <p class="footer-description mb-3">
                    Nhận thông tin về sản phẩm mới và ưu đãi đặc biệt
                </p>
                <form class="mb-3">
                    <div class="input-group mb-2">
                        <input type="email" class="form-control"
                               placeholder="Nhập email của bạn..." required
                               style="border-radius: 25px 0 0 25px; padding: 0.7rem 1rem;">
                        <button class="btn newsletter-btn" type="submit"
                                style="border-radius: 0 25px 25px 0;">
                            <i class="fas fa-paper-plane"></i>
                        </button>
                    </div>
                </form>

                <!-- Mạng xã hội -->
                <div>
                    <h6 class="text-white mb-2">Kết nối với chúng tôi</h6>
                    <div class="d-flex">
                        <a href="#" class="social-icon facebook">
                            <i class="fab fa-facebook-f"></i>
                        </a>
                        <a href="#" class="social-icon instagram">
                            <i class="fab fa-instagram"></i>
                        </a>
                        <a href="#" class="social-icon youtube">
                            <i class="fab fa-youtube"></i>
                        </a>
                        <a href="#" class="social-icon tiktok">
                            <i class="fab fa-tiktok"></i>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer bottom -->
    <div class="footer-bottom">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <p class="mb-0 text-center text-md-start">
                        © 2024 BeeStore. Tất cả quyền được bảo lưu.
                    </p>
                </div>
                <div class="col-md-6">
                    <div class="text-center text-md-end">
                        <span class="me-3">Phương thức thanh toán:</span>
                        <i class="fab fa-cc-visa payment-icon"></i>
                        <i class="fab fa-cc-mastercard payment-icon"></i>
                        <i class="fas fa-money-bill payment-icon"></i>
                        <i class="fas fa-mobile-alt payment-icon"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
</footer>
<!-- Thêm cuối file -->
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

