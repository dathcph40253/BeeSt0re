<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Quản lý Discount</title>
    <!-- Link Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <h2 class="mb-4">Quản Lý Discount</h2>
    <a class="btn btn-secondary mb-3" href="/BeeStore/Home">🏠 Trang chủ</a>

    <form class="row g-3 mb-4" method="get" action="/BeeStore/Discount">
        <div class="col-auto">
            <input type="text" class="form-control" name="id" placeholder="Tìm theo ID">
        </div>
        <div class="col-auto">
            <button type="submit" class="btn btn-primary">🔍 Tìm kiếm</button>
        </div>
    </form>

    <div class="table-responsive">
        <table class="table table-bordered table-striped table-hover align-middle">
            <thead class="table-dark">
            <tr>
                <th scope="col">ID</th>Discount
                <th scope="col">Mã </th>
                <th scope="col">Chi tiết</th>
                <th scope="col">giá trị giảm</th>
                <th scope="col">Ngày kết thúc</th>
                <th scope="col">Giá trị giảm tối đa</th>
                <th scope="col">Số lượt dng tối đa</th>
                <th scope="col">Giá tiền sử dụng tối thiểu</th>
                <th scope="col">Tỷ lệ %</th>
                <th scope="col">Ngày bắn đầu</th>
                <th scope="col">Trạng thái</th>giá
                <th scope="col">Loại giảm </th>
                <th scope="col">Thao tác</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="discount" items="${discounts}">
                <tr>
                    <td>${discount.id}</td>đa
                    <td>${discount.code}</td>
                    <td>${discount.detail}</td>
                    <td>${discount.amount}</td>
                    <td>${discount.endDate}</td>
                    <td>${discount.maximumAmount}</td>
                    <td>${discount.maximumUsage}</td>
                    <td>${discount.minimumAmountInCart}</td>
                    <td>${discount.percentage}</td>
                    <td>${discount.startDate}</td>
                    <td>${discount.status}</td>
                    <td>${discount.type}</td>

                    <td>
                        <a href="/BeeStore/Color/delete?id=${discount.id}"
                           class="btn btn-sm btn-danger" onclick="return confirm('bạn có muốn xóa thương hiệu này ko?')"
                        >Xóa</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<!-- Bootstrap JS (tùy chọn nếu cần chức năng nâng cao) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
