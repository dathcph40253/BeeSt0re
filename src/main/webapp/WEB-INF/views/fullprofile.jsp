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
                    <strong>Email khách hàng:</strong>
                    <span class="text-muted">
                        <c:choose>
                            <c:when test="${not empty customer.email}">
                                <c:out value="${customer.email}"/>
                            </c:when>
                            <c:otherwise>
                                <em>Chưa cập nhật</em>
                            </c:otherwise>
                        </c:choose>
                    </span>
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
        <div class="card-footer text-center">
            <a href="/" class="btn btn-outline-primary me-2">← Trở về trang chủ</a>
            <button type="button" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#editProfileModal">
                <i class="fas fa-edit"></i> Sửa thông tin
            </button>
        </div>
    </div>
</div>

<!-- Modal sửa thông tin -->
<div class="modal fade" id="editProfileModal" tabindex="-1" aria-labelledby="editProfileModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editProfileModalLabel">Sửa thông tin cá nhân</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="${pageContext.request.contextPath}/updateProfile" method="post">
                <div class="modal-body">
                    <!-- Email -->
                    <div class="mb-3">
                        <label for="editEmail" class="form-label">Email</label>
                        <input type="email" class="form-control" id="editEmail" name="email" value="${customer.email}" placeholder="Nhập email của bạn">
                    </div>

                    <!-- Tên khách hàng -->
                    <div class="mb-3">
                        <label for="editName" class="form-label">Tên khách hàng</label>
                        <input type="text" class="form-control" id="editName" name="name" value="${customer.name}" required>
                    </div>

                    <!-- Số điện thoại -->
                    <div class="mb-3">
                        <label for="editPhone" class="form-label">Số điện thoại</label>
                        <input type="text" class="form-control" id="editPhone" name="phoneNumber" value="${customer.phoneNumber}" required>
                    </div>

                    <!-- Địa chỉ -->
                    <div class="mb-3">
                        <label for="editAddress" class="form-label">Địa chỉ</label>
                        <input type="text" class="form-control" id="editAddress" name="address" value="${address.address}" required>
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
