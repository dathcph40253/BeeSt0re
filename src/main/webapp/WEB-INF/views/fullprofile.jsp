<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Thông tin cá nhân</title>
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="card shadow mx-auto" style="max-width: 500px;">
        <div class="card-header bg-primary text-white text-center">
            <h4 class="mb-0">Thông tin cá nhân</h4>
        </div>
        <div class="card-body">
            <ul class="list-group list-group-flush">
                <li class="list-group-item">
                    <strong>Mã khách hàng:</strong> <span class="text-muted"><c:out value="${customer.code}"/></span>
                </li>
                <li class="list-group-item">
                    <strong>Email khách hàng:</strong> <span class="text-muted"><c:out value="${customer.email}"/></span>
                </li>
                <li class="list-group-item">
                    <strong>Tên khách hàng:</strong> <span class="text-muted"><c:out value="${customer.name}"/></span>
                </li>
                <li class="list-group-item">
                    <strong>Số điện thoại:</strong> <span class="text-muted"><c:out value="${customer.phoneNumber}"/></span>
                </li>
            </ul>
        </div>
        <div class="card-footer text-center">
            <a href="Home" class="btn btn-outline-primary">← Trở về trang chủ</a>
        </div>
    </div>
</div>

<!-- Bootstrap JS (tuỳ chọn) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
