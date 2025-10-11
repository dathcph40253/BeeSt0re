<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>BeeStore - Trang chủ</title>

    <!-- CSS -->
    <link rel="stylesheet" href="/css/user/home.css">
    <link rel="stylesheet" href="/css/user/style.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <!-- Slick carousel -->
    <link rel="stylesheet" type="text/css"
          href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick.min.css" />
    <link rel="stylesheet" type="text/css"
          href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick-theme.min.css" />
</head>

<body>
    <!-- HEADER -->
    <jsp:include page="../layout/header.jsp"/>

    <!-- NỘI DUNG TRANG CHỦ -->
    <div class="content">
        <!-- MENU DỌC BÊN TRÁI -->
        <jsp:include page="../layout/menu.jsp"/>

        <!-- VÙNG HIỂN THỊ CHÍNH -->
        <div class="main-content">
            <!-- SLIDER -->
          <div class="slider-container">
            <div class="slider">
              <div class="slide">
                <img src="${pageContext.request.contextPath}/images/slide/mau-banner-website.jpg" alt="Banner 1" class="image_slider">
              </div>
              <div class="slide">
                <img src="${pageContext.request.contextPath}/images/slide/anh3.jpg" alt="Banner 2" class="image_slider">
              </div>
              <div class="slide">
                <img src="${pageContext.request.contextPath}/images/slide/banner-thoi-trang-nam.jpg" alt="Banner 3" class="image_slider">
              </div>
            </div>
            <button class="prev">&#10094;</button>
            <button class="next">&#10095;</button>
          </div>

          <div class="scolling-text">
            Chào mừng bạn đến với trang web bán hàng của chúng tôi! Chúc bạn mua hàng và lựa được những món hàng ưng ý với bạn!
          </div>
            <h2> Danh sách sản phẩm</h2>
            <!-- DANH SÁCH SẢN PHẨM -->
            <div class="products_home">
                <c:forEach items="${products}" var="product">
                    <div class="item_products_home">
                        <div class="image_home_item">
                            <a href="/product/${product.id}">
                                <img src="/images/product/${product.productDetailList[0].imageList[0].link}"
                                     alt="image product" class="image_products_home">
                            </a>
                        </div>
                        <h4 class="infProducts_home">${product.name}</h4>

                        <c:choose>
                            <c:when test="${product.productDetailList[0].discountedPrice lt product.productDetailList[0].price}">
                                <p class="infProducts_home text-danger fw-bold">
                                    ${product.productDetailList[0].discountedPrice}₫
                                </p>
                                <p class="infProducts_home text-muted text-decoration-line-through">
                                    ${product.productDetailList[0].price}₫
                                </p>
                            </c:when>
                            <c:otherwise>
                                <p class="infProducts_home">${product.productDetailList[0].price}₫</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>

    <!-- FOOTER -->
    <jsp:include page="../layout/footer.jsp"/>
<script>
window.addEventListener("load", () => {
  const slides = document.querySelectorAll(".slide");
  const prev = document.querySelector(".prev");
  const next = document.querySelector(".next");
  let index = 0;

  // Hiển thị slide đầu tiên ngay khi load
  slides[0].classList.add("active");

  function showSlide(i) {
    slides[index].classList.remove("active");
    index = (i + slides.length) % slides.length;
    slides[index].classList.add("active");
  }

  prev.addEventListener("click", () => showSlide(index - 1));
  next.addEventListener("click", () => showSlide(index + 1));
});

</script>
</body>
</html>
