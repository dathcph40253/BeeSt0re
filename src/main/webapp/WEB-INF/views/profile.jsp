<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="from" uri="http://www.springframework.org/tags/form" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="/css/style.css">
    <title>Profile</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f0f2f5;
            padding: 40px;
        }

        .form-container {
            background-color: #fff;
            width: 400px;
            margin: auto;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 25px;
        }

        label {
            display: block;
            margin-bottom: 6px;
            font-weight: bold;
            color: #333;
        }

        input[type="text"] {
            width: 100%;
            padding: 10px 12px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 14px;
        }

        button {
            width: 100%;
            padding: 12px;
            background-color: #3498db;
            color: #fff;
            font-weight: bold;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #2980b9;
        }
    </style>
</head>
<body>
<div class="form-container">
    <h2>Cập nhật thông tin</h2>
    <form:form action="${pageContext.request.contextPath}/postFile" method="post" modelAttribute="InfoDto">
        <!-- Họ và tên -->
        <div class="mb-3">
            <label for="name" class="form-label">Họ và tên</label>
            <form:input path="name" type="text" cssClass="form-control" id="name"/>
            <form:errors path="name" cssClass="text-danger"/>
        </div>

        <!-- Số điện thoại -->
        <div class="mb-3">
            <label for="phoneNumber" class="form-label">Số điện thoại</label>
            <form:input path="phoneNumber" type="text" cssClass="form-control" id="phoneNumber"/>
            <form:errors path="phoneNumber" cssClass="text-danger"/>
        </div>
        <!-- địa chỉ -->
        <div class="mb-3">
            <label for="address" class="form-label">Địa chỉ</label>
            <form:input path="address" type="text" cssClass="form-control" id="address"/>
            <form:errors path="address" cssClass="text-danger"/>
        </div>
        <!-- Submit -->
        <button type="submit">Xác nhận</button>
    </form:form>
</div>
</body>
</html>
