<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Bán hàng tại quầy - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="/css/style.css">
    <style>
        .table-fixed { max-height: 360px; overflow-y: auto; }
        .pointer { cursor: pointer; }
        .card { box-shadow: 0 2px 5px rgba(0,0,0,.1); border-radius: 10px; }
        .badge-qty { background:#6366f1; }
        .product-row:hover { background: #f8f9fa; }
    </style>
</head>
<body style="min-height: 100vh; display: flex">
<jsp:include page="layout/sidebar.jsp"/>
<div class="main-content">
<jsp:include page="layout/header.jsp"/>

<div class="container-fluid p-4">
    <h3 class="mb-3"><i class="fas fa-cash-register me-2"></i>Bán hàng tại quầy</h3>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>
    <c:if test="${not empty success}">
        <div class="alert alert-success">${success}</div>
    </c:if>

    <div class="row g-3">
        <!-- Bảng sản phẩm -->
        <div class="col-lg-6">
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">Sản phẩm</h5>
                    <span class="text-muted">Click để thêm vào giỏ</span>
                </div>
                <div class="card-body p-0">
                    <table class="table mb-0">
                        <thead class="table-light">
                        <tr>
                            <th>Mã</th>
                            <th>Tên</th>
                            <th>Màu</th>
                            <th>Size</th>
                            <th class="text-end">Giá</th>
                            <th class="text-end">Tồn</th>
                        </tr>
                        </thead>
                    </table>
                    <div class="table-fixed">
                        <table class="table table-hover">
                            <tbody>
                            <c:forEach items="${productDetails}" var="pd">
                                <tr class="product-row pointer"
                                    onclick="addToCart(${pd.id})">
                                    <td>${pd.product.code}</td>
                                    <td>${pd.product.name}</td>
                                    <td>${pd.color.name}</td>
                                    <td>${pd.size.name}</td>
                                    <td class="text-end"><fmt:formatNumber value="${pd.price}" type="currency" currencySymbol="₫"/></td>
                                    <td class="text-end"><span class="badge badge-qty">${pd.quantity}</span></td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Giỏ hàng -->
        <div class="col-lg-3">
            <div class="card">
                <div class="card-header">
                    <h5 class="mb-0">Giỏ hàng</h5>
                </div>
                <div class="card-body p-0">
                    <table class="table mb-0">
                        <thead class="table-light">
                        <tr>
                            <th>Sản phẩm</th>
                            <th class="text-center">SL</th>
                            <th class="text-end">Tạm tính</th>
                            <th></th>
                        </tr>
                        </thead>
                    </table>
                    <div class="table-fixed">
                        <table class="table">
                            <tbody>
                            <c:forEach items="${cartItems}" var="item">
                                <tr>
                                    <td>
                                        <div class="small fw-semibold">${item.productName}</div>
                                        <div class="small text-muted">${item.productColor} / ${item.productSize}</div>
                                    </td>
                                    <td class="text-center" style="width:100px;">
                                        <form action="/admin/sales/cart/update" method="post" class="d-flex gap-1">
                                            <input type="hidden" name="cartId" value="${item.id}">
                                            <input class="form-control form-control-sm" type="number" name="quantity" min="0" value="${item.quantity}" style="width:70px"/>
                                            <button class="btn btn-sm btn-outline-primary" type="submit"><i class="fas fa-save"></i></button>
                                        </form>
                                    </td>
                                    <td class="text-end">
                                        <fmt:formatNumber value="${item.totalPrice}" type="currency" currencySymbol="₫"/>
                                    </td>
                                    <td class="text-end" style="width:40px;">
                                        <form action="/admin/sales/cart/remove" method="post">
                                            <input type="hidden" name="cartId" value="${item.id}">
                                            <button class="btn btn-sm btn-outline-danger" type="submit"><i class="fas fa-trash"></i></button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div class="p-3 border-top">
                        <div class="d-flex justify-content-between fw-bold">
                            <span>Tạm tính</span>
                            <span><fmt:formatNumber value="${cartTotal}" type="currency" currencySymbol="₫"/></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Thanh toán -->
        <div class="col-lg-3">
            <div class="card">
                <div class="card-header">
                    <h5 class="mb-0">Thanh toán</h5>
                </div>
                <div class="card-body">
                    <form action="/admin/sales/place-order" method="post">
                        <div class="mb-2">
                            <label class="form-label">Địa chỉ</label>
                            <input type="text" name="billingAddress" class="form-control" value="" placeholder="Nhập địa chỉ giao hàng" required>
                        </div>
                        <div class="mb-2">
                            <label class="form-label">Loại hóa đơn</label>
                            <select class="form-select" name="invoiceType">
                                <option value="RETAIL">Bán lẻ</option>
                                <option value="INVOICE">Hóa đơn VAT</option>
                            </select>
                        </div>
                        <div class="mb-2">
                            <label class="form-label">Phương thức thanh toán</label>
                            <select class="form-select" name="paymentMethodId" required>
                                <c:forEach items="${paymentMethods}" var="pm">
                                    <option value="${pm.id}">${pm.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Mã giảm giá</label>
                            <select class="form-select" name="discountId">
                                <option value="">-- Không áp dụng --</option>
                                <c:forEach items="${discounts}" var="dc">
                                    <option value="${dc.id}">${dc.code} - ${dc.detail}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <button class="btn btn-primary w-100" type="submit">
                            <i class="fas fa-receipt me-2"></i>Tạo hóa đơn & Thanh toán
                        </button>
                    </form>
                </div>
            </div>

            <div class="card mt-3">
                <div class="card-header">
                    <h6 class="mb-0">Hóa đơn gần đây</h6>
                </div>
                <div class="card-body p-0">
                    <div class="table-fixed">
                        <table class="table table-sm mb-0">
                            <thead class="table-light">
                            <tr>
                                <th>Mã</th>
                                <th class="text-end">Tổng</th>
                                <th>TT</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${recentBills}" var="b">
                                <tr>
                                    <td><a href="/orders/${b.id}">#${b.code}</a></td>
                                    <td class="text-end"><fmt:formatNumber value="${b.finalAmount}" type="currency" currencySymbol="₫"/></td>
                                    <td>${b.status}</td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<form id="addToCartForm" action="/admin/sales/cart/add" method="post" style="display:none;">
    <input type="hidden" name="productDetailId" id="productDetailId">
</form>

<script>
    function addToCart(id){
        document.getElementById('productDetailId').value = id;
        document.getElementById('addToCartForm').submit();
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</div>
</body>
</html>

