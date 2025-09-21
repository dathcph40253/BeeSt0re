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
    <h1 class="mb-4">Giỏ hàng của bạn</h1>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <c:if test="${not empty success}">
        <div class="alert alert-success">${success}</div>
    </c:if>

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
                                                    onclick="updateQuantity(${item.id}, ${item.quantity - 1})">-</button>
                                            <input type="number" class="form-control text-center"
                                                   value="${item.quantity}" min="1"
                                                   onchange="updateQuantity(${item.id}, this.value)">
                                            <button class="btn btn-outline-secondary btn-sm" type="button"
                                                    onclick="updateQuantity(${item.id}, ${item.quantity + 1})">+</button>
                                        </div>
                                        <small class="text-muted">Còn ${item.productDetail.quantity} sản phẩm</small>
                                    </div>
                                    <div class="col-md-2">
                                        <p class="fw-bold text-primary">
                                            <fmt:formatNumber value="${item.totalPrice}" type="currency" currencySymbol="₫"/>
                                        </p>
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
                            <a href="/cart/checkout" class="btn btn-primary w-100 mb-2">
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
function updateQuantity(cartId, quantity) {
    if (quantity < 1) {
        removeFromCart(cartId);
        return;
    }

    fetch('/cart/update', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: 'cartId=' + cartId + '&quantity=' + quantity
    })
    .then(response => response.text())
    .then(data => {
        if (data.startsWith('success:')) {
            location.reload();
        } else {
            alert(data.replace('error:', ''));
        }
    });
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
                alert(data.replace('error:', ''));
            }
        });
    }
}
</script>
</body>
</html>