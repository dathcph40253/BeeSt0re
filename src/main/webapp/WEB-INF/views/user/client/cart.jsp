<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Giỏ hàng</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="/css/user/style.css">
    <link rel="stylesheet" href="/css/user/home.css">
    <link rel="stylesheet" href="/css/user/cart.css">
</head>
<body>
<jsp:include page="../layout/header.jsp"/>
<div class="content">
    <div class="content_Cart">
        <ul class="item_content_cart">
            <li>
                <p class="lable_products_cart">Sản phẩm</p>
                <div class="products_cart">
                    <img src="../img/Cart/tee-electric-white_1.jpg" alt="" class="image_products_cart">
                    <p class="name_products_cart">T-Shirt The Universe - M</p>
                </div>
            </li>
            <li>
                <p class="lable_products_cart">Giá</p>
                <div class="products_cart">
                    <p class="price_cart">320.000VND</p>
                </div>
            </li>
            <img src="" alt="">
            <li>
                <p class="lable_products_cart">Số lượng</p>

                <div class="products_cart">
                    <ul class="quantity_cart">
                        <button class="quantity_detail_Cart" style="background-color: transparent;border: none;">-</button>
                        <li class="quantity_detail_Cart">1</li>
                        <button class="quantity_detail_Cart" style="background-color: transparent;border: none;">+</button>
                    </ul>
                </div>

            </li>
            <li>
                <p class="lable_products_cart">Tạm tính</p>
                <div class="products_cart">
                    <p class="price_cart">320,000VND</p>
                </div>
            </li>
            <li>
                <p class="lable_products_cart">Tổng giỏ hàng</p>
                <div class="products_cart_total">
                    <div class="item_total_cart">
                        <p class="title_total_cart">Tạm tính</p>
                        <p class="title_total_cart">320.000VND</p>
                    </div>
                    <div class="item_total_cart">
                        <p class="title_total_cart">Giao hàng</p>
                        <p class="title_total_cart">32.000VND</p>
                    </div>
                    <div class="item_total_cart">
                        <p class="title_total_cart">Tổng cộng</p>
                        <p class="title_total_cart">350.000VND</p>
                    </div>
                    <button class="btn_itemPay">
                        <a href="../src/PayCart.html" class="text_btn_itemPay"> Tiến hành thanh toán</a>
                    </button>

                </div>
            </li>
        </ul>
        <button class="btn_continue">
            <a href="/Home" class="text_btn_continue">Tiếp tục xem sản phẩm</a>
        </button>
    </div>
</div>
<jsp:include page="../layout/footer.jsp"/>
</body>
</html>