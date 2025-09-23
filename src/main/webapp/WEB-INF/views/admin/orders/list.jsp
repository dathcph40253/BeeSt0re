<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý đơn hàng - Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="/css/style.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <style>
        .orders-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding: 20px 0;
            border-bottom: 2px solid #f8f9fa;
        }
        
        .page-title {
            color: #2c3e50;
            font-weight: 600;
            margin: 0;
        }
        
        .status-filter {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }
        
        .status-btn {
            padding: 8px 16px;
            border: 1px solid #dee2e6;
            background: white;
            color: #6c757d;
            text-decoration: none;
            border-radius: 5px;
            transition: all 0.3s;
        }
        
        .status-btn:hover, .status-btn.active {
            background: #007bff;
            color: white;
            border-color: #007bff;
            text-decoration: none;
        }
        
        .order-status {
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
            text-transform: uppercase;
        }
        
        .status-pending { background: #fff3cd; color: #856404; }
        .status-confirmed { background: #d1ecf1; color: #0c5460; }
        .status-processing { background: #d4edda; color: #155724; }
        .status-shipping { background: #e2e3e5; color: #383d41; }
        .status-delivered { background: #d1e7dd; color: #0f5132; }
        .status-cancelled { background: #f8d7da; color: #721c24; }
        
        .main-table {
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .main-table th {
            background: #f8f9fa;
            border: none;
            padding: 15px;
            font-weight: 600;
            color: #495057;
        }
        
        .main-table td {
            padding: 15px;
            border-top: 1px solid #dee2e6;
            vertical-align: middle;
        }
        
        .order-code {
            font-weight: 600;
            color: #007bff;
        }
        
        .amount-text {
            font-weight: 600;
            font-size: 16px;
        }
        
        .btn-action {
            margin-right: 5px;
        }
    </style>
</head>
<body style="min-height: 100vh; display: flex">
    <jsp:include page="../layout/sidebar.jsp"/>
    
    <div class="main-content">
        <jsp:include page="../layout/header.jsp"/>
        
        <!-- Orders Header -->
        <div class="orders-header">
            <h3 class="page-title">
                <i class="fa-solid fa-clipboard-list text-primary me-2"></i> Quản lý đơn hàng
            </h3>
        </div>

        <!-- Success/Error Messages -->
        <c:if test="${not empty success}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle me-2"></i>${success}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i>${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        
        <!-- Status Filter -->
        <div class="status-filter">
            <a href="/admin/orders" class="status-btn ${empty selectedStatus ? 'active' : ''}">
                <i class="fas fa-list me-1"></i>Tất cả
            </a>
            <a href="/admin/orders?status=PENDING" class="status-btn ${selectedStatus == 'PENDING' ? 'active' : ''}">
                <i class="fas fa-clock me-1"></i>Chờ xác nhận
            </a>
            <a href="/admin/orders?status=CONFIRMED" class="status-btn ${selectedStatus == 'CONFIRMED' ? 'active' : ''}">
                <i class="fas fa-check me-1"></i>Đã xác nhận
            </a>
            <a href="/admin/orders?status=PROCESSING" class="status-btn ${selectedStatus == 'PROCESSING' ? 'active' : ''}">
                <i class="fas fa-cog me-1"></i>Đang xử lý
            </a>
            <a href="/admin/orders?status=SHIPPING" class="status-btn ${selectedStatus == 'SHIPPING' ? 'active' : ''}">
                <i class="fas fa-truck me-1"></i>Đang giao
            </a>
            <a href="/admin/orders?status=DELIVERED" class="status-btn ${selectedStatus == 'DELIVERED' ? 'active' : ''}">
                <i class="fas fa-check-circle me-1"></i>Đã giao
            </a>
        </div>
        
        <!-- Orders Table -->
        <div class="table-responsive">
            <table class="table main-table">
                <thead>
                    <tr>
                        <th><i class="fas fa-hashtag me-2"></i>Mã đơn hàng</th>
                        <th><i class="fas fa-user me-2"></i>Khách hàng</th>
                        <th><i class="fas fa-calendar me-2"></i>Ngày đặt</th>
                        <th class="text-end"><i class="fas fa-money-bill me-2"></i>Tổng tiền</th>
                        <th class="text-center"><i class="fas fa-info-circle me-2"></i>Trạng thái</th>
                        <th class="text-center"><i class="fas fa-edit me-2"></i>Cập nhật trạng thái</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty bills}">
                            <tr>
                                <td colspan="6" class="text-center py-4">
                                    <i class="fas fa-inbox fa-3x text-muted mb-3"></i>
                                    <h5 class="text-muted">Không có đơn hàng nào</h5>
                                    <p class="text-muted">
                                        <c:choose>
                                            <c:when test="${not empty selectedStatus}">
                                                Không có đơn hàng với trạng thái "${selectedStatus}"
                                            </c:when>
                                            <c:otherwise>
                                                Chưa có đơn hàng nào trong hệ thống
                                            </c:otherwise>
                                        </c:choose>
                                    </p>
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="bill" items="${bills}">
                                <tr>
                                    <td>
                                        <span class="order-code">
                                            <i class="fa-solid fa-receipt me-2 text-primary"></i>${bill.code}
                                        </span>
                                    </td>
                                    <td>
                                        <i class="fas fa-user-circle me-2 text-muted"></i>
                                        <c:out value="${bill.customer != null ? bill.customer.name : 'Khách lẻ'}"/>
                                    </td>
                                    <td>
                                        <i class="fas fa-clock me-2 text-muted"></i>
                                        <fmt:formatDate value="${bill.createDateAsDate}" pattern="dd/MM/yyyy HH:mm"/>
                                    </td>
                                    <td class="text-end">
                                        <span class="amount-text text-success">
                                            <fmt:formatNumber value="${bill.finalAmount}" type="number"/> đ
                                        </span>
                                    </td>
                                    <td class="text-center">
                                        <c:choose>
                                            <c:when test="${bill.status == 'PENDING'}">
                                                <span class="order-status status-pending">Chờ xác nhận</span>
                                            </c:when>
                                            <c:when test="${bill.status == 'CONFIRMED'}">
                                                <span class="order-status status-confirmed">Đã xác nhận</span>
                                            </c:when>
                                            <c:when test="${bill.status == 'PROCESSING'}">
                                                <span class="order-status status-processing">Đang xử lý</span>
                                            </c:when>
                                            <c:when test="${bill.status == 'SHIPPING'}">
                                                <span class="order-status status-shipping">Đang giao</span>
                                            </c:when>
                                            <c:when test="${bill.status == 'DELIVERED'}">
                                                <span class="order-status status-delivered">Đã giao</span>
                                            </c:when>
                                            <c:when test="${bill.status == 'CANCELLED'}">
                                                <span class="order-status status-cancelled">Đã hủy</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="order-status">${bill.status}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-center">
                                        <div class="dropdown">
                                            <button class="btn btn-sm btn-outline-warning dropdown-toggle" type="button"
                                                    data-bs-toggle="dropdown" aria-expanded="false" title="Cập nhật trạng thái">
                                                <i class="fas fa-edit"></i> Cập nhật
                                            </button>
                                            <ul class="dropdown-menu">
                                                <li><a class="dropdown-item" href="#" onclick="updateStatus(${bill.id}, 'PENDING')">
                                                    <i class="fas fa-clock text-warning"></i> Chờ xác nhận
                                                </a></li>
                                                <li><a class="dropdown-item" href="#" onclick="updateStatus(${bill.id}, 'CONFIRMED')">
                                                    <i class="fas fa-check text-info"></i> Đã xác nhận
                                                </a></li>
                                                <li><a class="dropdown-item" href="#" onclick="updateStatus(${bill.id}, 'PROCESSING')">
                                                    <i class="fas fa-cog text-primary"></i> Đang xử lý
                                                </a></li>
                                                <li><a class="dropdown-item" href="#" onclick="updateStatus(${bill.id}, 'SHIPPING')">
                                                    <i class="fas fa-truck text-purple"></i> Đang giao hàng
                                                </a></li>
                                                <li><a class="dropdown-item" href="#" onclick="updateStatus(${bill.id}, 'DELIVERED')">
                                                    <i class="fas fa-check-circle text-success"></i> Đã giao hàng
                                                </a></li>
                                                <li><hr class="dropdown-divider"></li>
                                                <li><a class="dropdown-item" href="#" onclick="updateStatus(${bill.id}, 'CANCELLED')">
                                                    <i class="fas fa-times text-danger"></i> Hủy đơn hàng
                                                </a></li>
                                            </ul>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
        
        <!-- Back Button -->
        <div class="mt-4">
            <a href="/Home" class="btn btn-secondary">
                <i class="fas fa-arrow-left me-2"></i>Quay lại trang chủ
            </a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        function updateStatus(billId, newStatus) {
            if (confirm('Bạn có chắc chắn muốn cập nhật trạng thái đơn hàng này?')) {
                // Tạo form để submit
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '/admin/orders/' + billId + '/update-status';

                // Thêm CSRF token nếu cần
                const statusInput = document.createElement('input');
                statusInput.type = 'hidden';
                statusInput.name = 'status';
                statusInput.value = newStatus;
                form.appendChild(statusInput);

                // Submit form
                document.body.appendChild(form);
                form.submit();
            }
        }

        // Hiển thị thông báo nếu có
        document.addEventListener('DOMContentLoaded', function() {
            const urlParams = new URLSearchParams(window.location.search);
            const message = urlParams.get('message');
            if (message) {
                alert(decodeURIComponent(message));
            }
        });
    </script>
</body>
</html>
