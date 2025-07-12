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
            <li class="${pageContext.request.requestURI.contains('/Home') || pageContext.request.requestURI == '/' ? 'active' : ''}">
                <a href="/Home"><i class="fas fa-home"></i><span>Trang chủ</span></a>
            </li>
            <li class="${pageContext.request.requestURI.contains('/product') ? 'active' : ''}">
                <a href="/product"><i class="fas fa-box"></i><span>Sản phẩm</span></a>
            </li>
            <li class="${pageContext.request.requestURI.contains('/admin/order') ? 'active' : ''}">
                <a href="/admin/order"><i class="fas fa-shopping-cart"></i><span>Đơn hàng</span></a>
            </li>

            <!-- Chỉ hiện với EMPLOYEE hoặc ADMIN -->
            <c:if test="${user.role.name == 'ROLE_EMPLOYEE' || user.role.name == 'ROLE_ADMIN'}">
                <li class="${pageContext.request.requestURI.contains('/Category') ? 'active' : ''}">
                    <a href="/Category"><i class="fas fa-tags"></i><span>Quản lí danh mục</span></a>
                </li>
                <li class="${pageContext.request.requestURI.contains('/Color') ? 'active' : ''}">
                    <a href="/Color"><i class="fas fa-palette"></i><span>Quản lí màu sắc</span></a>
                </li>
                <li class="${pageContext.request.requestURI.contains('/Size') ? 'active' : ''}">
                    <a href="/Size"><i class="fas fa-ruler"></i><span>Quản lí kích thước</span></a>
                </li>
                <li class="${pageContext.request.requestURI.contains('/Brand') ? 'active' : ''}">
                    <a href="/Brand"><i class="fas fa-trademark"></i><span>Quản lí thương hiệu</span></a>
                </li>
                <li class="${pageContext.request.requestURI.contains('/Material') ? 'active' : ''}">
                    <a href="/Material"><i class="fas fa-tshirt"></i><span>Quản lí chất liệu</span></a>
                </li>
            </c:if>

            <!-- Chỉ hiện với ADMIN -->
            <c:if test="${user.role.name == 'ROLE_ADMIN'}">
                <li class="${pageContext.request.requestURI.contains('/admin/account') ? 'active' : ''}">
                    <a href="/admin/account"><i class="fas fa-users"></i><span>Tài khoản</span></a>
                </li>
                <li class="${pageContext.request.requestURI.contains('/admin/ProductDiscount') ? 'active' : ''}">
                    <a href="/admin/ProductDiscount"><i class="fas fa-users"></i><span>Giảm giá</span></a>
                </li>
                <li class="${pageContext.request.requestURI.contains('/admin/Discount') ? 'active' : ''}">
                    <a href="/admin/Discount"><i class="fas fa-users"></i><span>Mã giảm giá</span></a>
                </li>
                <li class="${pageContext.request.requestURI.contains('/admin/report') ? 'active' : ''}">
                    <a href="/admin/report"><i class="fas fa-chart-bar"></i><span>Báo cáo</span></a>
                </li>
            </c:if>
        </ul>
    </nav>
</div>
