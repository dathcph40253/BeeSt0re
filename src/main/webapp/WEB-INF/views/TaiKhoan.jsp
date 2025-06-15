<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Quản lý Người Dùng</title>
</head>
<body>
<h2>Quản lý Người Dùng</h2>
<a href="/BeeStore/Home">Trang chủ</a>

<form method="get" action="/BeeStore/QuanLiNguoiDung">
    <input type="text" name="id" placeholder="Tìm theo id"/>
    <button type="submit">Tìm kiếm</button>
</form>

<table border="1" cellpadding="5">
    <tr>
        <th>ID</th>
        <th>Tên tài khoản</th>
        <th>Email</th>
    </tr>
    <c:forEach var="acc" items="${users}">
        <tr>
            <td>${acc.id}</td>
            <td>${acc.name}</td>
            <td>${acc.email}</td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
