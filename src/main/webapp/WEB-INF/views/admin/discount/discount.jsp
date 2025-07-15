<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Discount</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-2 p-0">
            <jsp:include page="../layout/sidebar.jsp" />
        </div>

        <!-- Main Content -->
        <div class="col-10">
            <jsp:include page="../layout/header.jsp"/>
            <div class="p-4">
                <h2 class="mb-4">Quản Lý Discount</h2>

                <div class="d-flex justify-content-between mb-3">
                    <a class="btn btn-secondary" href="/Home">🏠 Trang chủ</a>
                    <button type="button" class="btn btn-success">➕ Thêm</button>
                </div>

                <!-- Form tìm kiếm -->
                <form class="row g-3 mb-4" method="get" action="/Discount/search">
                    <div class="col-auto">
                        <input type="text" class="form-control" name="id" placeholder="Tìm theo ID">
                    </div>
                    <div class="col-auto">
                        <button type="submit" class="btn btn-primary">🔍 Tìm kiếm</button>
                    </div>
                    <div class="col-auto">
                        <a href="/Discount" class="btn btn-outline-secondary">🔄 Tải lại bảng</a>
                    </div>
                </form>

                <!-- Bảng dữ liệu -->
                <div class="table-responsive">
                    <table class="table table-bordered table-striped table-hover align-middle">
                        <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Mã</th>
                            <th>Chi tiết</th>
                            <th>Giá trị giảm</th>
                            <th>Ngày bắt đầu</th>
                            <th>Ngày kết thúc</th>
                            <th>Giảm tối đa</th>
                            <th>Số lượt dùng tối đa</th>
                            <th>Giá trị đơn tối thiểu</th>
                            <th>Tỷ lệ (%)</th>
                            <th>Trạng thái</th>
                            <th>Loại giảm</th>
                            <th>Thao tác</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="discount" items="${discounts}">
                            <tr>
                                <td>${discount.id}</td>
                                <td>${discount.code}</td>
                                <td>${discount.detail}</td>
                                <td>${discount.amount}</td>
                                <td>${discount.startDate}</td>
                                <td>${discount.endDate}</td>
                                <td>${discount.maximumAmount}</td>
                                <td>${discount.maximumUsage}</td>
                                <td>${discount.minimumAmountInCart}</td>
                                <td>${discount.percentage}</td>
                                <td>
                                    <span class="badge ${discount.status == 'ACTIVE' ? 'bg-success' : 'bg-secondary'}">
                                            ${discount.status}
                                    </span>
                                </td>
                                <td>${discount.type}</td>
                                <td>
                                    <a href="/Discount/delete?id=${discount.id}"
                                       class="btn btn-sm btn-danger"
                                       onclick="return confirm('Bạn có chắc muốn xóa giảm giá này không?')">
                                        Xóa
                                    </a>
                                </td>
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
