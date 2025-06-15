<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<%--    <meta http-equiv="X-UA-Compatible" content="ie=edge">--%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <title>Page Product</title>
</head>
<body class="container">
    <h3>Manager Product</h3>
    <a href="/product/create" class="btn btn-success ">Tạo mới</a>
    <hr/>
    <table class="table table-bordered table-hover">
        <thead>
           <tr>
               <th>Mã sản phẩm</th>
               <th>Tên sản phẩm</th>
<%--               <th>Giá</th>--%>
               <th>Mô tả</th>
               <th>Ngày tạo</th>
               <th>Danh mục</th>
               <th>Thương hiệu</th>
               <th>Chất liệu</th>
               <th>Trạng thái</th>
               <th>Hành động</th>
           </tr>
        </thead>
        <tbody>
            <c:forEach items="${products}" var = "product">
                <tr>
                    <td>${product.code}</td>
                    <td>${product.name}</td>
<%--                    <td>${product.price}</td>--%>
                    <td>${product.describe}</td>
                    <td>${product.create_date}</td>
                    <td>${product.category.name}</td>
                    <td>${product.brand.name}</td>
                    <td>${product.material.name}</td>
                    <td>${product.status == 1 ? "Hoạt động" : "Ngừng hoạt động"}</td>
                    <td>
                        <a href="/product/update/${product.id}" class="btn btn-warning">Sửa</a>
                        <a href="/product/delete/${product.id}" class="btn btn-danger">Xóa</a>
                    </td>

                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>