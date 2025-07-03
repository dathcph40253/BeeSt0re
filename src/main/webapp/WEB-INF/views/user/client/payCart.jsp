<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Thanh toán</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="/css/user/style.css">
    <link rel="stylesheet" href="/css/user/home.css">
    <link rel="stylesheet" href="/css/user/payCart.css">
</head>
<body>
<jsp:include page="../layout/header.jsp"/>
<div class="content">
    <h1 class="inf_title_paycart">Thông tin thanh toán</h1>
    <div class="contentPayCart">
        <div class="infPay">
            <div class="box_infPay">
                <p class="lable_infPay"><strong>Họ và tên</strong></p>
                <input type="text" placeholder="Nhập họ và tên của bạn" class="input_box_infPay">
            </div>
            <div class="box_sdt">
                <div class="item_infPays">
                    <p><strong>Số điện thoại</strong></p>
                    <input type="tel" name="" id="" placeholder="Nhập vào số điện thoại" class="input_box_sdt">
                </div>
                <div class="item_infPays">
                    <p><strong>Địa chỉ email</strong></p>
                    <input type="email" name="" id="" placeholder="Nhập địa chỉ email" class="input_box_sdt">
                </div>
            </div>
            <div class="box_infPay">
                <p class="lable_infPay"><strong>Nhập địa chỉ đơn hàng</strong></p>
                <input type="text" placeholder="Nhập họ và tên của bạn" class="input_box_sdt">
            </div>
            <div class="box_infPay">
                <p class="lable_infPay"><strong>Ghi chú đơn hàng (Tùy chọn)</strong></p>
                <textarea name="" id="" class="input_box_note" placeholder="Ghi chú đơn hàng"></textarea>
            </div>
        </div>
        <div class="detailPayCart">
            <div class="title_detail_cart">
                <p class="name_detail_cart">ĐƠN HÀNG CỦA BẠN</p>
            </div>
            <div class="content_detailPayCart">
                <div class="box_content_detailPayCart">
                    <p class="lable_detailPayCart">Sản phẩm</p>
                    <p class="lable_detailPayCart">Tạm tính</p>
                </div>
                <div class="box_content_detailPayCart">
                    <p class="lable_detailPayCart">T-Shirt The Universe - M</p>
                    <p class="lable_detailPayCart"> 280.000VND</p>
                </div>
                <div class="box_content_detailPayCart">
                    <div class="title_box_content">
                        <p class="lable_content">Tạm tính</p>
                        <p class="lable_content">Giao hàng</p>
                    </div>
                    <div class="title_box_content">
                        <p class="price_title_box">280.000VND</p>
                        <p><span class="lable_content">Đồng giá: </span>30.000VND</p>
                    </div>

                </div>
                <div class="box_content_detailPayCart">
                    <p class="lable_detailPayCart">Tổng cộng</p>
                    <p class="lable_detailPayCart">310.000VND</p>
                </div>
                <div class="checked_detailPayCart">
                    <input type="radio" id="javascript" name="hoc-js" value="JavaScript">
                    <p>Trả tiền mặt khi nhận hàng</p>
                </div>
                <div class="checked_detailPayCart">
                    <input type="radio" id="javascript" name="hoc-js" value="JavaScript">
                    <p>Chuyển khoản khi nhận hàng</p>
                </div>
                <div class="box_content_detailPayCart">
                    <div class="btn_back_detailPayCart">
                        <a href="./Cart.html">
                            <i class="fa-solid fa-arrow-left"></i>
                            <span>Quay lại giỏ hàng</span>
                        </a>
                    </div>

                    <a href="../src/accesPay.html" class="btn_payOnline">
                        <p>Đặt hàng</p>
                    </a>

                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="../layout/footer.jsp"/>
</body>
</html>