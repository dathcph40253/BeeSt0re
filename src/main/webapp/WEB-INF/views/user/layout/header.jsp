<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
.custom-header {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    padding: 1rem 0;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
}

.logo-brand {
    font-size: 1.8rem;
    font-weight: bold;
    color: white !important;
    text-decoration: none;
    text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
}

.nav-link-custom {
    color: white !important;
    font-weight: 500;
    margin: 0 0.5rem;
    padding: 0.5rem 1rem !important;
    border-radius: 25px;
    transition: all 0.3s ease;
}

.nav-link-custom:hover {
    background: rgba(255,255,255,0.2);
    transform: translateY(-2px);
}

.user-dropdown .dropdown-toggle {
    color: white !important;
    text-decoration: none;
    padding: 0.5rem;
    border-radius: 20px;
    transition: all 0.3s ease;
}

.user-dropdown .dropdown-toggle:hover {
    background: rgba(255,255,255,0.2);
}

.cart-icon {
    position: relative;
    color: white;
    font-size: 1.2rem;
    padding: 0.5rem;
    border-radius: 50%;
    transition: all 0.3s ease;
}

.cart-icon:hover {
    background: rgba(255,255,255,0.2);
    transform: scale(1.1);
}

.cart-badge {
    position: absolute;
    top: -5px;
    right: -5px;
    background: #ff4757;
    color: white;
    border-radius: 50%;
    width: 20px;
    height: 20px;
    font-size: 0.7rem;
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: bold;
}

.search-icon {
    color: white;
    font-size: 1.2rem;
    padding: 0.5rem;
    border-radius: 50%;
    transition: all 0.3s ease;
    cursor: pointer;
}

.search-icon:hover {
    background: rgba(255,255,255,0.2);
    transform: scale(1.1);
}
</style>

<header class="custom-header">
    <div class="container">
        <nav class="navbar navbar-expand-lg">
            <a class="logo-brand" href="/">BeeStore</a>

            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav mx-auto">
                    <li class="nav-item">
                        <a class="nav-link nav-link-custom" href="/">HOME</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link nav-link-custom" href="/product?categoryId=1">TOP</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link nav-link-custom" href="/product?categoryId=2">BOTTOM</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link nav-link-custom" href="/product?categoryId=3">ACCESSORIES</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link nav-link-custom" href="/product?status=sale">SALE</a>
                    </li>
                </ul>

                <div class="d-flex align-items-center">
                    <!-- User Menu -->
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <div class="dropdown user-dropdown me-3">
                                <a href="#" class="dropdown-toggle d-flex align-items-center" role="button" data-bs-toggle="dropdown">
                                    <i class="fas fa-user me-2"></i>
                                    <span class="d-none d-md-inline">${sessionScope.user.email}</span>
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <li><a class="dropdown-item" href="/orders"><i class="fas fa-shopping-bag me-2"></i>Đơn hàng của tôi</a></li>
                                    <li><a class="dropdown-item" href="/profile"><i class="fas fa-user-edit me-2"></i>Thông tin cá nhân</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href="/Logout"><i class="fas fa-sign-out-alt me-2"></i>Đăng xuất</a></li>
                                </ul>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <a href="/Login" class="cart-icon me-3">
                                <i class="fas fa-user"></i>
                            </a>
                        </c:otherwise>
                    </c:choose>

                    <!-- Cart -->
                    <a href="/cart" class="cart-icon me-3">
                        <i class="fas fa-shopping-cart"></i>
                        <c:if test="${not empty sessionScope.user}">
                            <span class="cart-badge" id="cartCount">0</span>
                        </c:if>
                    </a>

                    <!-- Search -->
                    <div class="search-icon">
                        <i class="fas fa-search"></i>
                    </div>
                </div>
            </div>
        </nav>
    </div>
</header>

<script>
// Cập nhật số lượng giỏ hàng khi tải trang
document.addEventListener('DOMContentLoaded', function() {
    updateCartCount();
});

function updateCartCount() {
    const cartBadge = document.getElementById('cartCount');
    if (cartBadge) {
        fetch('/cart/count')
        .then(response => response.text())
        .then(count => {
            cartBadge.textContent = count;
            if (parseInt(count) > 0) {
                cartBadge.style.display = 'flex';
            } else {
                cartBadge.style.display = 'none';
            }
        })
        .catch(error => {
            console.log('Error updating cart count:', error);
        });
    }
}
</script>
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

