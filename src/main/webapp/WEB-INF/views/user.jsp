<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Đăng nhập</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            height: 100vh;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            background: #f8f9fa;
        }
        .login-box {
            padding: 40px 32px;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
            min-width: 320px;
            text-align: center;
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
    <div id="message" class="message-top-right">
            ${message}
    </div>
</c:if>
<div class="login-box">
    <h2 class="mb-4">Đăng nhập</h2>
    <form action="/Login" method="post">
        <div class="mb-3 text-start">
            <label class="form-label">Tên tài khoản:</label>
            <input type="text" name="name" class="form-control"/>
        </div>
        <div class="mb-3 text-start">
            <label class="form-label">Mật khẩu:</label>
            <input type="password" name="password" class="form-control"/>
        </div>
        <button type="submit" class="btn btn-primary w-100">Đăng nhập</button>
        <div class="mt-3">
            Nếu bạn chưa có tài khoản,
            <a href="/DangKy">đăng ký tại đây</a>
        </div>
    </form>
</div>
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
