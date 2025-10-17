<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BeeStore - Trang chủ</title>

    <link rel="stylesheet" href="/css/user/home.css">
    <link rel="stylesheet" href="/css/user/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>
<body>
<jsp:include page="../layout/header.jsp"/>

<div class="content-wrapper">

    <!-- ================= BANNER + MENU ================= -->
    <div class="top-section">
        <jsp:include page="../layout/menu.jsp"/>

        <div class="slider-container">
            <div class="slider">
                <div class="slide"><img src="${pageContext.request.contextPath}/images/slide/mau-banner-website.jpg" alt="Banner 1" class="image_slider"></div>
                <div class="slide"><img src="${pageContext.request.contextPath}/images/slide/anh3.jpg" alt="Banner 2" class="image_slider"></div>
                <div class="slide"><img src="${pageContext.request.contextPath}/images/slide/banner-thoi-trang-nam.jpg" alt="Banner 3" class="image_slider"></div>
            </div>
            <button class="prev">&#10094;</button>
            <button class="next">&#10095;</button>
        </div>
    </div>
    <div class="sub-banner">
        <div class="promo-banner">
            <img src="${pageContext.request.contextPath}/images/slide/anh4.jpg" alt="image" class="promo-banner-img">
        </div>
        <div class="promo-banner">
            <img src="${pageContext.request.contextPath}/images/slide/anh5.jpg" alt="image" class="promo-banner-img">
        </div>
        <div class="promo-banner">
            <img src="${pageContext.request.contextPath}/images/slide/anh6.jpg" alt="image" class="promo-banner-img">
        </div>
        <div class="promo-banner">
            <img src="${pageContext.request.contextPath}/images/slide/anh7.jpg" alt="image" class="promo-banner-img">
        </div>
    </div>
    <!-- ================= GIẢM GIÁ HÔM NAY ================= -->
    <c:if test="${not empty discountProducts}">
        <div class="discount-section">
            <div class="discount-header">
                <h2 class="discount-title">🔥 Giảm giá hôm nay 🔥</h2>
                <a href="/product?status=sale" class="view-all-btn">Xem tất cả</a>
            </div>

            <div class="discount-wrapper">
                <button class="discount-prev">&#10094;</button>

                <div class="discount-products">
                    <c:forEach items="${discountProducts}" var="product">
                        <c:set var="pd" value="${product.productDetailList[0]}" />
                        <div class="discount-item">
                            <div class="discount-image">
                                <a href="/product/${product.id}">
                                    <c:if test="${not empty pd.imageList}">
                                        <img src="/images/product/${pd.imageList[0].link}" alt="${product.name}">
                                    </c:if>
                                </a>
                                <c:set var="percentOff" value="${(pd.price - pd.discountedPrice) * 100 / pd.price}" />
                                <c:if test="${percentOff > 0}">
                                    <span class="discount-badge">-${percentOff.intValue()}%</span>
                                </c:if>
                                <c:if test="${not empty pd.productDiscount}">
                                    <span class="discount-timer" id="timer-${product.id}" 
                                        data-end="${pd.productDiscount[0].endDateAsDate.time}">Loading...</span>
                                </c:if>
                            </div>
                            <div class="discount-info">
                                <h4>${product.name}</h4>
                                <div class="discount-price">
                                    <span class="text-danger">${pd.discountedPrice}₫</span>
                                    <c:if test="${pd.discountedPrice lt pd.price}">
                                        <span class="text-muted">${pd.price}₫</span>
                                    </c:if>
                                </div>
                            </div>
                            <div class="product_rating">
                                <span class="stars">★★★★★</span> 
                                <span class="review_count">(${product.productDetailList[0].quantity})</span> 
                            </div>
                        </div>
                    </c:forEach>
                </div>
w
                <button class="discount-next">&#10095;</button>
            </div>
        </div>
    </c:if>
<!-- ================= SẢN PHẨM BÁN CHẠY ================= -->
<div class="discount-section">
    <div class="discount-header">
        <h2 class="discount-title">🔥 SẢN PHẨM BÁN CHẠY 🔥</h2>
        <a href="/product?status=best" class="view-all-btn">Xem tất cả</a>
    </div>

    <div class="discount-wrapper">
        <button class="discount-prev best-prev">&#10094;</button>

        <div class="discount-products best-products">
            <c:forEach var="item" items="${bestSellers}">
                <div class="discount-item">
                    <div class="discount-image">
                        <a href="/product/${item.productId}">
                            <img src="/images/product/${item.imageLink}" alt="${item.productName}">
                        </a>
                    </div>
                    <div class="discount-info">
                        <h4>${item.productName}</h4>
                        <div class="discount-price">
                            <span class="text-danger">Đã bán: ${item.totalSoldQuantity}</span>
                        </div>
                    </div>
                    <div class="product_rating">
                        <span class="stars">★★★★★</span> 
                    </div>
                </div>
            </c:forEach>
        </div>
        <button class="discount-next best-next">&#10095;</button>
    </div>
</div>

    <div class="sub-banner">
        <div class="promo-banner">
            <img src="${pageContext.request.contextPath}/images/slide/anh4.jpg" alt="image" class="promo-banner-img">
        </div>
        <div class="promo-banner">
            <img src="${pageContext.request.contextPath}/images/slide/anh5.jpg" alt="image" class="promo-banner-img">
        </div>
        <div class="promo-banner">
            <img src="${pageContext.request.contextPath}/images/slide/anh6.jpg" alt="image" class="promo-banner-img">
        </div>
        <div class="promo-banner">
            <img src="${pageContext.request.contextPath}/images/slide/anh7.jpg" alt="image" class="promo-banner-img">
        </div>
    </div>

    <!-- ================= DANH SÁCH SẢN PHẨM ================= -->
    <h2 class="listProduct">Danh sách sản phẩm</h2>
        <div class="filter-discount">
            <a href="/" class="filter-btn ${empty selectedPercent ? 'active' : ''}">Xem tất cả</a>
            <a href="/product/filter?percent=40"
            class="filter-btn ${selectedPercent == 40 ? 'active' : ''}">Giảm từ 40%</a>
            <a href="/product/filter?percent=50"
            class="filter-btn ${selectedPercent == 50 ? 'active' : ''}">Giảm từ 50%</a>
            <a href="/product/filter?percent=60"
            class="filter-btn ${selectedPercent == 60 ? 'active' : ''}">Giảm từ 60%</a>
        </div>
    <div class="products_home">
        <c:forEach items="${products}" var="product">
            <c:set var="pd" value="${product.productDetailList[0]}" />
            <div class="item_products_home">
                <div class="image_home_item">
                    <a href="/product/${product.id}">
                        <c:if test="${not empty pd.imageList}">
                            <img src="/images/product/${pd.imageList[0].link}" alt="${product.name}" class="image_products_home">
                        </c:if>
                    </a>
                </div>
                <div class="infProducts_home">
                    <h4 class="product_name">${product.name}</h4>
                    <c:choose>
                        <c:when test="${pd.discountedPrice lt pd.price}">
                            <div class="price_box">
                                <span class="text-danger">${pd.discountedPrice}₫</span>
                                <span class="text-muted">${pd.price}₫</span>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <p class="infProducts_home">${pd.price}₫</p>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="product_rating">
                    <span class="stars">★★★★★</span> 
                    <span class="review_count">(${product.productDetailList[0].quantity})</span> 
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<jsp:include page="../layout/footer.jsp"/>

<script>
window.addEventListener("load", () => {
    const slides = document.querySelectorAll(".slide");
    const prev = document.querySelector(".prev");
    const next = document.querySelector(".next");
    let index = 0;
    slides[0].classList.add("active");
    function showSlide(i) {
        slides[index].classList.remove("active");
        index = (i + slides.length) % slides.length;
        slides[index].classList.add("active");
    }
    prev.addEventListener("click", () => showSlide(index - 1));
    next.addEventListener("click", () => showSlide(index + 1));

    document.querySelectorAll('.discount-timer').forEach(timerEl => {
        const endTime = Number(timerEl.dataset.end);
        if (isNaN(endTime) || endTime - Date.now() <= 0) {
            timerEl.innerHTML = "Hết hạn";
            return;
        }
        const interval = setInterval(() => {
            const distance = endTime - Date.now();
            if (distance <= 0) { timerEl.innerHTML = "Hết hạn"; clearInterval(interval); return; }
            const days = Math.floor(distance / (1000*60*60*24));
            const hours = Math.floor((distance % (1000*60*60*24))/(1000*60*60));
            const minutes = Math.floor((distance % (1000*60*60))/(1000*60));
            const seconds = Math.floor((distance % (1000*60))/1000);
            timerEl.innerHTML = days+"d "+hours+"h "+minutes+"m "+seconds+"s";
        },1000);
    });
});
function setupSlider(containerSelector, prevSelector, nextSelector, itemWidth = 220, visibleCount = 5) {
    const container = document.querySelector(containerSelector);
    const prev = document.querySelector(prevSelector);
    const next = document.querySelector(nextSelector);
    if (!container || !prev || !next) return;

    prev.addEventListener("click", () => {
        container.scrollBy({ left: -itemWidth * visibleCount, behavior: "smooth" });
    });
    next.addEventListener("click", () => {
        container.scrollBy({ left: itemWidth * visibleCount, behavior: "smooth" });
    });
}

setupSlider(".discount-products", ".discount-prev", ".discount-next");
setupSlider(".best-products", ".best-prev", ".best-next");

</script>
</body>
</html>
