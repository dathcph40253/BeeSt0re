<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Quản lý Màu Sắc</title>
    <!-- Link Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="/css/style.css">
</head>
<body style="min-with:100vh; display:flex">

<jsp:include page="admin/layout/sidebar.jsp"/>
<div class="main-content">
    <jsp:include page="admin/layout/header.jsp"/>
    <jsp:include page="admin/layout/page-title.jsp">
        <jsp:param name="title" value="Quản Lý Màu Sắc"/>
        <jsp:param name="icon" value="fa-solid fa-palette"/>
    </jsp:include>
    <div class="d-flex justify-content-between mb-3">
        <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#addColorModal">
            ➕ Thêm Màu Sắc
        </button>
    </div>

    <!-- Hiển thị thông báo -->
    <c:if test="${not empty message}">
        <div class="alert ${messageType == 'success' ? 'alert-success' : 'alert-danger'} alert-dismissible fade show" role="alert">
                ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <form class="row g-3 mb-4" method="get" action="/Color/search">
        <div class="col-auto">
            <input type="text" class="form-control" name="id" placeholder="Tìm theo ID">
        </div>
        <div class="col-auto">
            <button type="submit" class="btn btn-primary">🔍 Tìm kiếm</button>
        </div>
        <div class="col-auto">
            <a href="/Color" class="btn btn-outline-secondary">🔄 Tải lại bảng</a>
        </div>
    </form>
    <c:if test="${not empty success}">
        <div class="alert alert-success">${success}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>
    <div class="table-responsive">
        <table class="table table-bordered table-striped table-hover align-middle">
            <thead class="table-dark">
            <tr>
                <th scope="col">STT</th>
                <th scope="col">ID</th>
                <th scope="col">Mã màu sắc</th>
                <th scope="col">Tên màu sắc</th>
                <th scope="col">Thao tác</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="color" items="${colors}" varStatus="status">
                <tr>
                    <td>${status.index + 1}</td>
                    <td>${color.id}</td>
                    <td>${color.code}</td>
                    <td>${color.name}</td>

                    <td>
                        <a href="/Color/update"
                           class="btn btn-warning btn-sm"
                           role="button"
                           data-bs-toggle="modal"
                           data-bs-target="#editColorModal${color.id}">
                            Sửa
                        </a>
                        <a href="/Color/delete?id=${color.id}"
                           class="btn btn-sm btn-danger" onclick="return confirm('Bạn có muốn xóa màu sắc này không?')"
                        >Xóa</a>
                    </td>
                </tr>

                <!-- Modal sửa màu sắc -->
                <div class="modal fade" id="editColorModal${color.id}" tabindex="-1" aria-labelledby="editColorModalLabel${color.id}" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <form method="post" action="/Color/update">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="editColorModalLabel${color.id}">Sửa Màu Sắc</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                </div>
                                <div class="modal-body">
                                    <input type="hidden" name="id" value="${color.id}">

                                    <div class="mb-3">
                                        <label class="form-label">Mã Màu Sắc</label>
                                        <input type="text" class="form-control" name="code" value="${color.code}">
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Tên Màu Sắc</label>
                                        <input type="text" class="form-control" name="name" value="${color.name}">
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

<!-- Modal thêm màu sắc -->
<div class="modal fade" id="addColorModal" tabindex="-1" aria-labelledby="addColorModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addColorModalLabel">Thêm Màu Sắc Mới</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form method="post" action="/Color/add">
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="colorCode" class="form-label">Mã Màu Sắc <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="colorCode" name="code">
                    </div>
                    <div class="mb-3">
                        <label for="colorName" class="form-label">Tên Màu Sắc <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="colorName" name="name">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-success">Thêm Màu Sắc</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Bootstrap JS-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>