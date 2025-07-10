<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý sản phẩm - Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="/css/style.css">
    <style>
        .btn {
            display: inline-block;
            font-weight: 400;
            line-height: 1.5;
            color: #212529;
            text-align: center;
            text-decoration: none;
            vertical-align: middle;
            cursor: pointer;
            user-select: none;
            background-color: transparent;
            border: 1px solid transparent;
            padding: 0.375rem 0.75rem;
            font-size: 1rem;
            border-radius: 0.375rem;
            transition: color 0.15s ease-in-out, background-color 0.15s ease-in-out,
            border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
        }

        .btn-info {
            color: #000;
            background-color: #0dcaf0;
            border-color: #0dcaf0;
        }
        .products-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .btn-add {
            background: #2ecc71;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 5px;
            transition: background 0.3s ease;
            text-decoration: none;
        }

        .btn-add:hover {
            background: #27ae60;
        }

        .product-image {
            width: 50px;
            height: 50px;
            border-radius: 5px;
            object-fit: cover;
        }

        .product-actions {
            display: flex;
            gap: 10px;
        }

        .btn-edit {
            background: #3498db;
            color: #fff;
            border: none;
            padding: 5px 10px;
            border-radius: 3px;
            cursor: pointer;
        }

        .btn-delete {
            background: #e74c3c;
            color: #fff;
            border: none;
            padding: 5px 10px;
            border-radius: 3px;
            cursor: pointer;
        }

        .filters {
            display: flex;
            gap: 15px;
            margin-bottom: 20px;
        }

        .filter-group {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .filter-group select {
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 5px;
            outline: none;
        }
    </style>
</head>
<body>
<div class="container">
    <!-- Sidebar -->
    <jsp:include page="../layout/sidebar.jsp"/>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Top Bar -->
        <jsp:include page="../layout/header.jsp"/>

        <!-- Products Content -->
        <div class="products-header">
            <h1>Quản lý sản phẩm</h1>
            <a class="btn-add" href="/product/create">
                <i class="fas fa-plus"></i>
                Thêm sản phẩm
            </a>
        </div>

        <!-- Filters -->
        <div class="filters">
            <div class="filter-group">
                <label>Danh mục:</label>
                <select>
                    <option value="">Tất cả</option>
                    <option value="1">Điện thoại</option>
                    <option value="2">Laptop</option>
                    <option value="3">Phụ kiện</option>
                </select>
            </div>
            <div class="filter-group">
                <label>Trạng thái:</label>
                <select>
                    <option value="">Tất cả</option>
                    <option value="1">Còn hàng</option>
                    <option value="2">Hết hàng</option>
                </select>
            </div>
            <div class="filter-group">
                <label>Sắp xếp:</label>
                <select>
                    <option value="1">Mới nhất</option>
                    <option value="2">Giá tăng dần</option>
                    <option value="3">Giá giảm dần</option>
                </select>
            </div>
        </div>

        <!-- Products Table -->
        <div class="table-container">
            <table>
                <thead>
                <tr>
                    <th>STT</th>
                    <th>ID</th>
                    <th>Hình ảnh</th>
                    <th>Tên sản phẩm</th>
                    <th>Mã sản phẩm</th>
                    <th>Danh mục</th>
                    <th>Mô tả</th>
                    <th>Ngày tạo</th>
                    <th>Ngày sửa</th>
                    <th>Thương hiệu</th>
                    <th>Chất liệu</th>
                    <th>Tồn kho</th>
                    <th>Trạng thái</th>
                    <th>Thao tác</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="product" items="${products}" varStatus="status">
                    <tr>
                        <td>${status.index + 1}</td>
                        <td>${product.id}</td>
                        <td><img src="/images/product/${product.productDetailList[0].imageList[0].link}" alt="Product" class="product-image"></td>
                        <td>${product.name}</td>
                        <td>${product.code}</td>
                        <td>${product.category.name}</td>
                        <td>${product.describe}</td>
                        <td>${product.create_date}</td>
                        <td>${product.updated_date}</td>
                        <td>${product.brand.name}</td>
                        <td>${product.material.name}</td>
                        <td>${product.getTotalQuantity()}</td>
                        <td>${product.status == 1 ? "Hoạt động" : "Ngừng hoạt động"}</td>
                        <td class="product-actions">
                            <a class="btn-edit" href="/product/update/${product.id}"><i class="fas fa-edit"></i></a>
                            <a class="btn-delete" href="/product/delete/${product.id}"><i class="fas fa-trash"></i></a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <div style="display: flex">
                <a href="/Home" class="btn btn-info" style="margin-top:48px">Quay lại</a>
                <a href="/product-detail" class="btn btn-info" style="margin-top:48px; margin-left: 30px">Trang chi tiết</a>
            </div>
        </div>
    </div>
</div>
</body>
</html>

