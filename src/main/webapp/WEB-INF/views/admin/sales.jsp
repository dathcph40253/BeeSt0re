<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bán hàng - Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"/>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        .tab {
            display:inline-block;
            padding:8px 15px;
            background:#e9ecef;
            border-radius:5px 5px 0 0;
            margin-right:5px;
            cursor:pointer;
            transition:0.2s;
        }
        .tab:hover { background:#dee2e6; }
        .tab.active {
            background:#fff;
            font-weight:bold;
            border:2px solid #0d6efd;
            border-bottom:none;
        }
        .remove-tab-btn {
            margin-left:6px;
            color:#dc3545;
            cursor:pointer;
        }
        .card {
            border-radius:12px;
            box-shadow:0 2px 8px rgba(0,0,0,0.05);
        }
        .cart-total {
            font-size:1.2rem;
            font-weight:bold;
            color:#d63384;
        }
        .sales-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .page-title {
            color: #2c3e50;
            font-weight: 600;
            margin-bottom: 0;
        }
    </style>
</head>
<body>
<div class="container">
    <!-- Sidebar -->
    <jsp:include page="layout/sidebar.jsp"/>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Top Bar -->
        <jsp:include page="layout/header.jsp"/>

        <!-- Sales Content -->
        <div class="sales-header">
            <h3 class="page-title">
                <i class="fa-solid fa-cash-register text-primary me-2"></i> Quản lý Bán Hàng
            </h3>
        </div>

<!-- Tabs -->
<div id="cartTabs" class="mb-3 d-flex align-items-center">
    <c:set var="currentTab" value="${currentTab != null ? currentTab : 1}"/>
    <c:forEach var="entry" items="${carts}">
        <c:set var="tabId" value="${entry.key}" />
        <div class="tab ${tabId == currentTab ? 'active' : ''}">
            <a href="/admin/sales?tab=${tabId}" style="text-decoration:none;color:inherit;">
                Đơn ${tabId}
            </a>
            <span class="remove-tab-btn" onclick="removeTab(${tabId}, event)">✖</span>
        </div>
    </c:forEach>
    <button onclick="window.location.href='/admin/sales?newTab=true'" class="btn btn-sm btn-outline-primary ms-3">+ Thêm đơn</button>
</div>

<!-- Alerts -->
<c:if test="${not empty success}">
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        ✅ ${success}
        <c:if test="${not empty lastBillId}">
            <a href="/admin/sales/print/${lastBillId}" target="_blank"
               class="btn btn-outline-primary btn-sm ms-2">
                🖨 In hóa đơn
            </a>
        </c:if>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>
<c:if test="${not empty error}">
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        ⚠️ ${error}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<div class="row g-4">
    <!-- ================= SẢN PHẨM ================= -->
    <div class="col-md-7">
        <div class="card p-3">
            <h5 class="mb-3">📦 Danh sách sản phẩm</h5>
            <form method="get" action="/admin/sales" class="d-flex mb-3">
                <input type="hidden" name="tab" value="${currentTab}"/>
                <input type="text" class="form-control me-2" name="keyword"
                       value="${searchQuery}" placeholder="🔍 Tìm sản phẩm..."/>
                <button type="submit" class="btn btn-primary">Tìm</button>
            </form>
            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead class="table-light">
                    <tr>
                        <th>Ảnh</th>
                        <th>Tên SP</th>
                        <th>Màu</th>
                        <th>Size</th>
                        <th>Giá</th>
                        <th>Tồn kho</th>
                        <th style="width:120px;">Thêm</th>
                    </tr>
                    </thead>
                    <tbody>

                    <c:forEach var="p" items="${productDetails}">
                        <tr>
                            <td>
                                <img src="/images/product/${p.imageList[0].link}" alt="image product"
                                     style="width:50px; height:50px; object-fit:cover; border-radius:8px;">
                            </td>

                            <td>${p.product.name}</td>
                            <td>${p.color.name}</td>
                            <td>${p.size.name}</td>
                            <td class="text-success fw-bold">
                                <fmt:formatNumber value="${p.price}" type="number" pattern="#,###"/> đ
                            </td>
                            <td>${p.quantity}</td>
                            <td>
                                <form method="post" action="/admin/sales/cart/add" class="d-flex">
                                    <input type="hidden" name="tabId" value="${currentTab}"/>
                                    <input type="hidden" name="productDetailId" value="${p.id}"/>
                                    <input type="number" name="quantity" value="1" min="1" max="${p.quantity}" class="form-control form-control-sm me-1"/>
                                    <button type="submit" class="btn btn-sm btn-success">+</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- ================= GIỎ HÀNG + THANH TOÁN ================= -->
    <div class="col-md-5">
        <div class="card p-3 mb-3">
            <h5 class="mb-3">🛒 Giỏ hàng (Đơn ${currentTab})</h5>
            <div class="table-responsive">
                <table class="table table-sm align-middle">
                    <thead class="table-light">
                    <tr>
                        <th>Sản phẩm</th>
                        <th style="width:110px;">SL</th>
                        <th>Thành tiền</th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="c" items="${cartItems}" varStatus="status">
                        <tr>
                            <td>${c.productDetail.product.name}</td>
                            <td>
                                <input type="number"
                                       class="form-control form-control-sm quantity-input"
                                       data-tab="${currentTab}"
                                       data-index="${status.index}"
                                       value="${c.quantity}" min="0"/>
                            </td>
                            <td class="fw-bold text-danger">
                                <fmt:formatNumber value="${c.totalPrice}" type="number" pattern="#,###"/> đ
                            </td>
                            <td>
                                <form method="post" action="/admin/sales/cart/remove">
                                    <input type="hidden" name="tabId" value="${currentTab}"/>
                                    <input type="hidden" name="cartIndex" value="${status.index}"/>
                                    <button type="submit" class="btn btn-sm btn-outline-danger">✖</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>

            <div class="mt-3">
                <h6>Tổng cộng:
                    <span class="cart-total">
                        <fmt:formatNumber value="${cartTotal}" type="number" pattern="#,###"/> đ
                    </span>
                </h6>
                <h6 class="mt-2">Giảm giá:
                    <span class="text-success fw-bold" id="discountAmount">
                        <fmt:formatNumber value="${discount.amount}" type="number" pattern="#,###"/>
                    </span>
                </h6>
                <h6 class="mt-2">Khách cần trả:
                    <span class="text-danger fw-bold" id="finalAmount">
                        <fmt:formatNumber value="${cartTotal}" type="number" pattern="#,###"/> đ
                    </span>
                </h6>
            </div>
        </div>

        <div class="card p-3">
            <h5 class="mb-3">💳 Thanh toán</h5>
            <form method="post" action="/admin/sales/place-order" id="checkoutForm">
                <input type="hidden" name="tabId" value="${currentTab}"/>
                <div class="mb-2">
                    <label class="form-label">Địa chỉ thanh toán</label>
                    <input type="text" name="billingAddress" class="form-control"/>
                </div>
                <div class="mb-2">
                    <label class="form-label">Loại hóa đơn</label>
                    <select name="invoiceType" class="form-select">
                        <option value="RETAIL">Bán lẻ</option>
                        <option value="WHOLESALE">Bán sỉ</option>
                    </select>
                </div>
                <div class="mb-2">
                    <label class="form-label">Phương thức thanh toán</label>
                    <div id="paymentMethodBox">
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="paymentMethodId" value="1" id="pm_cash" required>
                            <label class="form-check-label" for="pm_cash">Tiền mặt</label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="paymentMethodId" value="2" id="pm_transfer">
                            <label class="form-check-label" for="pm_transfer">Chuyển khoản</label>
                        </div>

                    </div>
                </div>

                <!-- VietQR -->
                <div class="mb-3" id="transferQrBox" style="display:none;">
                    <h6>📲 Quét QR chuyển khoản</h6>
                    <div id="qrContainer" class="border p-2 text-center"></div>
                </div>

                <div class="mb-2">
                    <label class="form-label">Mã giảm giá</label>
                    <select name="discountId" class="form-select" id="discountSelect">
                        <option value="">-- Không áp dụng --</option>
                        <c:forEach var="d" items="${discounts}">
                            <option value="${d.id}" data-amount="${d.amount}">${d.code}</option>
                        </c:forEach>
                    </select>
                </div>
                <button type="submit" class="btn btn-success w-100">Tạo hóa đơn</button>
            </form>
        </div>
    </div>
</div>

<script>
    function removeTab(tabId, event) {
        event.preventDefault();
        window.location.href = "/admin/sales?removeTab=" + tabId;
    }

    $(document).on("change", ".quantity-input", function() {
        const tabId = $(this).data("tab");
        const cartIndex = $(this).data("index");
        const quantity = $(this).val();
        $.post("/admin/sales/cart/update", {tabId, cartIndex, quantity}, function() {
            location.reload();
        });
    });

    let cartTotal = ${cartTotal};
    let discountValue = 0;
    let finalAmount = cartTotal;

    const discountSelect = document.getElementById("discountSelect");
    const discountAmountEl = document.getElementById("discountAmount");
    const finalAmountEl = document.getElementById("finalAmount");

    function updateFinalAmount() {
        finalAmount = cartTotal - discountValue;
        if (finalAmount < 0) finalAmount = 0;
        discountAmountEl.textContent = discountValue.toLocaleString() + " đ";
        finalAmountEl.textContent = finalAmount.toLocaleString() + " đ";
    }

    discountSelect.addEventListener("change", function() {
        const selectedOption = discountSelect.options[discountSelect.selectedIndex];
        const discountAttr = selectedOption.getAttribute("data-amount");
        discountValue = discountAttr ? parseFloat(discountAttr) : 0;
        updateFinalAmount();
    });

    updateFinalAmount();

    $(document).on("change", "input[name='paymentMethodId']", function() {
        const selectedVal = $(this).val();
        if (selectedVal === "2") {
            const amount = finalAmount;
            const bankId = "techcombank";
            const accountNo = "77996299999";
            const accountName = "NGUYEN NGOC THANH";
            const description = "Be Store don hang" + new Date().getTime();
            const qrUrl = "https://img.vietqr.io/image/" + bankId + "-" + accountNo + "-compact2.jpg"
                + "?amount=" + amount
                + "&addInfo=" + encodeURIComponent(description)
                + "&accountName=" + encodeURIComponent(accountName);
            $("#qrContainer").html('<img src="' + qrUrl + '" alt="QR chuyển khoản VietQR">');
            $("#transferQrBox").show();
        } else {
            $("#transferQrBox").hide();
            $("#qrContainer").empty();
        }
    });
</script>
    </div>
</div>

</body>
</html>
