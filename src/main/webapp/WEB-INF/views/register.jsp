<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<head>
    <title>Đăng kí tài khoản</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            padding: 40px 0;
        }
        .register-form {
            max-width: 600px;
            margin: auto;
            padding: 30px;
            border-radius: 10px;
            background-color: #fff;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
        }
        .required-field::after {
            content: " *";
            color: red;
        }
        .message-top-right {
            position: fixed;
            top: 24px;
            right: 32px;
            background: #ffe0e0;
            color: #d8000c;
            padding: 10px 24px;
            border-radius: 8px;
            box-shadow: 0 2px 8px #bbb;
            font-weight: bold;
            z-index: 9999;
        }
    </style>
</head>
<body>
<c:if test="${not empty message}">
    <div id="message" class="message-top-right">${message}</div>
    <script>
        window.onload = function () {
            const x = document.getElementById("message");
            if(x){
                setTimeout(() => {
                    x.style.display = "none";
                }, 2000);
            }
        }
    </script>
</c:if>
<div class="container">
    <div class="register-form">
        <h2 class="text-center mb-4">Đăng kí tài khoản</h2>

        <form:form modelAttribute="RegistDto" action="/BeeStore/DangKy" method="post">

            <!-- Email (dùng làm tên đăng nhập) -->
            <div class="mb-3">
                <label for="email" class="form-label required-field">Email (Tài khoản):</label>
                <form:input path="email" cssClass="form-control" id="email"/>
                <form:errors path="email" cssClass="text-danger"/>
            </div>

            <!-- Mật khẩu -->
            <div class="mb-3">
                <label for="password" class="form-label required-field">Mật khẩu:</label>
                <form:password path="password" cssClass="form-control" id="password"/>
                <form:errors path="password" cssClass="text-danger"/>
            </div>

            <!-- Ngày sinh -->
            <div class="mb-3">
                <label for="birthDay" class="form-label">Ngày sinh:</label>
                <form:input path="birthDay" type="datetime-local" cssClass="form-control" id="birthDay"/>
            </div>

            <!-- Vai trò -->
            <div class="mb-3">
                <label for="roleId" class="form-label">Vai trò:</label>
                <form:select path="roleId" cssClass="form-select" id="roleId">
                    <form:option value="">-- Chọn vai trò --</form:option>
                    <form:option value="1">Admin</form:option>
                    <form:option value="2">Nhân viên</form:option>
                    <form:option value="3">Người dùng</form:option>
                </form:select>
            </div>

            <!-- Trạng thái tài khoản -->
            <div class="mb-3">
                <label class="form-label">Trạng thái:</label>
                <form:select path="isNonLocked" cssClass="form-select">
                    <form:option value="true">Hoạt động</form:option>
                    <form:option value="false">Bị khóa</form:option>
                </form:select>
            </div>

            <button type="submit" class="btn btn-success w-100">Đăng ký</button>
            <div class="mt-3">
                Nếu bạn đã có tài khoản,
                <a href="/BeeStore/Login">đăng nhập tại đây</a>
            </div>
        </form:form>
    </div>
</div>
</body>
</html>
