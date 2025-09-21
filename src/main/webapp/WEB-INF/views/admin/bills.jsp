<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách hóa đơn gần đây</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="/css/style.css">
    <style>
        .main-table {
            background: #fff;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0px 3px 8px rgba(0,0,0,0.1);
        }
        .main-table thead {
            background: #0d6efd;
            color: #fff;
        }
        .main-table tbody tr:hover {
            background: #f1f5ff !important;
        }
        .detail-row {
            background: #f9f9f9;
        }
        .detail-table thead {
            background: #e9ecef;
        }
    </style>
</head>
<body>
<jsp:include page="layout/sidebar.jsp"/>
<div class="main-content p-3">
    <jsp:include page="layout/header.jsp"/>
    <h3 class="mb-3">
        <i class="fa-solid fa-file-invoice text-primary me-2"></i> Hóa đơn
    </h3>
    
    <table class="table table-bordered table-striped main-table">
        <thead>
            <tr>
                <th>Mã hóa đơn</th>
                <th>Khách hàng</th>
                <th>Ngày tạo</th>
                <th class="text-end">Tổng tiền</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="bill" items="${recentBills}">
                <!-- Hóa đơn -->
                <tr data-bs-toggle="collapse" data-bs-target="#bill-${bill.id}" style="cursor: pointer;">
                    <td><i class="fa-solid fa-receipt me-2 text-primary"></i>${bill.code}</td>
                    <td><c:out value="${bill.customer != null ? bill.customer.name : 'Khách lẻ'}"/></td>
                    <td><fmt:formatDate value="${bill.createDateAsDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                    <td class="text-end fw-bold text-success">
                        <fmt:formatNumber value="${bill.finalAmount}" type="number"/> đ
                    </td>
                </tr>

                <!-- Chi tiết hóa đơn (ẩn/hiện khi click) -->
                <tr class="collapse detail-row" id="bill-${bill.id}">
                    <td colspan="4">
                        <table class="table table-sm table-bordered detail-table mb-0">
                            <thead>
                                <tr>
                                    <th>Sản phẩm</th>
                                    <th>Màu</th>
                                    <th>Size</th>
                                    <th class="text-center">Số lượng</th>
                                    <th class="text-end">Giá tại thời điểm</th>
                                    <th class="text-end">Thành tiền</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="detail" items="${bill.billDetails}">
                                    <tr>
                                        <td>${detail.productName}</td>
                                        <td>${detail.productColor}</td>
                                        <td>${detail.productSize}</td>
                                        <td class="text-center">${detail.quantity}</td>
                                        <td class="text-end">
                                            <fmt:formatNumber value="${detail.momentPrice}" type="number"/> đ
                                        </td>
                                        <td class="text-end fw-bold">
                                            <fmt:formatNumber value="${detail.totalPrice}" type="number"/> đ
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
