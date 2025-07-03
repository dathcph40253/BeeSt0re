<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Detail</title>
    <link rel="stylesheet" href="/css/user/home.css">
    <link rel="stylesheet" href="/css/user/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" type="text/css"
          href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick.min.css" />
    <link rel="stylesheet" type="text/css"
          href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick-theme.min.css" />
    <link rel="stylesheet" href="/css/user/detail.css">
</head>
<body>
<jsp:include page="../layout/header.jsp"/>
<div class="content">
    <div class="content_detailProduct">
        <div class="img_product">
            <img src="/images/product/${details[0].imageList[0].link}" alt="" class="image_shirt">
            <div class="image_detail_product">
                <img src="" alt="" class="image_shirt_detail">
                <img src="" alt="" class="image_shirt_detail">
                <img src="" alt="" class="image_shirt_detail">
            </div>
        </div>
        <div class="inf_product">
            <h2 class="title_inf_products">${details[0].product.name}</h2>
            <p class="price_inf_products">${details[0].price}VND</p>
            <p class="status_inf_products">Tình trạng: <span class="status_color_inf">còn hàng</span></p>
            <p class="color_inf_products">Màu sắc:</p>
            <div class="box_option_size">
                <c:forEach items="${details}" var="detail">
                    <div class="item_box_optionSize">
                        <p class="size_item_box">${detail.color.name}</p>
                    </div>
                </c:forEach>
            </div>
            <p class="size_inf_products">Size:</p>
            <div class="box_option_size">
                <c:forEach items="${details}" var="detail">
                    <div class="item_box_optionSize">
                        <p class="size_item_box">${detail.size.name}</p>
                    </div>
                </c:forEach>

            </div>
            <p class="quantity_inf_products">Số lượng</p>
            <div class="quantity_box">
                <div class="detail_quatity">
                    <div class="number_quantity">
                        1
                    </div>
                    <div class="quantity">
                        <button class="totalProducts">+</button>
                        <button class="totalProducts">-</button>
                    </div>
                </div>
                <a href="./Cart.html" class="btn_quantity_box">
                    Thêm vào giỏ hàng
                </a>
            </div>

            <div class="inf_detailProducts">
                <p class="title_detai_products">Chi tiết sản phẩm</p>
                <ul class="box_detail_products_inf">
                    <li>- 100% Premium Cotton</li>
                    <li>
                        - Kỹ thuật in: Screen Printing + Puff Printing (In Nổi)
                    </li>
                    <li>
                        - Hình in được in với mực đạt chuẩn Eco Friendly và
                        an toàn cho người mặc.
                    </li>
                    <li>
                        - Vải được nhuộm với thuốc nhuộm thân thiện với
                        môi trường, giảm đến 70% lượng nước thải và an
                        toàn cho người mặc.
                    </li>
                </ul>
            </div>
        </div>
    </div>

    <!-- Sản phẩm liên quan -->
    <div class="Related_products">
        <h2 class="title_related_products">SẢN PHẨM LIÊN QUAN</h2>
        <div class="product_related">
            <div class="item_product_related">
                <img src="../img/Detail_product/product1.png" alt="" class="image_products_related">
                <div class="boxname_product_related">
                    <p class="name_product_reletd"> LOGOS T-SHIRT -WHITE</p>
                </div>
                <p class="name_product_reletd"><strong>275.000VND</strong></p>
            </div>
            <div class="item_product_related">
                <img src="../img/Detail_product/product2.png" alt="" class="image_products_related">
                <div class="boxname_product_related">
                    <p class="name_product_reletd"> LOGOS T-SHIRT -WHITE</p>
                </div>
                <p class="name_product_reletd"><strong>275.000VND</strong></p>
            </div>
            <div class="item_product_related">
                <img src="../img/Detail_product/product3.png" alt="" class="image_products_related">
                <div class="boxname_product_related">
                    <p class="name_product_reletd"> LOGOS T-SHIRT -WHITE</p>
                </div>
                <p class="name_product_reletd"><strong>275.000VND</strong></p>
            </div>
            <div class="item_product_related">
                <img src="../img/Detail_product/product4.png" alt="" class="image_products_related">
                <div class="boxname_product_related">
                    <p class="name_product_reletd"> LOGOS T-SHIRT -WHITE</p>
                </div>
                <p class="name_product_reletd"><strong>275.000VND</strong></p>
            </div>
        </div>
    </div>
</div>
<jsp:include page="../layout/footer.jsp"/>
</body>
</html>