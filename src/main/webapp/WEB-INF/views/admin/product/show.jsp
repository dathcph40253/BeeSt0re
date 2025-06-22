<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý sản phẩm - Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
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
    <div class="sidebar">
        <div class="logo">
            <img src="https://via.placeholder.com/50" alt="Logo">
            <h2>Admin Panel</h2>
        </div>
        <nav>
            <ul>
                <li>
                    <a href="">
                        <i class="fas fa-home"></i>
                        <span>Trang chủ</span>
                    </a>
                </li>
                <li class="active">
                    <a href="">
                        <i class="fas fa-box"></i>
                        <span>Sản phẩm</span>
                    </a>
                </li>
                <li>
                    <a href="">
                        <i class="fas fa-shopping-cart"></i>
                        <span>Đơn hàng</span>
                    </a>
                </li>
                <li>
                    <a href="">
                        <i class="fas fa-users"></i>
                        <span>Khách hàng</span>
                    </a>
                </li>
                <li>
                    <a href="">
                        <i class="fas fa-tags"></i>
                        <span>Danh mục</span>
                    </a>
                </li>
                <li>
                    <a href="">
                        <i class="fas fa-chart-bar"></i>
                        <span>Báo cáo</span>
                    </a>
                </li>
                <li>
                    <a href="">
                        <i class="fas fa-cog"></i>
                        <span>Cài đặt</span>
                    </a>
                </li>
            </ul>
        </nav>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Top Bar -->
        <div class="top-bar">
            <div class="search-box">
                <i class="fas fa-search"></i>
                <input type="text" placeholder="Tìm kiếm sản phẩm...">
            </div>
            <div class="user-info">
                <div class="notifications">
                    <i class="fas fa-bell"></i>
                    <span class="badge">3</span>
                </div>
                <div class="user">
                    <img src="https://via.placeholder.com/40" alt="User">
                    <span>Admin User</span>
                </div>
            </div>
        </div>

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
                <c:forEach var="product" items="${products}">
                    <tr>
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
        </div>
    </div>
</div>
</body>
</html>

