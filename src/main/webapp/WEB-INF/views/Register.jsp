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
        .required-field::after {
            content: " *";
            color: red;
        }
    </style>
</head>
<body>
<div class="container">

    <c:if test="${not empty message}">
        <div id="message" class="message-top-right">${message}</div>
        <script>
            window.onload = function () {
                const x = document.getElementById("message");
                if (x) {
                    setTimeout(() => {
                        x.style.display = "none";
                    }, 3000);
                }
            }
        </script>
    </c:if>

    <div class="register-form">
        <h2 class="text-center mb-4">Đăng kí tài khoản</h2>

        <form:form modelAttribute="user" action="/BeeStore/DangKy" method="post">

            <input type="hidden" name="isSubmitted" value="true"/>

            <!-- Tên tài khoản -->
            <div class="mb-3">
                <label for="name" class="form-label required-field">Tên tài khoản:</label>
                <form:input path="name" cssClass="form-control" id="name"/>
                <c:if test="${isSubmitted}">
                    <form:errors path="name" cssClass="text-danger"/>
                </c:if>
            </div>

            <!-- Mật khẩu -->
            <div class="mb-3">
                <label for="password" class="form-label required-field">Mật khẩu:</label>
                <form:password path="password" cssClass="form-control" id="password"/>
                <c:if test="${isSubmitted}">
                    <form:errors path="password" cssClass="text-danger"/>
                </c:if>
            </div>

            <!-- Họ tên -->
            <div class="mb-3">
                <label for="hoTen" class="form-label required-field">Họ tên:</label>
                <form:input path="hoTen" cssClass="form-control" id="hoTen"/>
                <c:if test="${isSubmitted}">
                    <form:errors path="hoTen" cssClass="text-danger"/>
                </c:if>
            </div>

            <!-- Giới tính -->
            <div class="mb-3">
                <label class="form-label required-field">Giới tính:</label><br>
                <form:radiobutton path="gioiTinh" id="nam" value="Nam" cssClass="form-check-input"/>
                <label for="nam" class="form-check-label me-3">Nam</label>

                <form:radiobutton path="gioiTinh" id="nu" value="Nữ" cssClass="form-check-input"/>
                <label for="nu" class="form-check-label">Nữ</label>

                <c:if test="${isSubmitted}">
                    <form:errors path="gioiTinh" cssClass="text-danger d-block"/>
                </c:if>
            </div>

            <!-- Ngày sinh -->
            <div class="mb-3">
                <label for="ngaySinh" class="form-label required-field">Ngày sinh:</label>
                <form:input path="ngaySinh" type="date" cssClass="form-control" id="ngaySinh"/>
                <c:if test="${isSubmitted}">
                    <form:errors path="ngaySinh" cssClass="text-danger"/>
                </c:if>
            </div>

            <!-- Email -->
            <div class="mb-3">
                <label for="email" class="form-label required-field">Email:</label>
                <form:input path="email" type="email" cssClass="form-control" id="email"/>
                <c:if test="${isSubmitted}">
                    <form:errors path="email" cssClass="text-danger"/>
                </c:if>
            </div>

            <!-- Số điện thoại -->
            <div class="mb-3">
                <label for="soDienThoai" class="form-label required-field">Số điện thoại:</label>
                <form:input path="soDienThoai" cssClass="form-control" id="soDienThoai"/>
                <c:if test="${isSubmitted}">
                    <form:errors path="soDienThoai" cssClass="text-danger"/>
                </c:if>
            </div>

            <!-- Địa chỉ -->
            <div class="mb-3">
                <label for="diaChi" class="form-label required-field">Địa chỉ:</label>
                <form:input path="diaChi" cssClass="form-control" id="diaChi"/>
                <c:if test="${isSubmitted}">
                    <form:errors path="diaChi" cssClass="text-danger"/>
                </c:if>
            </div>

            <!-- Vai trò -->
            <div class="mb-3">
                <label for="role" class="form-label required-field">Vai trò:</label>
                <form:select path="role" cssClass="form-select" id="role">
                    <form:option value="" label="-- Chọn vai trò --"/>
                    <form:option value="Guest">Khách</form:option>
                </form:select>
                <c:if test="${isSubmitted}">
                    <form:errors path="role" cssClass="text-danger"/>
                </c:if>
            </div>

            <!-- Trạng thái -->
            <div class="mb-3">
                <label class="form-label">Trạng thái:</label>
                <form:select path="trangThai" cssClass="form-select">
                    <form:option value="true">Hoạt động</form:option>
                    <form:option value="false">Bị khóa</form:option>
                </form:select>
            </div>

            <div class="mb-3">
                <small class="text-muted">Các trường có dấu <span class="text-danger">*</span> là bắt buộc</small>
            </div>

            <button type="submit" class="btn btn-success w-100">Đăng kí</button>
        </form:form>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
