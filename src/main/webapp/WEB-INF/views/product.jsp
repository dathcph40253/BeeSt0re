<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Danh sách sản phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2 class="mb-4">Danh sách sản phẩm</h2>
    <div class="row row-cols-1 row-cols-md-3 g-4">
        <c:forEach var="products" items="${products}">
            <div class="col">
                <a href="/BeeStore/Product/detail/${products.id}" class="text-decoration-none text-dark">
                    <div class="card h-100">
                        <div class="card-body">
                            <h5 class="card-title">${products.name}</h5>
                            <p class="card-text"><strong>Giá:</strong> ${products.price} đ</p>
                            <p class="card-text"><strong>Thương hiệu:</strong> ${products.brand.name}</p>
                            <p class="card-text"><strong>Danh mục:</strong> ${products.category.name}</p>
                            <p class="card-text"><strong>Chất liệu:</strong> ${products.material.name}</p>
                        </div>
                    </div>
                </a>
            </div>
        </c:forEach>
    </div>
</div>
</body>
</html>
