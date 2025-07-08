<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="top-bar">
    <div class="search-box">
        <i class="fas fa-search"></i>
        <input type="text" placeholder="Tìm kiếm...">
    </div>
    <div class="user-info">
        <div class="notifications">
            <i class="fas fa-bell"></i>
            <span class="badge">3</span>
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
                <img src="/images/icons/user.png" alt="User">
                <span>${sessionScope.user.email}</span>
                <a href="${pageContext.request.contextPath}/Logout" style="margin-left: 10px;">Đăng xuất</a>
            </div>
        </c:if>
    </div>
</div>