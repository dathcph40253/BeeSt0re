<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="/css/user/home.css">
    <link rel="stylesheet" href="/css/user/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" type="text/css"
          href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick.min.css" />
    <link rel="stylesheet" type="text/css"
          href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick-theme.min.css" />
    <title>BeeStore</title>
</head>
<body>
<jsp:include page="../layout/header.jsp"/>
<div class="content">
    <div class="slider">
        <img src="" alt="" class="image_slider">
    </div>
    <h1 class="title_home_product">NEW ARRIVAL</h1>


    <div class="products_home">
        <c:forEach items="${products}" var="product">
            <div class="item_products_home">
                <div class="image_home_item">
                    <a href="/BeeStore/product/${product.id}">
                        <img src="/images/product/${product.productDetailList[0].imageList[0].link}"
                             alt="image product" class="image_products_home">
                    </a>
                </div>
                <h4 class="infProducts_home">${product.name}</h4>
                <p class="infProducts_home">${product.productDetailList[0].price}</p>
            </div>

        </c:forEach>
    </div>
</div>
<jsp:include page="../layout/footer.jsp"/>
</body>
</html>