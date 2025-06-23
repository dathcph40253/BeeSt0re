<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Quản lý Kích Thước</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <h2 class="mb-4">Quản Lý Kích Thước</h2>
    <div class="d-flex justify-content-between mb-3">
        <a class="btn btn-secondary" href="/BeeStore/Home">🏠 Trang chủ</a>
        <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#addSizeModal">
            ➕ Thêm Kích Thước
        </button>
    </div>

    <c:if test="${not empty message}">
        <div class="alert ${messageType == 'success' ? 'alert-success' : 'alert-danger'} alert-dismissible fade show" role="alert">
                ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <form class="row g-3 mb-4" method="get" action="/BeeStore/Size/search">
        <div class="col-auto">
            <input type="text" class="form-control" name="id" placeholder="Tìm theo ID">
        </div>
        <div class="col-auto">
            <button type="submit" class="btn btn-primary">🔍 Tìm kiếm</button>
        </div>
        <div class="col-auto">
            <a href="/BeeStore/Size" class="btn btn-outline-secondary">🔄 Tải lại bảng</a>
        </div>
    </form>

    <div class="table-responsive">
        <table class="table table-bordered table-striped table-hover align-middle">
            <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Mã kích thước</th>
                <th>Tên kích thước</th>
                <th>Thao tác</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="size" items="${sizes}">
                <tr>
                    <td>${size.id}</td>
                    <td>${size.code}</td>
                    <td>${size.name}</td>
                    <td>
                        <a href="/BeeStore/Size/update"
                           class="btn btn-warning btn-sm"
                           data-bs-toggle="modal"
                           data-bs-target="#editSizeModal${size.id}">Sửa</a>
                        <a href="/BeeStore/Size/delete?id=${size.id}"
                           class="btn btn-danger btn-sm"
                           onclick="return confirm('Bạn có muốn xóa kích thước này không?')">Xóa</a>
                    </td>
                </tr>

                <!-- Modal sửa kích thước -->
                <div class="modal fade" id="editSizeModal${size.id}" tabindex="-1" aria-labelledby="editSizeModalLabel${size.id}" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <form method="post" action="/BeeStore/Size/update">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="editSizeModalLabel${size.id}">Sửa Kích Thước</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                </div>
                                <div class="modal-body">
                                    <input type="hidden" name="id" value="${size.id}">
                                    <div class="mb-3">
                                        <label class="form-label">Mã Kích Thước</label>
                                        <input type="text" class="form-control" name="code" value="${size.code}">
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Tên Kích Thước</label>
                                        <input type="text" class="form-control" name="name" value="${size.name}">
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                    <button type="submit" class="btn btn-primary">Cập nhật</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<!-- Modal thêm kích thước -->
<div class="modal fade" id="addSizeModal" tabindex="-1" aria-labelledby="addSizeModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addSizeModalLabel">Thêm Kích Thước Mới</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form method="post" action="/BeeStore/Size/add">
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="sizeCode" class="form-label">Mã Kích Thước <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="sizeCode" name="code">
                    </div>
                    <div class="mb-3">
                        <label for="sizeName" class="form-label">Tên Kích Thước <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="sizeName" name="name">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-success">Thêm Kích Thước</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
