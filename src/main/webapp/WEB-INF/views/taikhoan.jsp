<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Quản lý Người Dùng</title>
    <!-- Link Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <h2 class="mb-4">Quản lý Người Dùng</h2>
    <a class="btn btn-secondary mb-3" href="/BeeStore/Home">🏠 Trang chủ</a>

    <form class="row g-3 mb-4" method="get" action="/BeeStore/QuanLiNguoiDung">
        <div class="col-auto">
            <input type="text" class="form-control" name="id" placeholder="Tìm theo ID">
        </div>
        <div class="col-auto">
            <button type="submit" class="btn btn-primary">🔍 Tìm kiếm</button>
        </div>
    </form>

    <div class="table-responsive">
        <table class="table table-bordered table-striped table-hover align-middle">
            <thead class="table-dark">
            <tr>
                <th scope="col">ID</th>
                <th scope="col">Mã tài khoản</th>
                <th scope="col">Email</th>
                <th scope="col">Trạng thái</th>
                <th scope="col">Vai trò</th>
                <th scope="col">Ngày tạo</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="acc" items="${users}">
                <tr>
                    <td>${acc.id}</td>
                    <td>${acc.code}</td>
                    <td>${acc.email}</td>
                    <td>
                        <span class="badge ${acc.isNonLocked ? 'bg-success' : 'bg-danger'}">
                                ${acc.isNonLocked ? 'Hoạt động' : 'Bị khóa'}
                        </span>
                    </td>
                    <td>${acc.role.name}</td>
                    <td>${acc.createDate}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<!-- Bootstrap JS (tùy chọn nếu cần chức năng nâng cao) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
