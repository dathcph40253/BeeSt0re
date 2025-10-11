<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Sản phẩm</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link rel="stylesheet" href="/css/user/product.css">
</head>
<body>

<jsp:include page="../layout/header.jsp"/>

<div class="container mt-5 mb-5">
    <h2 class="text-center mb-4">Danh sách sản phẩm</h2>

    <div class="row g-4">
        <c:forEach items="${products}" var="product">
            <div class="col-md-3 col-sm-6">
                <div class="card product-card h-100 shadow-sm border-0 position-relative">

                    <!-- Badge Sale -->
                    <c:if test="${not empty product.productDetailList 
                                 and product.productDetailList[0].discountedPrice lt product.productDetailList[0].price}">
                        <span class="badge bg-danger position-absolute top-0 start-0 m-2 px-3 py-2">Sale</span>
                    </c:if>

                    <!-- Hình ảnh -->
                    <a href="/product/${product.id}" class="text-decoration-none">
                        <c:choose>
                            <c:when test="${not empty product.productDetailList 
                                           and not empty product.productDetailList[0].imageList}">
                                <img src="/images/product/${product.productDetailList[0].imageList[0].link}"
                                     class="card-img-top product-image" alt="${product.name}">
                            </c:when>
                            <c:otherwise>
                                <img src="/images/no-image.png" class="card-img-top product-image" alt="No image">
                            </c:otherwise>
                        </c:choose>
                    </a>

                    <div class="card-body text-center">
                        <h5 class="card-title">${product.name}</h5>

                        <!-- Hiển thị giá -->
                        <p class="card-text">
                            <c:choose>
                                <c:when test="${not empty product.productDetailList}">
                                    <c:set var="price" value="${product.productDetailList[0].price}" />
                                    <c:set var="discounted" value="${product.productDetailList[0].discountedPrice}" />

                                    <c:choose>
                                        <c:when test="${discounted lt price}">
                                            <span class="text-muted text-decoration-line-through">
                                                ${price}₫
                                            </span>
                                            <span class="text-danger fw-bold ms-1">
                                                ${discounted}₫
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-dark fw-bold">
                                                ${price}₫
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </c:when>
                                <c:otherwise>
                                    <span class="text-secondary">Liên hệ</span>
                                </c:otherwise>
                            </c:choose>
                        </p>

                        <a href="/product/${product.id}" class="btn btn-outline-dark btn-sm mt-2">Xem chi tiết</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<jsp:include page="../layout/footer.jsp"/>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
