<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Chi tiết sản phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2 class="mb-4">${product.name}</h2>
    <div class="row">
        <div class="col-md-5">
            <!-- Ảnh lấy từ ảnh của detail đầu tiên -->
            <c:if test="${not empty detail and not empty detail[0].image}">
                <img src="/uploads/${detail[0].image.link}" class="img-fluid" alt="${product.name}">
            </c:if>
            <c:if test="${empty detail or empty detail[0].image}">
                <img src="/images/no-image.png" class="img-fluid" alt="Không có ảnh">
            </c:if>
        </div>
        <div class="col-md-7">
            <p><strong>Giá:</strong> ${product.price} đ</p>
            <p><strong>Mô tả:</strong> ${product.describe}</p>
            <p><strong>Thương hiệu:</strong> ${product.brand.name}</p>
            <p><strong>Danh mục:</strong> ${product.category.name}</p>
            <p><strong>Chất liệu:</strong> ${product.material.name}</p>

            <hr>
            <h5>Chi tiết sản phẩm:</h5>
            <table class="table table-bordered">
                <thead>
                <tr>
                    <th>Ảnh</th>
                    <th>Mã vạch</th>
                    <th>Kích cỡ</th>
                    <th>Màu sắc</th>
                    <th>Số lượng</th>
                    <th>Giá chi tiết</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="detail" items="${detail}">
                    <tr>
                        <td>
                            <c:if test="${not empty detail.image}">
                                <img src="/uploads/${detail.image.link}" width="70" height="70" />
                            </c:if>
                            <c:if test="${empty detail.image}">
                                <img src="/images/no-image.png" width="70" height="70" />
                            </c:if>
                        </td>
                        <td>${detail.barcode}</td>
                        <td>${detail.size.name}</td>
                        <td>${detail.color.name}</td>
                        <td>${detail.quantity}</td>
                        <td>${detail.price} đ</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>
