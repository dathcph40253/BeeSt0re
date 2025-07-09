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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="/css/style.css">
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
                <li class="list-group-item">
                    <strong>Địa chỉ:</strong> <span class="text-muted"><c:out value="${address.address}"/></span>
                </li>
            </ul>
        </div>
        <div class="card-footer text-center d-flex justify-content-between">
            <a href="Home" class="btn btn-outline-primary">← Trở về trang chủ</a>
            <button class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#updateProfileModal">Cập nhật thông tin</button>
        </div>
    </div>
</div>

<!-- Modal cập nhật thông tin cá nhân -->
<div class="modal fade" id="updateProfileModal" tabindex="-1" aria-labelledby="updateProfileModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form method="post" action="/fullProFile/update">
                <div class="modal-header">
                    <h5 class="modal-title" id="updateProfileModalLabel">Cập nhật thông tin</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">

                    <div class="mb-3">
                        <label class="form-label">Họ tên</label>
                        <input type="text" class="form-control" name="name" value="${infoDto.name}" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Email</label>
                        <input type="email" class="form-control" name="email" value="${infoDto.email}" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Số điện thoại</label>
                        <input type="text" class="form-control" name="phoneNumber" value="${infoDto.phoneNumber}" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Địa chỉ</label>
                        <input type="text" class="form-control" name="address" value="${infoDto.address}">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
