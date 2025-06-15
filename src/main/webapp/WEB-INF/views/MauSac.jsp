<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>Quản lý Màu Sắc</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
        }
        
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 15px;
            background-color: #f8f9fa;
            border-bottom: 1px solid #dee2e6;
        }
        
        .header-title {
            display: flex;
            align-items: center;
        }
        
        .header-buttons {
            display: flex;
            gap: 10px;
        }
        
        .search-bar {
            padding: 15px;
            background-color: #ffc107;
        }
        
        .status-badge {
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
            display: inline-block;
        }
        
        .status-active {
            background-color: #d4edda;
            color: #155724;
        }
        
        .status-inactive {
            background-color: #f8d7da;
            color: #721c24;
        }
        
        .action-button {
            width: 40px;
            height: 40px;
            margin: 0 5px;
            border: none;
            border-radius: 5px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
        }
        
        .edit-button {
            background-color: #ffc107;
            color: #000;
        }
        
        .delete-button {
            background-color: #dc3545;
            color: #fff;
        }
        
        .message-top-right {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 9999;
            padding: 15px;
            border-radius: 5px;
            background-color: #d4edda;
            color: #155724;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        
        .table {
            margin-bottom: 0;
        }
        
        .table th {
            background-color: #f8f9fa;
            border-bottom: 2px solid #dee2e6;
        }
        
        .action-cell {
            white-space: nowrap;
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

    <!-- Header -->
    <div class="header">
        <div class="header-title">
            <i class="fas fa-palette me-2"></i>
            <h4 class="mb-0">Quản lý Màu Sắc</h4>
        </div>
        <div class="header-buttons">
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addColorModal">
                <i class="fas fa-plus-circle me-2"></i>Thêm màu sắc mới
            </button>
            <a href="/BeeStore/Home" class="btn btn-outline-secondary">
                <i class="fas fa-home me-2"></i>Trang chủ
            </a>
        </div>
    </div>
    
    <!-- Search Bar -->
    <div class="search-bar">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <form class="d-flex" action="/BeeStore/MauSac" method="get">
                        <input type="text" name="keyword" class="form-control me-2" placeholder="Tìm kiếm..." value="${keyword}" />
                        <button type="submit" class="btn btn-light">
                            <i class="fas fa-search"></i>
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Table -->
    <div class="container-fluid mt-3">
        <div class="table-responsive">
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Mã màu sắc</th>
                        <th>Tên màu sắc</th>
                        <th>Trạng thái</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="ms" items="${danhSachMauSac}">
                        <tr>
                            <td>${ms.id}</td>
                            <td>${ms.maMauSac}</td>
                            <td>${ms.tenMauSac}</td>
                            <td>
                                <span class="status-badge ${ms.trangThai ? 'status-active' : 'status-inactive'}">
                                    ${ms.trangThai ? 'Hoạt động' : 'Không hoạt động'}
                                </span>
                            </td>
                            <td class="action-cell">
                                <button type="button" class="action-button edit-button" 
                                        onclick="editColor('${ms.id}', '${ms.maMauSac}', '${ms.tenMauSac}', ${ms.trangThai})">
                                    <i class="fas fa-edit"></i>
                                </button>
                                <a href="/BeeStore/MauSac/delete/${ms.id}" class="action-button delete-button" 
                                   onclick="return confirm('Bạn có chắc chắn muốn xóa màu sắc này?')">
                                    <i class="fas fa-trash"></i>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        
        <c:if test="${empty danhSachMauSac}">
            <div class="alert alert-info text-center mt-3">
                Không có dữ liệu màu sắc
            </div>
        </c:if>
    </div>

    <!-- Modal Thêm/Sửa Màu Sắc -->
    <div class="modal fade" id="addColorModal" tabindex="-1" aria-labelledby="addColorModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title" id="modalTitle">Thêm màu sắc mới</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form:form id="colorForm" modelAttribute="mauSac" action="/BeeStore/MauSac/save" method="post">
                        <form:hidden path="id" id="colorId" />
                        
                        <div class="mb-3">
                            <label for="maMauSac" class="form-label">Mã màu sắc:</label>
                            <form:input path="maMauSac" id="maMauSac" class="form-control" required="true" />
                            <form:errors path="maMauSac" cssClass="text-danger" />
                        </div>
                        
                        <div class="mb-3">
                            <label for="tenMauSac" class="form-label">Tên màu sắc:</label>
                            <form:input path="tenMauSac" id="tenMauSac" class="form-control" required="true" />
                            <form:errors path="tenMauSac" cssClass="text-danger" />
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Trạng thái:</label>
                            <div class="form-check">
                                <form:radiobutton path="trangThai" id="active" value="true" class="form-check-input" />
                                <label for="active" class="form-check-label">Hoạt động</label>
                            </div>
                            <div class="form-check">
                                <form:radiobutton path="trangThai" id="inactive" value="false" class="form-check-input" />
                                <label for="inactive" class="form-check-label">Không hoạt động</label>
                            </div>
                            <form:errors path="trangThai" cssClass="text-danger" />
                        </div>
                        
                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save me-2"></i>Lưu
                            </button>
                            <button type="button" id="btnReset" class="btn btn-secondary">
                                <i class="fas fa-undo me-2"></i>Làm mới
                            </button>
                        </div>
                    </form:form>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Font Awesome -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
    
    <script>
        // Hiển thị modal khi có lỗi validation
        document.addEventListener('DOMContentLoaded', function() {
            const hasErrors = ${not empty org.springframework.validation.BindingResult.mauSac && org.springframework.validation.BindingResult.mauSac.hasErrors()};
            if (hasErrors) {
                const modal = new bootstrap.Modal(document.getElementById('addColorModal'));
                modal.show();
            }
        });
        
        // Reset form
        document.getElementById('btnReset').addEventListener('click', function() {
            document.getElementById('colorForm').reset();
            document.getElementById('colorId').value = '';
            document.getElementById('modalTitle').innerText = 'Thêm màu sắc mới';
        });
        
        // Hàm edit màu sắc
        function editColor(id, maMauSac, tenMauSac, trangThai) {
            document.getElementById('colorId').value = id;
            document.getElementById('maMauSac').value = maMauSac;
            document.getElementById('tenMauSac').value = tenMauSac;
            
            if (trangThai) {
                document.getElementById('active').checked = true;
            } else {
                document.getElementById('inactive').checked = true;
            }
            
            document.getElementById('modalTitle').innerText = 'Cập nhật màu sắc';
            
            const modal = new bootstrap.Modal(document.getElementById('addColorModal'));
            modal.show();
        }
    </script>
</body>
</html>
