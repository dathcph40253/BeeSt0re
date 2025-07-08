<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Dashboard</title>
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
<div class="container">
    <!-- Sidebar -->
    <jsp:include page="admin/layout/sidebar.jsp"/>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Top Bar -->
        <jsp:include page="admin/layout/header.jsp"/>

        <!-- Dashboard Content -->
        <div class="dashboard">
            <h1>Dashboard</h1>

            <!-- Stats Cards: Chỉ hiện với ROLE_ADMIN hoặc ROLE_EMPLOYEE -->
            <c:if test="${sessionScope.user.role.name == 'ROLE_ADMIN' || sessionScope.user.role.name == 'ROLE_EMPLOYEE'}">
                <div class="stats-cards">
                    <div class="card">
                        <div class="card-icon" style="background: #e3f2fd;">
                            <i class="fas fa-shopping-cart" style="color: #1976d2;"></i>
                        </div>
                        <div class="card-info">
                            <h3>Tổng đơn hàng</h3>
                            <p>1,234</p>
                            <span class="trend up">+15% <i class="fas fa-arrow-up"></i></span>
                        </div>
                    </div>
                    <div class="card">
                        <div class="card-icon" style="background: #e8f5e9;">
                            <i class="fas fa-dollar-sign" style="color: #2e7d32;"></i>
                        </div>
                        <div class="card-info">
                            <h3>Doanh thu</h3>
                            <p>45.6M VNĐ</p>
                            <span class="trend up">+8% <i class="fas fa-arrow-up"></i></span>
                        </div>
                    </div>
                    <div class="card">
                        <div class="card-icon" style="background: #fff3e0;">
                            <i class="fas fa-users" style="color: #f57c00;"></i>
                        </div>
                        <div class="card-info">
                            <h3>Khách hàng</h3>
                            <p>856</p>
                            <span class="trend up">+12% <i class="fas fa-arrow-up"></i></span>
                        </div>
                    </div>
                    <div class="card">
                        <div class="card-icon" style="background: #fce4ec;">
                            <i class="fas fa-box" style="color: #c2185b;"></i>
                        </div>
                        <div class="card-info">
                            <h3>Sản phẩm</h3>
                            <p>432</p>
                            <span class="trend down">-3% <i class="fas fa-arrow-down"></i></span>
                        </div>
                    </div>
                </div>
            </c:if>

            <!-- Đơn hàng gần đây: Luôn hiện với mọi role -->
            <div class="recent-orders">
                <div class="section-header">
                    <h2>Đơn hàng gần đây</h2>
                    <a href="/admin/order" class="view-all">Xem tất cả</a>
                </div>
                <div class="table-container">
                    <table>
                        <thead>
                        <tr>
                            <th>Mã đơn hàng</th>
                            <th>Khách hàng</th>
                            <th>Sản phẩm</th>
                            <th>Tổng tiền</th>
                            <th>Trạng thái</th>
                            <th>Thao tác</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>#ORD001</td>
                            <td>Nguyễn Văn A</td>
                            <td>3 sản phẩm</td>
                            <td>1,500,000 VNĐ</td>
                            <td><span class="status pending">Đang xử lý</span></td>
                            <td><button class="btn-view">Xem</button></td>
                        </tr>
                        <tr>
                            <td>#ORD002</td>
                            <td>Trần Thị B</td>
                            <td>2 sản phẩm</td>
                            <td>2,300,000 VNĐ</td>
                            <td><span class="status completed">Hoàn thành</span></td>
                            <td><button class="btn-view">Xem</button></td>
                        </tr>
                        <tr>
                            <td>#ORD003</td>
                            <td>Lê Văn C</td>
                            <td>1 sản phẩm</td>
                            <td>850,000 VNĐ</td>
                            <td><span class="status shipping">Đang giao</span></td>
                            <td><button class="btn-view">Xem</button></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>

        </div>
    </div>
</div>
</body>
</html>
