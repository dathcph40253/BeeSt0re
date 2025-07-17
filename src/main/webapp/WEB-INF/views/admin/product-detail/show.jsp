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

        .btn-info:hover {
            color: #000;
            background-color: #31d2f2;
            border-color: #25cff2;
        }

        .btn-info:focus {
            color: #000;
            background-color: #31d2f2;
            border-color: #25cff2;
            box-shadow: 0 0 0 0.25rem rgba(11, 172, 204, 0.5);
        }

        .btn-info:active {
            color: #000;
            background-color: #3dd5f3;
            border-color: #25cff2;
        }

        .products-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
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

        .btn-info:hover {
            color: #000;
            background-color: #31d2f2;
            border-color: #25cff2;
        }

        .btn-info:focus {
            color: #000;
            background-color: #31d2f2;
            border-color: #25cff2;
            box-shadow: 0 0 0 0.25rem rgba(11, 172, 204, 0.5);
        }

        .btn-info:active {
            color: #000;
            background-color: #3dd5f3;
            border-color: #25cff2;
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
            <h1>Chi tiết sản phẩm</h1>
            <a href="/product-detail/create" class="btn-add btn">
                <i class="fas fa-plus"></i>
                Thêm sản phẩm
            </a>
        </div>
        <!-- Products Table -->
        <div class="table-container">
            <table>
                <thead>
                <tr>
                    <th>Hình ảnh</th>
                    <th>Tên sản phẩm</th>
                    <th>Danh mục</th>
                    <th>Size</th>
                    <th>Màu sắc</th>
                    <th>Giá</th>
                    <th>Tồn kho</th>
                    <th>Thao tác</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${productDetails}" var="productDetail">
                    <tr>
                        <td>
                            <c:forEach items="${productDetail.imageList}" var ="img">
                                <img src="/images/product/${img.link}" alt="image product detail" class="product-image">
                            </c:forEach>
                        </td>
                        <td>${productDetail.product.name}</td>
                        <td>${productDetail.product.category.name}</td>
                        <td>${productDetail.size.name}</td>
                        <td>${productDetail.color.name}</td>
                        <td>${productDetail.price}</td>
                        <td>${productDetail.quantity}</td>
                        <td class="product-actions">
                            <a href="/product-detail/edit/${productDetail.id}" class="btn-edit">
                                <i class="fas fa-edit">
                                </i></a>
                            <a class="btn-delete" href="/product-detail/delete/${productDetail.id}">
                                <i class="fas fa-trash">
                                </i></a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <div>
                <a href="/product" class="btn btn-info" style="margin-top:48px">Quay lại</a>
            </div>

        </div>
    </div>
</div>
</body>
</html>

