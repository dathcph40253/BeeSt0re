<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script>
        $(document).ready(() => {
            const imageFile = $("#imgFile");
            //const orgImage = "${img.link}"
            // if(orgImage){
            //     const urlImage = "/images/product/" + orgImage;
            //     $("#imagePreview").attr("src", urlImage);
            //     $("#imagePreview").css({"display":"block"});
            // }
            imageFile.change(function (e){
                const imgURL = URL.createObjectURL(e.target.files[0]);
                $("#imagePreview").attr("src", imgURL);
                $("#imagePreview").css({"display":"block"});
            });
        });
    </script>
</head>
<body>
    <div class="container mt-5">
        <div class="row">
            <h3>Update Product Detail ${productDetail.id}</h3>
            <hr/>
            <form:form action="/product-detail/update" enctype="multipart/form-data"
                       method="post" modelAttribute="productDetail">

                <div>
                    <label class="form-label">ID</label>
                    <form:input path="id" class="form-control" readonly="true"/>
                </div>
                <div class="mt-3">
                    <label class="form-label">Sản phẩm</label>
                    <form:select path="product.id" items="${listProduct}" class="form-select">
                        <form:options itemValue="${product.id}" itemLabel="${product.name}"/>
                    </form:select>
                </div>
                <c:set var="errorPrice">
                    <form:errors path="price" cssClass="invalid-feedback"/>
                </c:set>
                <div class="mt-3">
                    <label class="form-label">Giá</label>
                    <form:input type = "text" path="price"
                                class="form-control ${not empty errorPrice ? 'is-invalid' : ''}"
                                placeholder="Nhập giá sản phẩm"/>
                </div>
                <c:set var="errorQuantity">
                    <form:errors path="quantity" cssClass="invalid-feedback"/>
                </c:set>
                <div class="mt-3">
                    <label class="form-label">Số lượng</label>
                    <form:input type = "text" path="quantity"
                                class="form-control ${not empty errorQuantity ? 'is-invalid' : ''}"
                                placeholder="Số lượng"/>
                </div>
                <div class="mt-3">
                    <label class="form-label">Size</label>
                    <form:select path="size.id" items="${listSize}" class="form-select">
                        <form:options itemValue="${size.id}" itemLabel="${size.name}"/>
                    </form:select>
                </div>
                <div class="mt-3">
                    <label class="form-label">Màu sắc</label>
                    <form:select path="color.id" items="${listColor}" class="form-select">
                        <form:options itemValue="${color.id}" itemLabel="${color.name}"/>
                    </form:select>
                </div>
                <div class="mt-3">
                    <label for="imgFile" class="form-label">Hình ảnh</label>
                    <input class="form-control" type="file" name="imgFile" id="imgFile" accept=".png, .jpg, .jpeg"/>
                </div>
                <div class="mt-3">
                    <c:forEach items="${productDetail.imageList}" var="img">
                        <img style="max-height: 250px; display: block" alt="image preview" id="imagePreview"
                             src="/images/product/${img.link}"
                        />
                    </c:forEach>
                </div>
                <div class="mt-3">
                    <button class="btn btn-primary">Update</button>
                </div>
            </form:form>
        </div>
    </div>
</body>
</html>