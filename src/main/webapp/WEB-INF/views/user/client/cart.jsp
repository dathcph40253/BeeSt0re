<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ hàng - BeeStore</title>
    <link rel="stylesheet" href="/css/user/cart.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="../layout/header.jsp"/>

<div class="container mt-4">
    <div class="nofication-cart" id="nofication-cart"></div>
    <h1 class="mb-4">Giỏ hàng của bạn</h1>

    <c:choose>
        <c:when test="${empty cartItems}">
            <div class="text-center py-5">
                <i class="fas fa-shopping-cart fa-3x text-muted mb-3"></i>
                <h3>Giỏ hàng trống</h3>
                <p class="text-muted">Hãy thêm sản phẩm vào giỏ hàng để tiếp tục mua sắm</p>
                <a href="/" class="btn btn-primary">Tiếp tục mua sắm</a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="row">
                <div class="col-lg-8">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0">Sản phẩm trong giỏ hàng (${cartItemCount} sản phẩm)</h5>
                        </div>
                        <div class="card-body">
                            <c:forEach items="${cartItems}" var="item">
                                <div class="row cart-item mb-3 pb-3 border-bottom" data-cart-id="${item.id}">
                                    <div class="col-md-2">
                                        <img src="/images/product/${item.productImage}"
                                             alt="${item.productName}"
                                             class="img-fluid rounded">
                                    </div>
                                    <div class="col-md-4">
                                        <h6>${item.productName}</h6>
                                        <p class="text-muted mb-1">Màu: ${item.productColor}</p>
                                        <p class="text-muted mb-1">Size: ${item.productSize}</p>
                                        <p class="text-primary fw-bold">
                                            <fmt:formatNumber value="${item.productDetail.price}" type="currency" currencySymbol="₫"/>
                                        </p>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="input-group">
                                            <button class="btn btn-outline-secondary btn-sm" type="button"
                                                    onclick="changeQuantity(${item.id}, -1, ${item.productDetail.quantity})">-</button>

                                            <input type="number" class="form-control text-center"
                                                value="${item.quantity}" min="1" id="quantity-${item.id}"
                                                onchange="updateQuantity(${item.id}, this.value, ${item.productDetail.quantity})">

                                            <button class="btn btn-outline-secondary btn-sm" type="button"
                                                    onclick="changeQuantity(${item.id}, 1, ${item.productDetail.quantity})">+</button>
                                        </div>

                                        <small class="text-muted">Còn ${item.productDetail.quantity} sản phẩm</small>
                                    </div>
                                    <div class="col-md-2 text-end">
    <%-- 1. Xác định giá đơn vị cuối cùng (giá đã giảm nếu có) --%>
    <c:set var="finalUnitPrice" 
           value="${item.productDetail.discountedPrice lt item.productDetail.price ? item.productDetail.discountedPrice : item.productDetail.price}"/>
           
    <c:set var="itemSubtotal" value="${finalUnitPrice * item.quantity}"/>

    <c:choose>
        <c:when test="${item.productDetail.discountedPrice lt item.productDetail.price}">
            <p class="infProducts_home text-danger fw-bold mb-0">
                <fmt:formatNumber value="${itemSubtotal}" type="number" pattern="#,##0" />₫
            </p>
            
            <c:set var="originalSubtotal" value="${item.productDetail.price * item.quantity}"/>
            <p class="infProducts_home text-muted text-decoration-line-through small">
                <fmt:formatNumber value="${originalSubtotal}" type="number" pattern="#,##0" />₫
            </p>
            
            <p class="small text-muted mb-0">
                (<fmt:formatNumber value="${item.productDetail.price}" type="number" pattern="#,##0" />₫/sp)
            </p>
        </c:when>
        <c:otherwise>
            <p class="infProducts_home fw-bold">
                <fmt:formatNumber value="${itemSubtotal}" type="number" pattern="#,##0" />₫
            </p>
        </c:otherwise>
    </c:choose>
</div>
                                    <div class="col-md-1">
                                        <button class="btn btn-outline-danger btn-sm"
                                                onclick="removeFromCart(${item.id})">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0">Tóm tắt đơn hàng</h5>
                        </div>
                        <div class="card-body">
                            <div class="d-flex justify-content-between mb-2">
                                <span>Tạm tính:</span>
                                <span><fmt:formatNumber value="${cartTotal}" type="currency" currencySymbol="₫"/></span>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span>Phí vận chuyển:</span>
                                <span>Miễn phí</span>
                            </div>
                            <hr>
                            <div class="d-flex justify-content-between mb-3">
                                <strong>Tổng cộng:</strong>
                                <strong class="text-primary">
                                    <fmt:formatNumber value="${cartTotal}" type="currency" currencySymbol="₫"/>
                                </strong>
                            </div>
                            <a href="/cart/checkout" class="btn btn-primary w-100 mb-2"
                            onclick="checkOut(event)">
                                Tiến hành thanh toán
                            </a>
                            <a href="/" class="btn btn-outline-secondary w-100">
                                Tiếp tục mua sắm
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="../layout/footer.jsp"/>

<script>

const cartItemsJS = [
    <c:forEach items="${cartItems}" var="item" varStatus="loop">
        {
            id: ${item.id},
            productName: "${item.productName}",
            productDetail: {
                quantity: ${item.productDetail.quantity}
            }
        }<c:if test="${!loop.last}">,</c:if>
    </c:forEach>
] || [];

function changeQuantity(cartId, delta, maxQuantity) {
    const input = document.getElementById("quantity-" + cartId);
    if (!input) return;

    let current = parseInt(input.value);
    let newQuantity = current + delta;

    // Nếu người dùng giảm về 0 -> xác nhận xóa
    if (newQuantity < 1) {
        if (confirm('Bạn có chắc muốn xóa sản phẩm này khỏi giỏ hàng không?')) {
            removeFromCart(cartId);
        }
        return;
    }

    // Nếu vượt quá số lượng tồn kho -> thông báo và giữ nguyên giá trị cũ
    if (newQuantity > maxQuantity) {
        showNotification('Chỉ còn ' + maxQuantity + ' sản phẩm trong kho.', 'error');
        return;
    }

    // Cập nhật trên giao diện
    input.value = newQuantity;

    // Cập nhật về server (AJAX)
    updateQuantity(cartId, newQuantity);
}



function updateQuantity(cartId, quantity, maxQuantity, newValue) {
    const finalQuantity = newValue !== undefined ? parseInt(newValue) : quantity;
    if (finalQuantity < 1) {
        removeFromCart(cartId);
        return;
    }
        if( finalQuantity > maxQuantity){
            showNotification('Số lượng vượt quá tồn kho ' + maxQuantity, 'error');
            document.querySelector("#quantity-" + cartId).value = maxQuantity;
            return;
        }

    fetch('/cart/update', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: 'cartId=' + cartId + '&quantity=' + finalQuantity
    })
    .then(response => response.text())
    .then(data => {
        if (data.startsWith('success:')) {
            location.reload();
        } else {
            showNotification(data.replace('error:', ''), 'error');
        }
    });
}

function checkOut(event) {
    event.preventDefault();
    if(!checkQuantity(cartItemsJS)){
        return;
    }
    showNotification('Đang chuyển đến trang thanh toán...', 'info');
    setTimeout(() => {
        window.location.href = '/cart/checkout';
    }, 1500);
}

function removeFromCart(cartId) {
    if (confirm('Bạn có chắc muốn xóa sản phẩm này?')) {
        fetch('/cart/remove', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: 'cartId=' + cartId
        })
        .then(response => response.text())
        .then(data => {
            if (data.startsWith('success:')) {
                location.reload();
            } else {
                showNotification(data.replace('error:', ''), 'error');
            }
        });
    }
}
function checkQuantity(items){
    for ( let item of items){
        const inputField = document.getElementById("quantity-" + item.id);
        if (!inputField) continue; // Nếu không tìm thấy trường input, bỏ qua
        const quantityInput = parseInt(inputField.value);
        if (quantityInput > item.productDetail.quantity){
            showNotification("Số lượng sản phẩm " + item.productName + " vượt quá tồn kho " + item.productDetail.quantity, 'error');
            return false;
        } else if (quantityInput < 1){
            showNotification("Số lượng sản phẩm " + item.productName + " phải lớn hơn 0", 'error');
            return false;
        }
    }
    return true;

}
    function showNotification(message, type = 'info') {
        const notification = document.getElementById('nofication-cart');
        notification.textContent = message;
        notification.className = `nofication-cart ${type}`;
        
        // Thêm class show để kích hoạt hiệu ứng
        notification.style.display = 'block';
        setTimeout(() => notification.classList.add('show'), 10);

        // Ẩn sau 3 giây
        setTimeout(() => {
            notification.classList.remove('show');
            setTimeout(() => {
                notification.style.display = 'none';
            }, 400); // chờ hiệu ứng fade-out
        }, 3000);
    }

</script>
</body>
</html>