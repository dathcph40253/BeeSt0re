<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sản phẩm</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        .category-menu { height: 400px; overflow-y: auto; margin-bottom: 20px; }
        .category-item { cursor: pointer; padding: 10px; border-radius: 5px; transition: all 0.2s; }
        .category-item:hover, .category-item.active { background-color: #f0f0f0; font-weight: bold; }
        .product-card { min-height: 350px; margin-bottom: 20px; }
        .filter-section { margin-bottom: 20px; }
        .category-menu a { text-decoration: none; color: inherit; color: #2E3A59}
    </style>
</head>
<body>

<jsp:include page="../layout/header.jsp"/>

<div class="container mt-5 mb-5">
    <div class="row">

        <!-- ================= Cột trái: Danh mục + Filter ================= -->
        <div class="col-md-3">
            <!-- Danh mục -->
            <div class="category-menu border p-3 rounded shadow-sm">
                <h5>Danh mục</h5>
                <c:forEach items="${categories}" var="category">
                    <a href="?categoryId=${category.id}" 
                       class="category-item d-block ${selectedCategoryId eq category.id ? 'active' : ''}">
                        ${category.name}
                    </a>
                </c:forEach>
                    <a href="/product" 
                       class="category-item d-block ${empty selectedCategoryId ? 'active' : ''}">
                        Tất cả sản phẩm
                    </a>
            </div>

            <!-- Bộ lọc -->
            <div class="filter-section border p-3 rounded shadow-sm">
                <h5>Lọc sản phẩm</h5>
                <form method="get" action="/product">
                    <input type="hidden" name="categoryId" value="${selectedCategoryId}" />

                    <div class="mb-3">
                        <label for="status" class="form-label">Trạng thái</label>
                        <select name="status" id="status" class="form-select">
                            <option value="">Tất cả</option>
                            <option value="1" ${selectedStatus eq '1' ? 'selected' : ''}>Còn hàng</option>
                            <option value="0" ${selectedStatus eq '0' ? 'selected' : ''}>Hết hàng</option>
                            <option value="sale" ${selectedStatus eq 'sale' ? 'selected' : ''}>Giảm giá</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label for="sortBy" class="form-label">Sắp xếp</label>
                        <select name="sortBy" id="sortBy" class="form-select">
                            <option value="newest" ${selectedSortBy eq 'newest' ? 'selected' : ''}>Mới nhất</option>
                            <option value="price_asc" ${selectedSortBy eq 'price_asc' ? 'selected' : ''}>Giá tăng dần</option>
                            <option value="price_desc" ${selectedSortBy eq 'price_desc' ? 'selected' : ''}>Giá giảm dần</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label for="keyword" class="form-label">Tìm kiếm</label>
                        <input type="text" name="keyword" id="keyword" value="${keyword}" class="form-control" placeholder="Tên sản phẩm...">
                    </div>

                    <button type="submit" class="btn btn-dark w-100">Áp dụng</button>
                </form>
            </div>
        </div>

        <!-- ================= Cột phải: Sản phẩm ================= -->
        <div class="col-md-9">
            <h4 class="mb-4">
                <c:choose>
                    <c:when test="${not empty selectedCategoryId}">
                        Sản phẩm: 
                        <c:forEach items="${categories}" var="c">
                            <c:if test="${c.id eq selectedCategoryId}">${c.name}</c:if>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        Tất cả sản phẩm
                    </c:otherwise>
                </c:choose>
            </h4>

            <div class="row g-4">
                <c:forEach items="${products}" var="product">
                    <div class="col-md-4 col-sm-6">
                        <div class="card product-card shadow-sm border-0">
                            <!-- Hình ảnh -->
                            <c:choose>
                                <c:when test="${not empty product.productDetailList and not empty product.productDetailList[0].imageList}">
                                    <img src="/images/product/${product.productDetailList[0].imageList[0].link}" 
                                         class="card-img-top" alt="${product.name}">
                                </c:when>
                                <c:otherwise>
                                    <img src="/images/no-image.png" class="card-img-top" alt="No image">
                                </c:otherwise>
                            </c:choose>

                            <div class="card-body text-center">
                                <h5 class="card-title">${product.name}</h5>
                                <p class="card-text mb-1">Nhà cung cấp: ${product.brand.name}</p>
                                <p class="card-text mb-2">
                                    Giá: 
                                    <c:set var="pd" value="${product.productDetailList[0]}" />
                                    <c:choose>
                                        <c:when test="${pd.discountedPrice lt pd.price}">
                                            <span class="text-muted text-decoration-line-through">${pd.price}₫</span>
                                            <span class="text-danger fw-bold ms-1">${pd.discountedPrice}₫</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-dark fw-bold">${pd.price}₫</span>
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                                <a href="/product/${product.id}" class="btn btn-outline-dark btn-sm">Xem chi tiết</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

    </div>
</div>

<jsp:include page="../layout/footer.jsp"/>

</body>
</html>
