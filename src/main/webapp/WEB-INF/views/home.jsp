<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>BeeStore - Trang Chủ</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
        }
        
        .sidebar {
            background-color: white;
            height: 100vh;
            width: 250px;
            position: fixed;
            left: 0;
            top: 0;
            padding-top: 20px;
            box-shadow: 2px 0 5px rgba(0,0,0,0.1);
            overflow-y: auto;
        }
        
        .logo-container {
            text-align: center;
            padding-bottom: 20px;
        }
        
        .menu-item {
            padding: 12px 20px;
            display: block;
            color: #333;
            text-decoration: none;
            transition: all 0.3s;
            border-left: 4px solid transparent;
        }
        
        .menu-item:hover {
            background-color: #f8f9fa;
            border-left: 4px solid #ffc107;
        }
        
        .menu-item i {
            margin-right: 10px;
            width: 20px;
            text-align: center;
        }
        
        /* Style cho menu dropdown */
        .dropdown-container {
            position: relative;
        }
        
        .menu-dropdown {
            display: block;
            margin-left: 20px;
            max-height: 0;
            overflow: hidden;
            transition: max-height 0.4s ease-in-out;
        }
        
        .dropdown-container:hover .menu-dropdown {
            max-height: 300px; /* Đủ cao để hiển thị tất cả các mục */
        }
        
        .dropdown-container:hover .menu-item {
            background-color: #f8f9fa;
            border-left: 4px solid #ffc107;
        }
        
        .menu-dropdown-item {
            padding: 10px 10px 10px 30px;
            display: block;
            color: #333;
            text-decoration: none;
            transition: all 0.3s;
            opacity: 0.9;
        }
        
        .menu-dropdown-item:hover {
            background-color: #f8f9fa;
            opacity: 1;
        }
        
        .menu-dropdown-item i {
            margin-right: 10px;
            width: 20px;
            text-align: center;
        }
        
        .menu-category {
            padding: 12px 20px;
            font-weight: bold;
            color: #dc3545;
            margin-top: 15px;
        }
        
        .main-content {
            margin-left: 250px;
            padding: 20px;
        }
        
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 20px;
            background-color: white;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            border-radius: 8px;
        }
        
        .user-info {
            display: flex;
            align-items: center;
        }
        
        .user-email {
            margin-right: 10px;
            color: #333;
        }
        
        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: #e9ecef;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #495057;
        }
        
        .dashboard-card {
            background-color: white;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }
        
        .welcome-card {
            background-color: #fff1f1;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            border: 1px solid #ffe0e0;
        }
        
        .stats-card {
            background-color: #fff1f1;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            text-align: center;
            border: 1px solid #ffe0e0;
        }
        
        .stats-number {
            font-size: 2.5rem;
            font-weight: bold;
            margin: 10px 0;
        }
        
        .stats-label {
            color: #666;
        }
        
        .stats-icon {
            font-size: 1.5rem;
            color: #333;
        }
        
        .action-card {
            background-color: #fff1f1;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            border: 1px solid #ffe0e0;
        }
        
        .action-title {
            font-size: 1.2rem;
            margin-bottom: 15px;
            color: #333;
        }
        
        .btn-action {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 5px;
            cursor: pointer;
        }
        
        .notification {
            background-color: #fff8e1;
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 20px;
            border-left: 4px solid #ffc107;
        }
        
        .message-top-right {
            position: fixed;
            top: 24px;
            right: 32px;
            background: #ffe0e0;
            color: #d8000c;
            padding: 10px 24px;
            border-radius: 8px;
            box-shadow: 0 2px 8px #bbb;
            font-weight: bold;
            z-index: 9999;
        }
        
        /* Logo BeeStore styling */
        .beestore-logo {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }
        
        .logo-circle {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            background-color: #ffd700;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            border: 3px solid #333;
        }
        
        .logo-text {
            font-weight: bold;
            font-size: 18px;
            margin-top: 5px;
            color: #333;
        }
        
        .logo-tshirt {
            width: 60px;
            height: 70px;
            background-color: white;
            position: relative;
        }
        
        .logo-star {
            position: absolute;
            color: #ffd700;
            font-size: 24px;
        }
        
        .star-top-left {
            top: 15px;
            left: 15px;
        }
        
        .star-bottom-right {
            bottom: 15px;
            right: 15px;
        }
        
        /* Thêm style cho dropdown menu */
        .dropdown-menu {
            border-radius: 8px;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
            padding: 0;
            overflow: hidden;
        }
        
        .dropdown-item {
            padding: 10px 20px;
            transition: all 0.2s;
        }
        
        .dropdown-item:hover {
            background-color: #f8f9fa;
        }
        
        .dropdown-item i {
            margin-right: 10px;
            width: 20px;
            text-align: center;
        }
        
        .dropdown-divider {
            margin: 0;
        }
        
        /* Style cho menu khác */
        .more-menu {
            position: relative;
        }
        
        .more-submenu {
            display: none;
            position: absolute;
            left: 100%;
            top: 0;
            width: 200px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
            z-index: 1000;
        }
        
        .more-menu:hover .more-submenu {
            display: block;
        }
        
        .submenu-item {
            padding: 12px 20px;
            display: block;
            color: #333;
            text-decoration: none;
            transition: all 0.3s;
        }
        
        .submenu-item:hover {
            background-color: #f8f9fa;
        }
        
        .submenu-item i {
            margin-right: 10px;
            width: 20px;
            text-align: center;
        }
        
        /* Style cho nút đăng nhập/đăng ký */
        .auth-buttons .btn {
            margin-left: 10px;
            font-weight: 500;
        }
        
        .btn-login {
            background-color: #fff;
            color: #333;
            border: 1px solid #ddd;
        }
        
        .btn-register {
            background-color: #ffc107;
            color: #333;
            border: none;
        }
        
        .btn-login:hover {
            background-color: #f8f9fa;
        }
        
        .btn-register:hover {
            background-color: #ffca2c;
        }
    </style>
</head>
<body>
    <c:if test="${not empty message}">
        <div id="message" class="message-top-right">${message}</div>
        <script>
            window.onload = function () {
                const x = document.getElementById("message");
                if(x){
                    setTimeout(() => {
                        x.style.display = "none";
                    }, 2000);
                }
            }
        </script>
    </c:if>

    <!-- Sidebar -->
    <div class="sidebar">
        <div class="logo-container">
            <!-- BeeStore Logo -->
            <div class="beestore-logo">
                <div class="logo-circle">
                    <i class="fas fa-star logo-star star-top-left"></i>
                    <div class="logo-tshirt">
                        <i class="fas fa-tshirt" style="font-size: 40px; color: #333;"></i>
                    </div>
                    <i class="fas fa-star logo-star star-bottom-right"></i>
                </div>
                <div class="logo-text">BeeStore</div>
            </div>
        </div>
        
        <a href="/BeeStore/Home" class="menu-item">
            <i class="fas fa-home"></i> Trang Chủ
        </a>
        
        <c:if test="${not empty user}">
            <!-- Menu cho khách hàng -->
            <c:if test="${user.role.name == 'ROLE_USER'}">
                <div class="menu-category">
                    <i class="fas fa-shopping-bag"></i> MUA SẮM
                </div>
                
                <a href="/BeeStore/Product" class="menu-item">
                    <i class="fas fa-tshirt"></i> Xem sản phẩm
                </a>
                
                <a href="#" class="menu-item">
                    <i class="fas fa-shopping-cart"></i> Giỏ hàng
                </a>
                
                <a href="#" class="menu-item">
                    <i class="fas fa-history"></i> Lịch sử mua hàng
                </a>
            </c:if>
            
            <!-- Menu cho nhân viên và admin -->
            <c:if test="${user.role.name != 'ROLE_USER'}">
                <div class="menu-category">
                    <i class="fas fa-cogs"></i> QUẢN LÝ
                </div>
                <div class="dropdown-container">
                    <a href="#" class="menu-item">
                        <i class="fas fa-box"></i> Quản lý sản phẩm
                    </a>
                    <div class="menu-dropdown">
                        <a href="/BeeStore/Category" class="menu-dropdown-item">
                            <i class="fas fa-list"></i> Loại sản phẩm
                        </a>
                        <a href="/BeeStore/Color" class="menu-dropdown-item">
                            <i class="fas fa-palette"></i> Màu sắc
                        </a>
                        <a href="/BeeStore/Material" class="menu-dropdown-item">
                            <i class="fas fa-layer-group"></i> Chất liệu
                        </a>
                        <a href="/BeeStore/Size" class="menu-dropdown-item">
                            <i class="fas fa-ruler"></i> Kích cỡ
                        </a>
                        <a href="/BeeStore/Brand" class="menu-dropdown-item">
                            <i class="fas fa-tag"></i> Nhãn hàng
                        </a>
                    </div>
                </div>
                
                <!-- Chỉ hiển thị cho Admin -->
                <c:if test="${user.role.name == 'ROLE_ADMIN'}">
                    <a href="/BeeStore/Discount" class="menu-item">
                        <i class="fas fa-percent"></i> Quản lý khuyến mãi
                    </a>
                    
                    <div class="dropdown-container">
                        <a href="#" class="menu-item">
                            <i class="fas fa-chart-bar"></i> Thống kê
                        </a>
                        <div class="menu-dropdown">
                            <a href="#" class="menu-dropdown-item">
                                <i class="fas fa-box-open"></i> Sản phẩm
                            </a>
                            <a href="#" class="menu-dropdown-item">
                                <i class="fas fa-file-invoice-dollar"></i> Hóa đơn
                            </a>
                        </div>
                    </div>
                    
                    <a href="/BeeStore/QuanLiNguoiDung" class="menu-item">
                        <i class="fas fa-users"></i> Quản lý tài khoản
                    </a>
                </c:if>
            </c:if>
            
            <a href="/BeeStore/Logout" class="menu-item">
                <i class="fas fa-sign-out-alt"></i> Đăng xuất
            </a>
        </c:if>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="header">
            <h4>Dashboard</h4>
            
            <!-- Hiển thị thông tin người dùng hoặc nút đăng nhập/đăng ký -->
            <c:choose>
                <c:when test="${not empty user}">
                    <!-- Nếu đã đăng nhập, hiển thị email và avatar -->
                    <div class="user-info">
                        <span class="user-email">${user.email != null ? user.email : 'admin@gmail.com'}</span>
                        <div class="user-avatar">
                            <a href="${pageContext.request.contextPath}/BeeStore/profile" >
                                <i class="fas fa-user"></i>
                            </a>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- Nếu chưa đăng nhập, hiển thị nút đăng nhập và đăng ký -->
                    <div class="auth-buttons">
                        <a href="/BeeStore/Login" class="btn btn-login">
                            <i class="fas fa-sign-in-alt"></i> Đăng nhập
                        </a>
                        <a href="/BeeStore/DangKy" class="btn btn-register">
                            <i class="fas fa-user-plus"></i> Đăng ký
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        
        <c:choose>
            <c:when test="${not empty user}">
                <!-- Nội dung khi đã đăng nhập -->
                <div class="welcome-card mt-4">
                    <h3>Xin chào ${user.name != null ? user.name : 'admin'}</h3>
                    <p>Dashboard</p>
                </div>

                <!-- Nội dung cho khách hàng -->
                <c:if test="${user.role.name == 'ROLE_USER'}">
                    <div class="notification mt-4">
                        <strong>Chào mừng!</strong> Bạn đã đăng nhập với tư cách khách hàng. Bạn có thể xem và mua sắm sản phẩm.
                    </div>

                    <div class="row mt-4">
                        <div class="col-md-6">
                            <div class="action-card">
                                <div class="action-title">Xem Sản Phẩm</div>
                                <p>Khám phá các sản phẩm mới nhất của chúng tôi.</p>
                                <a href="/BeeStore/Products" class="btn btn-primary mt-2">
                                    <i class="fas fa-shopping-bag me-2"></i>Xem ngay
                                </a>
                            </div>
                        </div>
                        
                        <div class="col-md-6">
                            <div class="action-card">
                                <div class="action-title">Giỏ Hàng</div>
                                <p>Xem giỏ hàng và thanh toán.</p>
                                <a href="#" class="btn btn-primary mt-2">
                                    <i class="fas fa-shopping-cart me-2"></i>Đi đến giỏ hàng
                                </a>
                            </div>
                        </div>
                    </div>
                </c:if>

                <!-- Nội dung cho nhân viên và admin -->
                <c:if test="${user.role.name != 'ROLE_USER'}">
                    <div class="notification mt-4">
                        <strong>Chú ý:</strong> Nhân viên không có quyền truy cập vào các mục Quản lý Khuyến Mãi, Thống Kê và Quản lý Tài Khoản
                    </div>

                    <h5 class="mt-4">* Mục nhân viên vào làm việc:</h5>

                    <div class="row mt-3">
                        <div class="col-md-4">
                            <div class="action-card">
                                <div class="action-title">Quản Lý Sản Phẩm</div>
                                <div class="dropdown mt-2">
                                    <button class="btn btn-success dropdown-toggle" type="button" id="dropdownQuanLySP" data-bs-toggle="dropdown" aria-expanded="false">
                                        Đi tới
                                    </button>
                                    <ul class="dropdown-menu" aria-labelledby="dropdownQuanLySP">
                                        <li><a class="dropdown-item" href="/BeeStore/Category">Danh sách sản phẩm</a></li>
                                        <li><a class="dropdown-item" href="#">Loại sản phẩm</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-md-4">
                            <div class="action-card">
                                <div class="action-title">Quản Lý Màu Sắc</div>
                                <div class="dropdown mt-2">
                                    <button class="btn btn-success dropdown-toggle" type="button" id="dropdownMauSac" data-bs-toggle="dropdown" aria-expanded="false">
                                        Đi tới
                                    </button>
                                    <ul class="dropdown-menu" aria-labelledby="dropdownMauSac">
                                        <li><a class="dropdown-item" href="/BeeStore/Color">Danh sách màu sắc</a></li>
                                        <li><a class="dropdown-item" href="/BeeStore/Color/add">Thêm màu sắc mới</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-md-4">
                            <div class="action-card">
                                <div class="action-title">Quản Lý Chất Liệu</div>
                                <div class="dropdown mt-2">
                                    <button class="btn btn-success dropdown-toggle" type="button" id="dropdownChatLieu" data-bs-toggle="dropdown" aria-expanded="false">
                                        Đi tới
                                    </button>
                                    <ul class="dropdown-menu" aria-labelledby="dropdownChatLieu">
                                        <li><a class="dropdown-item" href="/BeeStore/Material">Danh sách chất liệu</a></li>
                                        <li><a class="dropdown-item" href="#">Thêm chất liệu mới</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="row mt-3">
                        <div class="col-md-4">
                            <div class="action-card">
                                <div class="action-title">Quản Lý Kích Cỡ</div>
                                <div class="dropdown mt-2">
                                    <button class="btn btn-success dropdown-toggle" type="button" id="dropdownKichCo" data-bs-toggle="dropdown" aria-expanded="false">
                                        Đi tới
                                    </button>
                                    <ul class="dropdown-menu" aria-labelledby="dropdownKichCo">
                                        <li><a class="dropdown-item" href="/BeeStore/Size">Danh sách kích cỡ</a></li>
                                        <li><a class="dropdown-item" href="#">Thêm kích cỡ mới</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-md-4">
                            <div class="action-card">
                                <div class="action-title">Quản Lý Nhãn Hàng</div>
                                <div class="dropdown mt-2">
                                    <button class="btn btn-success dropdown-toggle" type="button" id="dropdownNhanHang" data-bs-toggle="dropdown" aria-expanded="false">
                                        Đi tới
                                    </button>
                                    <ul class="dropdown-menu" aria-labelledby="dropdownNhanHang">
                                        <li><a class="dropdown-item" href="/BeeStore/Brand">Danh sách nhãn hàng</a></li>
                                        <li><a class="dropdown-item" href="#">Thêm nhãn hàng mới</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Chỉ hiển thị cho Admin -->
                    <c:if test="${user.role.name == 'ROLE_ADMIN'}">
                        <h5 class="mt-4">* Mục dành cho quản trị viên:</h5>
                        
                        <div class="row mt-3">
                            <div class="col-md-4">
                                <div class="action-card">
                                    <div class="action-title">Quản Lý Khuyến Mãi</div>
                                    <div class="dropdown mt-2">
                                        <button class="btn btn-warning dropdown-toggle" type="button" id="dropdownKhuyenMai" data-bs-toggle="dropdown" aria-expanded="false">
                                            Đi tới
                                        </button>
                                        <ul class="dropdown-menu" aria-labelledby="dropdownKhuyenMai">
                                            <li><a class="dropdown-item" href="/BeeStore/Discount">Danh sách khuyến mãi</a></li>
                                            <li><a class="dropdown-item" href="#">Tạo khuyến mãi mới</a></li>
                                            <li><a class="dropdown-item" href="#">Khuyến mãi theo sản phẩm</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-4">
                                <div class="action-card">
                                    <div class="action-title">Quản Lý Tài Khoản</div>
                                    <a href="/BeeStore/QuanLiNguoiDung" class="btn btn-warning mt-2" >
                                        <i class="fas fa-users me-2"></i>Đi tới
                                    </a>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="action-card">
                                    <div class="action-title">Thống Kê</div>
                                    <div class="dropdown mt-2">
                                        <button class="btn btn-warning dropdown-toggle" type="button" id="dropdownThongKe" data-bs-toggle="dropdown" aria-expanded="false">
                                            Đi tới
                                        </button>
                                        <ul class="dropdown-menu" aria-labelledby="dropdownThongKe">
                                            <li><a class="dropdown-item" href="#">Thống kê doanh thu</a></li>
                                            <li><a class="dropdown-item" href="#">Thống kê sản phẩm</a></li>
                                            <li><a class="dropdown-item" href="#">Thống kê hóa đơn</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </c:if>
            </c:when>
            <c:otherwise>
                <!-- Nội dung khi chưa đăng nhập -->
                <div class="welcome-card mt-4">
                    <h3>Chào mừng đến với BeeStore</h3>
                    <p>Vui lòng đăng nhập để truy cập đầy đủ tính năng</p>
                </div>
                
                <div class="row mt-4">
                    <div class="col-md-6">
                        <div class="action-card">
                            <div class="action-title">Đăng nhập</div>
                            <p>Đã có tài khoản? Đăng nhập để tiếp tục.</p>
                            <a href="/BeeStore/Login" class="btn-action">Đăng nhập</a>
                        </div>
                    </div>
                    
                    <div class="col-md-6">
                        <div class="action-card">
                            <div class="action-title">Đăng ký</div>
                            <p>Chưa có tài khoản? Đăng ký ngay.</p>
                            <a href="/BeeStore/DangKy" class="btn-action">Đăng ký</a>
                        </div>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Font Awesome -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
</body>
</html>
