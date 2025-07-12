<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Giảm giá theo Biến thể</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-2 p-0">
            <jsp:include page="../layout/sidebar.jsp"/>
        </div>

        <!-- Main Content -->
        <div class="col-10">
            <jsp:include page="../layout/header.jsp"/>
            <div class="p-4">
                <h2 class="mb-4">Quản lý Giảm giá theo Biến thể Sản phẩm</h2>

                <div class="d-flex justify-content-between mb-3">
                    <a class="btn btn-secondary" href="/Home">🏠 Trang chủ</a>
                    <button type="button" class="btn btn-success">
                        ➕ Thêm
                    </button>
                </div>

                <!-- Thông báo -->
                <c:if test="${not empty message}">
                    <div class="alert ${messageType == 'success' ? 'alert-success' : 'alert-danger'} alert-dismissible fade show" role="alert">
                            ${message}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <div class="table-responsive">
                    <table class="table table-bordered table-striped table-hover align-middle">
                        <thead class="table-dark">
                        <tr>
                            <th>STT</th>
                            <th>Sản phẩm</th>
                            <th>Thương hiệu</th>
                            <th>Chất liệu</th>
                            <th>Màu</th>
                            <th>Size</th>
                            <th>Giá gốc</th>
                            <th>Giá KM</th>
                            <th>Bắt đầu</th>
                            <th>Kết thúc</th>
                            <th>Trạng thái</th>
                            <th>Thao tác</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="detail" items="${productDetails}" varStatus="i">
                            <tr>
                                <td>${i.index + 1}</td>
                                <td>${detail.product.name}</td>
                                <td>${detail.product.brand.name}</td>
                                <td>${detail.product.material.name}</td>
                                <td>${detail.color.name}</td>
                                <td>${detail.size.name}</td>
                                <td>${detail.price}</td>
                                <form method="post" action="/BeeStore/Discount/update">
                                    <input type="hidden" name="productDetailId" value="${detail.id}" />
                                    <td>
                                        <input type="number" step="1000" class="form-control" name="discountedAmount"
                                               value="${detail.productDiscount != null ? detail.productDiscount.discountedAmount : ''}"/>
                                    </td>
                                    <td>
                                        <input type="datetime-local" class="form-control" name="startDate"
                                               value="${detail.productDiscount != null ? detail.productDiscount.startDate : ''}"/>
                                    </td>
                                    <td>
                                        <input type="datetime-local" class="form-control" name="endDate"
                                               value="${detail.productDiscount != null ? detail.productDiscount.endDate : ''}"/>
                                    </td>
                                    <td>
                                        <select name="closed" class="form-select">
                                            <option value="false"
                                                    <c:if test="${detail.productDiscount != null && !detail.productDiscount.closed}">selected</c:if>>
                                                Đang bật
                                            </option>
                                            <option value="true"
                                                    <c:if test="${detail.productDiscount != null && detail.productDiscount.closed}">selected</c:if>>
                                                Đã tắt
                                            </option>
                                        </select>
                                    </td>
                                    <td>
                                        <button type="submit" class="btn btn-primary btn-sm">Lưu</button>
                                    </td>
                                </form>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
