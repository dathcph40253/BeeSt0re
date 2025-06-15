<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
    <title>CreateProduct</title>
</head>
<body>
    <div class="container mt-5">
        <div class="row">
            <div class="col-md-6 col-12 mx-auto">
                <h3>CREATE PRODUCT</h3>
                <hr/>
                <form:form action="/product/create" method="post" modelAttribute="newProduct">
                    <div class="mb-3">
                        <label class="form-label">Tên sản phẩm</label>
                        <c:set var="errorName">
                            <form:errors path="name" cssClass="invalid-feedback"/>
                        </c:set>
                        <form:input type="text" class="form-control ${not empty errorName ? 'is-invalid':''}"
                                    placeholder="name product" path="name"/>
                        ${errorName}
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Mã sản phẩm</label>
                        <c:set var="errorCode">
                            <form:errors path="code" cssClass="invalid-feedback"/>
                        </c:set>
                        <form:input type="text" class="form-control ${not empty errorCode ? 'is-invalid' : ''}"
                                    placeholder="name product" path="code"/>

                        ${errorCode}
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Mô tả</label>
                        <form:input type="text" class="form-control" placeholder="name product" path="describe"/>
                    </div>
                    <div class="mt-3">
                        <label class="form-label">Danh mục</label>
                        <form:select path="category.id" items="${listCategory}" class="form-select">
                            <form:options itemValue="${category.id}" itemLabel="${category.name}"/>
                        </form:select>
                    </div>
                    <div class="mt-3">
                        <label class="form-label">Thương hiệu</label>
                        <form:select path="brand.id" items="${listBrand}" class="form-select">
                            <form:options itemValue="${brand.id}" itemLabel="${brand.name}"/>
                        </form:select>
                    </div>
                    <div class="mt-3">
                        <label class="form-label">Chất liệu</label>
                        <form:select path="material.id" items="${listMaterial}" class="form-select">
                            <form:options itemValue="${material.id}" itemLabel="${material.name}"/>
                        </form:select>
                    </div>
                    <div class="mt-3">

                        <form:radiobutton path="status" value="1" class="form-check-input"/>Active
                        <form:radiobutton path="status" value="0" class="form-check-input"/>Anactive
                    </div>
                    <button type="submit" class="btn btn-primary mt-3">Create</button>
                </form:form>
            </div>

        </div>
    </div>
</body>
</html>