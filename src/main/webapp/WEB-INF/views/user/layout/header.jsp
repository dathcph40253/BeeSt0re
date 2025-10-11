<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
.custom-header {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    padding: 0.8rem 0;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    position: relative;
    z-index: 10;
}

.logo-brand {
    font-size: 1.8rem;
    font-weight: bold;
    color: white !important;
    text-decoration: none;
    text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
}

/* Ô tìm kiếm */
.search-box {
    width: 400px;
    position: relative;
    display: flex;
    align-items: center;
    border: 1px solid #ddd;
    border-radius: 30px;
    padding: 5px 10px;
    background-color: #fff;
}

.search-box input {
    flex: 1;
    border: none;
    outline: none;
    padding: 8px 12px;
    border-radius: 30px;
    font-size: 14px;
}

.search-box button {
    background: none;
    border: none;
    cursor: pointer;
    color: #555;
    font-size: 16px;
}


/* Icon buttons */
.icon-btn {
    position: relative;
    color: white;
    font-size: 1.3rem;
    margin-left: 15px;
    transition: all 0.3s ease;
    border-radius: 50%;
    padding: 0.5rem;
    cursor: pointer;
    background: transparent;
}

.icon-btn:hover {
    background: rgba(255,255,255,0.2);
    transform: scale(1.1);
}

/* Badge tròn đỏ */
.badge-icon {
    position: absolute;
    top: 5px;
    right: 5px;
    background: #ff4757;
    color: white;
    border-radius: 50%;
    width: 18px;
    height: 18px;
    font-size: 0.7rem;
    display: flex;
    align-items: center;
    justify-content: center;
}

/* Dropdown menu (Bootstrap) */
.dropdown-menu {
    border-radius: 10px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    padding: 10px;
    min-width: 280px;
    animation: fadeIn 0.2s ease-in-out;
}

@keyframes fadeIn {
    from { opacity: 0; transform: translateY(-10px); }
    to { opacity: 1; transform: translateY(0); }
}

/* Danh sách thông báo */
.dropdown-header {
    background: #f2f2f2;
    border-radius: 8px;
    padding: 8px;
}

.notification-loading {
    text-align: center;
    padding: 10px;
    font-size: 0.9rem;
    color: #888;
}

/* Link xem tất cả */
.dropdown-menu a.text-secondary {
    font-size: 0.9rem;
    transition: 0.2s;
}

.dropdown-menu a.text-secondary:hover {
    color: #764ba2 !important;
    text-decoration: underline;
}

/* User dropdown */
.dropdown-toggle {
    color: white !important;
    text-decoration: none;
}
</style>

<header class="custom-header">
    <div class="container d-flex align-items-center justify-content-between flex-wrap gap-2">
        
        <!-- Logo -->
        <a class="logo-brand" href="/">BeeStore</a>

        <!-- Ô tìm kiếm -->
        <form action="/product" method="get" class="search-box mx-auto">
            <input type="text" name="keyword" placeholder="Tìm kiếm sản phẩm..."
                value="${keyword != null ? keyword : ''}">
            <button type="submit" class="btn btn-light">
                <i class="fas fa-search"></i>
            </button>
        </form>


        <!-- Khu vực icon bên phải -->
        <div class="d-flex align-items-center">

            <!-- Nút thông báo -->
            <div class="dropdown me-3">
                <a href="#" class="icon-btn dropdown-toggle" id="notificationToggle" data-bs-toggle="dropdown" aria-expanded="false">
                    <i class="fas fa-bell"></i>
                    <span class="badge-icon" id="orderNotifyCount">0</span>
                </a>

                <!-- Danh sách thông báo -->
                <ul class="dropdown-menu dropdown-menu-end p-2 shadow-lg" aria-labelledby="notificationToggle" style="min-width: 300px;">
                    <li class="dropdown-header text-center fw-bold text-primary">Thông báo đơn hàng</li>
                    <li><hr class="dropdown-divider"></li>
                    <li id="notificationList">
                        <div class="notification-loading text-center text-muted">Đang tải...</div>
                    </li>
                    <li><hr class="dropdown-divider"></li>
                    <li class="text-center">
                        <a href="/orders" class="text-decoration-none fw-semibold text-secondary">Xem tất cả đơn hàng</a>
                    </li>
                </ul>
            </div>



            <!-- Nút giỏ hàng -->
            <a href="/cart" class="icon-btn">
                <i class="fas fa-shopping-cart"></i>
                <c:if test="${not empty sessionScope.user}">
                    <span class="badge-icon" id="cartCount">0</span>
                </c:if>
            </a>

            <!-- Tài khoản -->
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <div class="dropdown">
                        <a href="#" class="dropdown-toggle d-flex align-items-center" role="button" data-bs-toggle="dropdown">
                            <i class="fas fa-user ms-2"></i>
                            <span class="d-none d-md-inline ms-2">${sessionScope.user.email}</span>
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
                    <a href="/Login" class="icon-btn">
                        <i class="fas fa-user"></i>
                    </a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</header>

<script>
// Khi trang đã load xong
document.addEventListener('DOMContentLoaded', function() {
    updateCartCount();
    updateOrderNotification();
    setupNotificationDropdown(); // chuẩn tên hơn
});

// 🛒 Cập nhật số lượng giỏ hàng
function updateCartCount() {
    const cartBadge = document.getElementById('cartCount');
    if (!cartBadge) return;
    fetch('/cart/count')
        .then(res => res.text())
        .then(count => {
            cartBadge.textContent = count;
            cartBadge.style.display = parseInt(count) > 0 ? 'flex' : 'none';
        })
        .catch(() => cartBadge.style.display = 'none');
}

// 🔔 Cập nhật số lượng đơn hàng mới (số đỏ trên chuông)
function updateOrderNotification() {
    const notifyBadge = document.getElementById('orderNotifyCount');
    if (!notifyBadge) return;
    fetch('/orders/new/count')
        .then(res => res.text())
        .then(count => {
            notifyBadge.textContent = count;
            notifyBadge.style.display = parseInt(count) > 0 ? 'flex' : 'none';
        })
        .catch(() => notifyBadge.style.display = 'none');
}

// 📋 Xử lý dropdown thông báo
function setupNotificationDropdown() {
    const bell = document.getElementById('notificationToggle');
    const listContainer = document.getElementById('notificationList');
    if (!bell || !listContainer) return;

    bell.addEventListener('click', function() {
        listContainer.innerHTML = '<div class="notification-loading">Đang tải...</div>';

        // ✅ Gọi đúng API bạn có
        fetch('/api/notifications/new-orders')
            .then(res => res.json())
            .then(orders => {
                if (!orders || orders.length === 0) {
                    listContainer.innerHTML = '<div class="text-center text-muted py-2">Không có thông báo mới</div>';
                    return;
                }

                // ✅ Tạo HTML và gán vào danh sách
                const html = orders.map(o => `
                    <div class="notification-item p-2 border-bottom small" data-order-id="\${o.id}" style="cursor:pointer;">
                        <i class="fas fa-box-open me-2 text-primary"></i>
                        Đơn hàng <strong>\${o.code || 'Chưa có mã'}</strong> của bạn \${getOrderStatusText(o.status)}
                    </div>
                `).join('');
                listContainer.innerHTML = html;
            })
            .catch(() => {
                listContainer.innerHTML = '<div class="text-center text-danger py-2">Lỗi khi tải thông báo</div>';
            });
    });

    // Khi click vào từng item
    listContainer.addEventListener('click', function(e) {
        const item = e.target.closest('.notification-item');
        if (!item) return;
        const orderId = item.getAttribute('data-order-id');
        const userRole = '${sessionScope.user != null ? sessionScope.user.role.name : ""}';
        const contextPath = '${pageContext.request.contextPath}';
        if (userRole === 'ROLE_ADMIN' || userRole === 'ROLE_EMPLOYEE') {
            window.location.href = contextPath + '/admin/orders/' + orderId;
        } else {
            window.location.href = contextPath + '/orders/' + orderId;
        }
    });
}

// ✅ Trạng thái hiển thị
function getOrderStatusText(status) {
    switch (status) {
        case 'PENDING': return 'đang chờ xác nhận';
        case 'CONFIRMED': return 'đã được xác nhận';
        case 'PROCESSING': return 'đang được xử lý';
        case 'SHIPPING': return 'đang được giao';
        case 'DELIVERED': return 'đã giao thành công';
        case 'CANCELLED': return 'đã bị hủy';
        default: return 'có cập nhật mới';
    }
}
</script>



