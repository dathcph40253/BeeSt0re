<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
    function toggleMenu(){
        const menu = document.getElementById("menu")
        menu.classList.toggle("hidden")
    }
</script>
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