<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đơn hàng của tôi - BeeStore</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
<jsp:include page="../layout/header.jsp"/>

<div class="container mt-4">
    <h1 class="mb-4">Đơn hàng của tôi</h1>
    
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>
    
    <c:if test="${not empty success}">
        <div class="alert alert-success">${success}</div>
    </c:if>
    
    <c:choose>
        <c:when test="${empty bills}">
            <div class="text-center py-5">
                <i class="fas fa-receipt fa-3x text-muted mb-3"></i>
                <h3>Chưa có đơn hàng nào</h3>
                <p class="text-muted">Hãy mua sắm và tạo đơn hàng đầu tiên của bạn</p>
                <a href="/" class="btn btn-primary">Mua sắm ngay</a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="row">
                <c:forEach items="${bills}" var="bill">
                    <div class="col-12 mb-4">
                        <div class="card">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="mb-0">Đơn hàng #${bill.code}</h6>
                                    <small class="text-muted">
                                        Đặt ngày: <fmt:formatDate value="${bill.createDateAsDate}" pattern="dd/MM/yyyy HH:mm"/>
                                    </small>
                                </div>
                                <div class="text-end">
                                    <c:choose>
                                        <c:when test="${bill.status == 'PENDING'}">
                                            <span class="badge bg-warning">Chờ xác nhận</span>
                                        </c:when>
                                        <c:when test="${bill.status == 'CONFIRMED'}">
                                            <span class="badge bg-info">Đã xác nhận</span>
                                        </c:when>
                                        <c:when test="${bill.status == 'PROCESSING'}">
                                            <span class="badge bg-primary">Đang xử lý</span>
                                        </c:when>
                                        <c:when test="${bill.status == 'SHIPPING'}">
                                            <span class="badge bg-secondary">Đang giao hàng</span>
                                        </c:when>
                                        <c:when test="${bill.status == 'DELIVERED'}">
                                            <span class="badge bg-success">Đã giao hàng</span>
                                        </c:when>
                                        <c:when test="${bill.status == 'CANCELLED'}">
                                            <span class="badge bg-danger">Đã hủy</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">${bill.status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-8">
                                        <p class="mb-1"><strong>Địa chỉ giao hàng:</strong> ${bill.billingAddress}</p>
                                        <p class="mb-1"><strong>Phương thức thanh toán:</strong> ${bill.paymentMethod.name}</p>
                                        <c:if test="${bill.discountCode != null}">
                                            <p class="mb-1"><strong>Mã giảm giá:</strong> ${bill.discountCode.code}</p>
                                        </c:if>
                                    </div>
                                    <div class="col-md-4 text-end">
                                        <p class="mb-1">
                                            <strong>Tổng tiền:</strong> 
                                            <span class="text-primary fs-5">
                                                <fmt:formatNumber value="${bill.finalAmount}" type="currency" currencySymbol="₫"/>
                                            </span>
                                        </p>
                                    </div>
                                </div>
                                
                                <div class="mt-3">
                                    <a href="/orders/${bill.id}" class="btn btn-outline-primary btn-sm">
                                        <i class="fas fa-eye me-1"></i>Xem chi tiết
                                    </a>
                                    
                                    <c:if test="${bill.status == 'PENDING' || bill.status == 'CONFIRMED'}">
                                        <button class="btn btn-outline-danger btn-sm ms-2" 
                                                onclick="cancelOrder(${bill.id})">
                                            <i class="fas fa-times me-1"></i>Hủy đơn hàng
                                        </button>
                                    </c:if>
                                    
                                    <c:if test="${bill.status == 'DELIVERED'}">
                                        <button class="btn btn-outline-success btn-sm ms-2">
                                            <i class="fas fa-star me-1"></i>Đánh giá
                                        </button>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="../layout/footer.jsp"/>

<script>
function cancelOrder(orderId) {
    if (confirm('Bạn có chắc chắn muốn hủy đơn hàng này?')) {
        fetch('/orders/' + orderId + '/cancel', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            }
        })
        .then(response => {
            if (response.ok) {
                location.reload();
            } else {
                alert('Có lỗi xảy ra khi hủy đơn hàng');
            }
        })
        .catch(error => {
            alert('Có lỗi xảy ra: ' + error.message);
        });
    }
}
</script>
</body>
</html>
