<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="sidebar">
    <div class="logo">
        <img src="/images/logo/Group.png" alt="Logo">
        <h2>Admin Page</h2>
    </div>
    <nav>
        <ul>
            <!-- Mục chung cho mọi role -->
            <li><a href="/Home"><i class="fas fa-home"></i><span>Trang chủ</span></a></li>
            <li><a href="/product"><i class="fas fa-box"></i><span>Sản phẩm</span></a></li>
            <li><a href="/admin/order"><i class="fas fa-shopping-cart"></i><span>Đơn hàng</span></a></li>
            <li><a href="/profile"><i class="fas fa-users"></i><span>Khách hàng</span></a></li>

            <!-- Chỉ hiện với EMPLOYEE hoặc ADMIN -->
            <c:if test="${user.role.name == 'ROLE_EMPLOYEE' || user.role.name == 'ROLE_ADMIN'}">
                <li><a href="/Category"><i class="fas fa-tags"></i><span>Danh mục</span></a></li>
                <li><a href="/Color"><i class="fas fa-tags"></i><span>Màu sắc</span></a></li>
                <li><a href="/Size"><i class="fas fa-tags"></i><span>Kích thước</span></a></li>
                <li><a href="/Brand"><i class="fas fa-tags"></i><span>Thương hiệu</span></a></li>
                <li><a href="/Material"><i class="fas fa-tags"></i><span>Chất liệu</span></a></li>
            </c:if>

            <!-- Chỉ hiện với ADMIN -->
            <c:if test="${user.role.name == 'ROLE_ADMIN'}">
                <li><a href="/admin/User"><i class="fas fa-tags"></i><span>Tài khoản</span></a></li>
                <li><a href="/report"><i class="fas fa-chart-bar"></i><span>Báo cáo</span></a></li>
            </c:if>
        </ul>
    </nav>
</div>
