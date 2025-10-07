<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
    function toggleMenu(){
        const menu = document.getElementById("menu")
        menu.classList.toggle("hidden")
    }
</script>
<div class="top-bar">
    <form action="/search" method="get" class="search-box">
        <i class="fas fa-search"></i>
        <input type="text" name="keyword" placeholder="Tìm kiếm..." required>
    </form>

    <div class="user-info">
        <div class="notifications" id="notificationBell">
            <i class="fas fa-bell"></i>
            <span class="badge" id="notificationCount" style="display: none;">0</span>

            <!-- Dropdown thông báo -->
            <div class="notification-dropdown" id="notificationDropdown">
                <div class="notification-header">
                    <h6>Đơn hàng mới</h6>
                </div>
                <div class="notification-list" id="notificationList">
                    <div class="notification-loading">Đang tải...</div>
                </div>
                <div class="notification-footer">
                    <a href="/admin/bills">Xem tất cả</a>
                </div>
            </div>
        </div>
        <!-- Nếu chưa đăng nhập -->
        <c:if test="${empty sessionScope.user}">
            <div class="auth-buttons">
                <a href="${pageContext.request.contextPath}/Login" class="btn-login">Đăng nhập</a>
                <a href="${pageContext.request.contextPath}/DangKy" class="btn-register">Đăng ký</a>
            </div>
        </c:if>

        <!-- Nếu đã đăng nhập -->
        <c:if test="${not empty sessionScope.user}">
            <div class="user">
                <div class="icon" onclick="toggleMenu()">
                    <img src="/images/icons/user.png" alt="Menu Icon">
                    <span>${sessionScope.user.email}</span>
                </div>
                <div id="menu" class="menu hidden">
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/profile">Thông tin người dùng</a></li>
                        <li><a href="#">Thông báo</a></li>
                        <li><a href="${pageContext.request.contextPath}/Logout">Đăng xuất</a></li>
                    </ul>
                </div>
            </div>
        </c:if>
    </div>
</div>

<script>
// Cập nhật thông báo mỗi 30 giây
setInterval(updateNotifications, 30000);

// Cập nhật ngay khi tải trang
document.addEventListener('DOMContentLoaded', function() {
    updateNotifications();

    // Xử lý click vào chuông
    const notificationBell = document.getElementById('notificationBell');
    if (notificationBell) {
        notificationBell.addEventListener('click', function(e) {
            e.stopPropagation();
            toggleNotificationDropdown();
        });
    }

    // Đóng dropdown khi click ra ngoài
    document.addEventListener('click', function() {
        const dropdown = document.getElementById('notificationDropdown');
        if (dropdown) {
            dropdown.style.display = 'none';
        }
    });
});

function updateNotifications() {
    // Lấy số lượng thông báo
    fetch('/api/notifications/count')
        .then(response => response.json())
        .then(count => {
            const badge = document.getElementById('notificationCount');
            const bell = document.getElementById('notificationBell');

            if (badge) {
                badge.textContent = count;
                badge.style.display = count > 0 ? 'block' : 'none';
            }

            // Thêm animation khi có thông báo mới
            if (bell) {
                if (count > 0) {
                    bell.classList.add('has-notification');
                } else {
                    bell.classList.remove('has-notification');
                }
            }
        })
        .catch(error => console.error('Error updating notification count:', error));
}

function toggleNotificationDropdown() {
    const dropdown = document.getElementById('notificationDropdown');
    if (!dropdown) return;

    const isVisible = dropdown.style.display === 'block';

    if (!isVisible) {
        // Load danh sách thông báo
        loadNotificationList();
        dropdown.style.display = 'block';
    } else {
        dropdown.style.display = 'none';
    }
}

function loadNotificationList() {
    const listContainer = document.getElementById('notificationList');
    if (!listContainer) return;

    listContainer.innerHTML = '<div class="notification-loading">Đang tải...</div>';

   fetch('/api/notifications/new-orders')
    .then(res => res.json())
    .then(orders => {
        const html = orders.map(order => `
            <div class="notification-item" data-order-id="\${order.id}">
                <div><strong>Đơn hàng \${order.code}</strong></div>
                <div>Khách hàng: \${order.customer ? order.customer.name : 'Khách lẻ'}</div>
                <div>Số tiền: \${formatCurrency(order.amount)}</div>
                <div>Thời gian: \${formatTime(order.createDate)}</div>
            </div>
        `).join('');
        listContainer.innerHTML = html;
    })
        .catch(error => {
            console.error('Error loading notifications:', error);
            listContainer.innerHTML = '<div class="notification-empty">Lỗi khi tải thông báo</div>';
        });
}

var userRole = '${sessionScope.user != null ? sessionScope.user.role.name : ""}';

var contextPath = '${pageContext.request.contextPath}';

document.getElementById('notificationList').addEventListener('click', function(e) {
    const item = e.target.closest('.notification-item');
    if (item) {
        const orderId = item.getAttribute('data-order-id');
        if (userRole === 'ROLE_ADMIN' || userRole === 'ROLE_EMPLOYEE') {
            window.location.href = contextPath + '/admin/orders/' + orderId;
        } else {
            window.location.href = contextPath + '/orders/' + orderId;
        }
    }
});


function formatTime(dateString) {
    const date = new Date(dateString);
    if (isNaN(date)) return '';

    const now = new Date();
    const diff = now - date; // mili giây
    const minutes = Math.floor(diff / 60000);

    console.log("Date:", dateString, "Minutes ago:", minutes);

    if (minutes < 1) {
        return 'Vừa xong';
    } else if (minutes < 60) {
        return minutes + ' phút trước';
    } else if (minutes < 1440) {
        // Dùng Math.floor thay vì toFixed
        return Math.floor(minutes / 60) + ' giờ trước';
    } else {
        return date.toLocaleDateString('vi-VN');
    }
}


function formatCurrency(amount) {
    return new Intl.NumberFormat('vi-VN', {
        style: 'currency',
        currency: 'VND'
    }).format(amount);
}
</script>