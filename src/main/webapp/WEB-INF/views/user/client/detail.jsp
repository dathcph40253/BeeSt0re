<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Detail</title>
    <link rel="stylesheet" href="/css/user/home.css">
    <link rel="stylesheet" href="/css/user/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" type="text/css"
          href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick.min.css" />
    <link rel="stylesheet" type="text/css"
          href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick-theme.min.css" />
    <link rel="stylesheet" href="/css/user/detail.css">
</head>
<body>
<jsp:include page="../layout/header.jsp"/>
<div class="content">
    <div class="nofication" id="nofication"></div>
    <div class="content_detailProduct">
        <div class="img_product">
            <div class="image_detail_product">
                <img src="/images/product/${details[0].imageList[0].link}" alt="" class="image_shirt_detail">
                <img src="/images/product/${details[0].imageList[0].link}" alt="" class="image_shirt_detail">
                <img src="/images/product/${details[0].imageList[0].link}" alt="" class="image_shirt_detail">
                <img src="/images/product/${details[0].imageList[0].link}" alt="" class="image_shirt_detail">
                <img src="/images/product/${details[0].imageList[0].link}" alt="" class="image_shirt_detail">
                <img src="/images/product/${details[0].imageList[0].link}" alt="" class="image_shirt_detail">
            </div>
            <img src="/images/product/${details[0].imageList[0].link}" alt="" class="image_shirt">
        </div>
        <div class="inf_product">
            <h2 class="title_inf_products">${details[0].product.name}</h2>
            <p class="brand_inf_products">
                Thương hiệu: <span class="text-primary fw-semibold">${details[0].product.brand.name}</span>
            </p>
            <div class="product_overview">
                <div class="product_rating">
                    <span>5.0</span>
                    <span class="stars">★★★★★</span> 
                </div>
                <p class="total_inf_products">
                    Đã bán: <span class="total_color_inf">${totalSold}</span>
                </p>
            </div>
            <c:if test="${not empty details[0].product.productDetailList[0].productDiscount}">
                <div class="deal-banner">
                    <div class="deal-left">
                        <span class="deal-icon">⚡</span>
                        <span class="deal-text">Giá tốt hôm nay</span>
                    </div>
                    <div class="deal-right">
                        <span class="deal-end-text">KẾT THÚC TRONG</span>
                        <div class="deal-timer" id="timer-${details[0].product.id}" 
                            data-end="${details[0].product.productDetailList[0].productDiscount[0].endDateAsDate.time}">
                            Loading...
                        </div>
                    </div>
                </div>
            </c:if>
            <c:choose>
                <c:when test="${details[0].discountedPrice lt details[0].price}">
                <div class="price-box">
                    <p class="price_inf_products text-danger fw-bold">
                        ${details[0].discountedPrice}VND
                    </p>                            
                    <c:set var="percentOff" value="${(details[0].price - details[0].discountedPrice) * 100 / details[0].price}" />
                    <c:if test="${percentOff > 0}">
                        <span class="discount-badge-detail">-${percentOff.intValue()}%</span>
                    </c:if>
                </div>
                    <p class="price_inf_products text-muted text-decoration-line-through">
                        ${details[0].price}VND
                    </p>
                </c:when>
                <c:otherwise>
                    <p class="price_inf_products">${details[0].price}VND</p>
                </c:otherwise>
            </c:choose>
            <form id="addToCartForm">
                <div class="product-options">
                    <div class="color-section">
                        <p class="option-label">Màu sắc:</p>
                        <div class="color-options" id="colorOptions">
                            <!-- Colors will be populated by JavaScript -->
                        </div>
                    </div>

                    <div class="size-section">
                        <p class="option-label">Kích thước:</p>
                        <div class="size-options" id="sizeOptions">
                            <!-- Sizes will be populated by JavaScript -->
                        </div>
                    </div>

                    <input type="hidden" name="selectedDetail" id="selectedDetailId">
                </div>

                <p class="quantity_inf_products">Số lượng</p>
                <div class="quantity_box">
                    <div class="detail_quatity">
                        <div class="number_quantity">
                            <input type="number" id="quantity" name="quantity" value="1" min="1" max="10">
                        </div>
                        <div class="quantity">
                            <button type="button" class="totalProducts" onclick="increaseQuantity()">+</button>
                            <button type="button" class="totalProducts" onclick="decreaseQuantity()">-</button>
                        </div>
                        <p class="status_inf_products">
                            Tình trạng: <span class="status_color_inf">Còn hàng</span>
                        </p>
                    </div>
                    <button type="button" class="btn_quantity_box" onclick="addToCart()">
                        Thêm vào giỏ hàng
                    </button>
                </div>
            </form>

            <div class="inf_detailProducts">
                <p class="title_detai_products">Chi tiết sản phẩm</p>
                <ul class="box_detail_products_inf">
                    <li>- 100% Premium Cotton</li>
                    <li>
                        - Kỹ thuật in: Screen Printing + Puff Printing (In Nổi)
                    </li>
                    <li>
                        - Hình in được in với mực đạt chuẩn Eco Friendly và
                        an toàn cho người mặc.
                    </li>
                    <li>
                        - Vải được nhuộm với thuốc nhuộm thân thiện với
                        môi trường, giảm đến 70% lượng nước thải và an
                        toàn cho người mặc.
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>
<!-- Sản phẩm liên quan -->
<div class="Related_products">
    <h2 class="title_related_products">SẢN PHẨM LIÊN QUAN</h2>
    <div class="product_related">
        <c:forEach items="${relatedProducts}" var="product">
            <div class="item_product_related">
                <div class="image_home_item">
                    <a href="/product/${product.id}">
                        <img src="/images/product/${product.productDetailList[0].imageList[0].link}" 
                             alt="${product.name}" class="image_products_related">
                    </a>
                </div>
                <div class="boxname_product_related">
                    <p class="name_product_reletd">${product.name}</p>
                </div>

                <c:choose>
                    <c:when test="${product.productDetailList[0].discountedPrice lt product.productDetailList[0].price}">
                        <p class="name_product_reletd text-danger fw-bold">
                            ${product.productDetailList[0].discountedPrice}₫
                        </p>
                        <p class="name_product_reletd text-muted text-decoration-line-through">
                            ${product.productDetailList[0].price}₫
                        </p>
                    </c:when>
                    <c:otherwise>
                        <p class="name_product_reletd">
                            ${product.productDetailList[0].price}₫
                        </p>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:forEach>
    </div>
</div>

<jsp:include page="../layout/footer.jsp"/>

<style>
/* Product Options Styles */
.product-options {
    margin: 20px 0;
}

.color-section, .size-section {
    margin-bottom: 20px;
}

.option-label {
    font-weight: bold;
    margin-bottom: 10px;
    color: #333;
}

.color-options, .size-options {
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
}

.color-option, .size-option {
    margin: 0;
}

.color-label, .size-label {
    display: inline-block;
    padding: 8px 16px;
    border: 2px solid #ddd;
    border-radius: 25px;
    cursor: pointer;
    transition: all 0.3s ease;
    background: white;
    color: #333;
    font-size: 14px;
    min-width: 60px;
    text-align: center;
}

.color-label:hover, .size-label:hover {
    border-color: #667eea;
    background: #f8f9ff;
}

.color-radio:checked + .color-label,
.size-radio:checked + .size-label {
    background: #667eea;
    color: white;
    border-color: #667eea;
}

.color-radio, .size-radio {
    display: none;
}

.out-of-stock {
    opacity: 0.5;
    cursor: not-allowed;
    background: #f5f5f5 !important;
    color: #999 !important;
}

.out-of-stock-text {
    font-size: 0.8rem;
    color: #dc3545;
    display: block;
    margin-top: 2px;
}

/* Responsive */
@media (max-width: 768px) {
    .color-options, .size-options {
        gap: 8px;
    }

    .color-label, .size-label {
        padding: 6px 12px;
        font-size: 13px;
        min-width: 50px;
    }
}
</style>

<script>
    function showNotification(message, type = 'info') {
        const notification = document.getElementById('nofication');
        notification.textContent = message;
        notification.className = `nofication ${type}`;
        
        // Thêm class show để kích hoạt hiệu ứng
        notification.style.display = 'block';
        setTimeout(() => notification.classList.add('show'), 10);

        // Ẩn sau 3 giây
        setTimeout(() => {
            notification.classList.remove('show');
            setTimeout(() => {
                notification.style.display = 'none';
            }, 400); // chờ hiệu ứng fade-out
        }, 3000);
    }
function increaseQuantity() {
    const quantityInput = document.getElementById('quantity');
    if (!selectedDetailId) return;  
    const selectedDetail = productDetails.find(detail => detail.id === selectedDetailId);
    const maxQuantity = selectedDetail ? selectedDetail.quantity : 10;

    if (parseInt(quantityInput.value) < maxQuantity) {
        quantityInput.value = parseInt(quantityInput.value) + 1;
    }
}

function decreaseQuantity() {
    const quantityInput = document.getElementById('quantity');
    if (parseInt(quantityInput.value) > 1) {
        quantityInput.value = parseInt(quantityInput.value) - 1;
    }
}

// Dữ liệu sản phẩm từ server
const productDetails = [];
<c:forEach items="${details}" var="detail">
<c:if test="${detail.color != null && detail.size != null}">
productDetails.push({
    id: ${detail.id},
    colorId: ${detail.color.id},
    colorName: '${detail.color.name}',
    sizeId: ${detail.size.id},
    sizeName: '${detail.size.name}',
    price: ${detail.price},
    discountedPrice : ${detail.discountedPrice},
    quantity: ${detail.quantity}
});
</c:if>
</c:forEach>

// Fallback data for testing if no server data
if (productDetails.length === 0) {
    console.log('No server data found, using test data');
    productDetails.push(
        {
            id: 1,
            colorId: 1,
            colorName: 'Đỏ',
            sizeId: 1,
            sizeName: 'S',
            price: 300000,
            quantity: 10
        },
        {
            id: 2,
            colorId: 1,
            colorName: 'Đỏ',
            sizeId: 2,
            sizeName: 'M',
            price: 300000,
            quantity: 5
        },
        {
            id: 3,
            colorId: 2,
            colorName: 'Xanh',
            sizeId: 1,
            sizeName: 'S',
            price: 320000,
            quantity: 8
        }
    );
}

let selectedColorId = null;
let selectedSizeId = null;
let selectedDetailId = null;

// Debug: Log dữ liệu ngay khi script load
console.log('=== DEBUG: Product Details ===');
console.log('Raw productDetails array:', productDetails);
console.log('Array length:', productDetails.length);
if (productDetails.length > 0) {
    console.log('First item:', productDetails[0]);
    console.log('Sample color info:', {
        colorId: productDetails[0].colorId,
        colorName: productDetails[0].colorName
    });
}

// Khởi tạo khi trang load
document.addEventListener('DOMContentLoaded', function() {
    console.log('=== DOM LOADED ===');
    console.log('Product details from server:', productDetails);

    // Kiểm tra các element có tồn tại không
    const colorContainer = document.getElementById('colorOptions');
    const sizeContainer = document.getElementById('sizeOptions');
    console.log('Color container found:', !!colorContainer);
    console.log('Size container found:', !!sizeContainer);

    initializeProductOptions();
    updateCartCount();
});

function initializeProductOptions() {
    // Kiểm tra xem có dữ liệu không
    if (productDetails.length === 0) {
        console.log('No product details found');
        document.getElementById('colorOptions').innerHTML = '<p>Không có biến thể sản phẩm</p>';
        document.getElementById('sizeOptions').innerHTML = '';
        return;
    }

    // Tạo danh sách màu unique
    createColorOptions();

    // Chọn màu đầu tiên mặc định
    setTimeout(() => {
        const firstColorRadio = document.querySelector('input[name="selectedColor"]');
        console.log('Looking for first color radio...');
        console.log('Found radio:', !!firstColorRadio);

        if (firstColorRadio) {
            console.log('Radio value before parse:', firstColorRadio.value, 'type:', typeof firstColorRadio.value);
            firstColorRadio.checked = true;
            selectedColorId = parseInt(firstColorRadio.value);
            console.log('Initial color selected:', selectedColorId, 'from value:', firstColorRadio.value);

            if (isNaN(selectedColorId)) {
                console.error('❌ selectedColorId is NaN! Radio value:', firstColorRadio.value);
                return;
            }

            // Trigger change event để highlight màu đầu tiên
            firstColorRadio.dispatchEvent(new Event('change'));

            updateSizeOptions();
        } else {
            console.error('❌ No color radio found!');
        }
    }, 100); // Đợi DOM được tạo xong
}

function createColorOptions() {
    const colorOptionsContainer = document.getElementById('colorOptions');
    colorOptionsContainer.innerHTML = '';

    console.log('=== CREATE COLOR OPTIONS ===');

    // Lấy danh sách màu unique
    const uniqueColors = [];
    const seenColorIds = new Set();

    productDetails.forEach(detail => {
        if (detail.colorId && detail.colorName && !seenColorIds.has(detail.colorId)) {
            seenColorIds.add(detail.colorId);
            uniqueColors.push({
                id: detail.colorId,
                name: detail.colorName
            });
        }
    });

    console.log('Unique colors found:', uniqueColors);

    console.log('Unique colors found:', uniqueColors);

    if (uniqueColors.length === 0) {
        colorOptionsContainer.innerHTML = '<p class="text-muted">Chưa có thông tin màu sắc</p>';
        return;
    }

    // Thông báo nếu chỉ có 1 màu
    if (uniqueColors.length === 1) {
        console.log('⚠️ Chỉ có 1 màu duy nhất cho sản phẩm này');
    }

    // Tạo HTML cho từng màu
    uniqueColors.forEach((color, index) => {
        const colorDiv = document.createElement('div');
        colorDiv.className = 'color-option';
        colorDiv.style.display = 'inline-block';
        colorDiv.style.margin = '5px';

        console.log('Creating color option:', color.id, color.name, 'type:', typeof color.id);

        // Tạo radio button trực tiếp thay vì innerHTML
        const radioInput = document.createElement('input');
        radioInput.type = 'radio';
        radioInput.name = 'selectedColor';
        radioInput.value = color.id.toString(); // Đảm bảo value là string
        radioInput.id = `color_${color.id}`;
        radioInput.className = 'color-radio';
        radioInput.style.display = 'none'; // Ẩn radio button thật

        // Thêm event listener cho radio
        radioInput.addEventListener('change', function() {
            console.log('🔄 Radio change event for:', color.name, 'checked:', this.checked);

            // Cập nhật style cho tất cả label
            document.querySelectorAll('.color-label').forEach(lbl => {
                lbl.style.backgroundColor = '#fff';
                lbl.style.borderColor = '#ddd';
                lbl.style.color = '#333';
            });

            // Highlight label được chọn
            if (this.checked) {
                console.log('✅ Highlighting:', color.name);
                label.style.backgroundColor = '#007bff';
                label.style.borderColor = '#007bff';
                label.style.color = '#fff';

                // ⭐ QUAN TRỌNG: Cập nhật selectedColorId và gọi updateSizeOptions
                selectedColorId = parseInt(this.value);
                console.log('🎯 Updated selectedColorId to:', selectedColorId);
                updateSizeOptions();
                updateProductInfo();
            }
        });

        const label = document.createElement('label');
        label.htmlFor = `color_${color.id}`;
        label.className = 'color-label';
        label.style.cursor = 'pointer';
        label.style.display = 'inline-block';
        label.style.padding = '8px 16px';
        label.style.margin = '5px';
        label.style.border = '2px solid #ddd';
        label.style.borderRadius = '20px';
        label.style.transition = 'all 0.3s ease';
        label.style.position = 'relative';
        label.style.zIndex = '10';
        label.style.userSelect = 'none';

        // Thêm click event trực tiếp cho label
        label.addEventListener('click', function(e) {
            console.log('🖱️ Label clicked for color:', color.name, color.id);
            e.preventDefault();
            radioInput.checked = true;
            radioInput.dispatchEvent(new Event('change'));
        });

        // Thêm hover effect
        label.addEventListener('mouseenter', function() {
            console.log('🖱️ Mouse enter:', color.name);
            if (!radioInput.checked) {
                this.style.borderColor = '#007bff';
                this.style.backgroundColor = '#f8f9fa';
            }
        });

        label.addEventListener('mouseleave', function() {
            if (!radioInput.checked) {
                this.style.borderColor = '#ddd';
                this.style.backgroundColor = '#fff';
            }
        });

        const span = document.createElement('span');
        span.className = 'color-name';
        span.textContent = color.name;
        span.style.pointerEvents = 'none'; // Đảm bảo click đi qua label

        label.appendChild(span);
        colorDiv.appendChild(radioInput);
        colorDiv.appendChild(label);

        console.log('Radio created with value:', radioInput.value, 'type:', typeof radioInput.value);

        colorOptionsContainer.appendChild(colorDiv);
    });
}

// Xử lý khi chọn màu và size (sử dụng event delegation)
document.addEventListener('change', function(e) {
    console.log('Change event:', e.target.name, e.target.value);

    if (e.target.name === 'selectedColor') {
        selectedColorId = parseInt(e.target.value);
        selectedSizeId = null;
        console.log('Color changed to:', selectedColorId, 'from value:', e.target.value);

        if (isNaN(selectedColorId)) {
            console.error('❌ selectedColorId is NaN! Target value:', e.target.value);
            return;
        }

        updateSizeOptions();
        updateProductInfo();
    } else if (e.target.name === 'selectedSize') {
        selectedSizeId = e.target.value === 'null' ? null : parseInt(e.target.value);
        console.log('Size changed to:', selectedSizeId, 'from value:', e.target.value);

        if (selectedSizeId !== null && isNaN(selectedSizeId)) {
            console.error('❌ selectedSizeId is NaN! Target value:', e.target.value);
            return;
        }

        updateProductInfo();
    }
});

function updateSizeOptions() {
    const sizeOptionsContainer = document.getElementById('sizeOptions');
    console.log('=== UPDATE SIZE OPTIONS ===');
    console.log('Selected color ID:', selectedColorId);
    console.log('Size container found:', !!sizeOptionsContainer);

    if (!sizeOptionsContainer) {
        console.error('❌ Size options container not found!');
        return;
    }

    console.log('Clearing size container...');
    sizeOptionsContainer.innerHTML = '';

    if (!selectedColorId) {
        sizeOptionsContainer.innerHTML = '<p class="text-muted">Vui lòng chọn màu sắc trước</p>';
        return;
    }

    // Lấy các size có sẵn cho màu đã chọn
    console.log('Filtering productDetails for colorId:', selectedColorId);
    console.log('All productDetails:', productDetails);

    const availableSizes = productDetails
        .filter(detail => {
            console.log('Checking detail:', detail.colorId, '===', selectedColorId, '?', detail.colorId === selectedColorId);
            return detail.colorId === selectedColorId;
        })
        .map(detail => {
            console.log('Mapping detail to size:', {
                sizeId: detail.sizeId,
                sizeName: detail.sizeName,
                quantity: detail.quantity
            });
            return {
                id: detail.sizeId,
                name: detail.sizeName,
                quantity: detail.quantity
            };
        })
        .filter(size => {
            const isValid = size.id && size.name;
            console.log('Size validation:', size, 'valid:', isValid);
            return isValid;
        });

    console.log('Available sizes for color:', availableSizes);

    // Loại bỏ size trùng lặp
    let uniqueSizes = availableSizes.filter((size, index, self) =>
        index === self.findIndex(s => s.id === size.id)
    );

    console.log('Unique sizes:', uniqueSizes);

    if (uniqueSizes.length === 0) {
        console.log('❌ No sizes found for color ID:', selectedColorId);

        // Tạo size mặc định nếu không có size
        const defaultSize = {
            id: null,
            name: 'Kích thước duy nhất',
            quantity: productDetails.find(d => d.colorId === selectedColorId)?.quantity || 0
        };

        console.log('Creating default size:', defaultSize);
        uniqueSizes = [defaultSize];
    }

    console.log('✅ Creating', uniqueSizes.length, 'size options');
    uniqueSizes.forEach((size, index) => {
        console.log('Creating size button:', size.name, 'ID:', size.id);

        const sizeDiv = document.createElement('div');
        sizeDiv.className = 'size-option';

        const isOutOfStock = size.quantity === 0;
        const sizeClass = isOutOfStock ? 'size-label out-of-stock' : 'size-label';
        const sizeName = size.name && size.name.trim().length > 0 ? size.name.trim() : 'Không rõ';

        // ✅ FIX: Xử lý trường hợp size.id là null
        const sizeIdValue = size.id !== null ? size.id : 'null';
        const sizeIdAttr = size.id !== null ? size.id : 'default';

        console.log('Size values - ID:', size.id, 'Name:', sizeName, 'IdValue:', sizeIdValue, 'IdAttr:', sizeIdAttr);

        // Tạo HTML bằng string concatenation thay vì template literal
        const disabledAttr = isOutOfStock ? 'disabled' : '';
        const outOfStockHTML = isOutOfStock ? '<span class="out-of-stock-text">(Hết hàng)</span>' : '';

        const htmlString = '<input type="radio" name="selectedSize" value="' + sizeIdValue + '"' +
            ' id="size_' + sizeIdAttr + '" class="size-radio" ' + disabledAttr + '>' +
            '<label for="size_' + sizeIdAttr + '" class="' + sizeClass + '">' +
            '<span class="size-name">' + sizeName + '</span>' +
            outOfStockHTML +
            '</label>';

        console.log('About to set innerHTML with:', {
            sizeIdValue: sizeIdValue,
            sizeIdAttr: sizeIdAttr,
            sizeName: sizeName,
            sizeClass: sizeClass,
            htmlString: htmlString
        });

        sizeDiv.innerHTML = htmlString;

        console.log('HTML created:', sizeDiv.innerHTML);

        console.log('Appending size div to container...');
        sizeOptionsContainer.appendChild(sizeDiv);

        console.log("SIZE:", size);
        console.log('Size div appended successfully');

        // Chọn size đầu tiên có sẵn
        if (index === 0 && !isOutOfStock) {
            console.log('Setting first size as selected:', size.name);
            const radio = sizeDiv.querySelector('input[type="radio"]');
            if (radio) {
                radio.checked = true;
                selectedSizeId = size.id; // Giữ nguyên giá trị gốc (có thể là null)
                console.log('Selected size ID set to:', selectedSizeId);
            }
        }
    });

    updateProductInfo();
}

function updateProductInfo() {
    if (!selectedColorId || selectedSizeId === undefined) return;

    // Tìm product detail tương ứng
    const selectedDetail = productDetails.find(detail =>
        detail.colorId === selectedColorId &&
        (selectedSizeId === null ? true : detail.sizeId === selectedSizeId)
    );

    if (selectedDetail) {
        selectedDetailId = selectedDetail.id;
        document.getElementById('selectedDetailId').value = selectedDetailId;

        // Cập nhật giá
const displayPrice = selectedDetail.discountedPrice < selectedDetail.price
    ? selectedDetail.discountedPrice
    : selectedDetail.price;

document.querySelector('.price_inf_products').textContent =
    new Intl.NumberFormat('vi-VN').format(displayPrice) + ' VND';

        // Cập nhật trạng thái tồn kho
        const statusElement = document.querySelector('.status_color_inf');
        if (selectedDetail.quantity > 0) {
            statusElement.textContent = `còn ` + selectedDetail.quantity + ' sản phẩm';
            statusElement.style.color = 'green';

            // Cập nhật max quantity cho input
            const quantityInput = document.getElementById('quantity');
            quantityInput.max = selectedDetail.quantity;
            if (parseInt(quantityInput.value) > selectedDetail.quantity) {
                quantityInput.value = selectedDetail.quantity;
            }
        } else {
            statusElement.textContent = 'hết hàng';
            statusElement.style.color = 'red';
        }
    }
}

function addToCart() {
    if (!selectedDetailId) {
        showNotification('Vui lòng chọn màu sắc và kích thước', 'error');
        return;
    }

    const quantity = document.getElementById('quantity').value;
    const selectedDetail = productDetails.find(detail => detail.id === selectedDetailId);

    if (!selectedDetail) {
        showNotification('Chi tiết sản phẩm không hợp lệ', 'error');
        return;
    }

    if (parseInt(quantity) > selectedDetail.quantity) {
        showNotification('Số lượng vượt quá tồn kho' + selectedDetail.quantity, 'error');
        return;
    }

    if (selectedDetail.quantity === 0 || parseInt(quantity) <= 0) {
        showNotification('Số lượng sản phẩm mua hàng phải lớn hơn 0 ', 'error');
        return;
    }


    fetch('/cart/add', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: 'productDetailId=' + selectedDetailId + '&quantity=' + quantity
    })
    .then(response => response.text())
    .then(data => {
        if (data.startsWith('success:')) {
            showNotification(data.replace('success:', ''), 'success');
            updateCartCount();
        } else if (data.startsWith('error:')) {
            if (data.includes('đăng nhập')) {
                if (showNotification('Vui lòng đăng nhập để thêm vào giỏ hàng', 'error')) {
                    window.location.href = '/Login';
                }
            } else {
                showNotification(data.replace('error:', ''), 'error');
            }
        }
    })
    .catch(error => {
        showNotification('Lỗi khi thêm vào giỏ hàng', 'error');
    });
}

function updateCartCount() {
    fetch('/cart/count')
    .then(response => response.text())
    .then(count => {
        // Cập nhật số lượng giỏ hàng trên header
        const cartBadge = document.getElementById('cartCount');
        if (cartBadge) {
            cartBadge.textContent = count;
            if (parseInt(count) > 0) {
                cartBadge.style.display = 'flex';
            } else {
                cartBadge.style.display = 'none';
            }
        }
    })
    .catch(error => {
        console.log('Error updating cart count:', error);
    });
}

// Cập nhật thông tin khi chọn variant khác
document.querySelectorAll('input[name="selectedDetail"]').forEach(radio => {
    radio.addEventListener('change', function() {
        const price = this.dataset.price;
        const quantity = this.dataset.quantity;

        // Cập nhật giá hiển thị
        document.querySelector('.price_inf_products').textContent = price + 'VND';

        // Cập nhật trạng thái tồn kho
        const statusElement = document.querySelector('.status_color_inf');
        if (parseInt(quantity) > 0) {
            statusElement.textContent = 'còn hàng (' + quantity + ')';
            statusElement.style.color = 'green';
        } else {
            statusElement.textContent = 'hết hàng';
            statusElement.style.color = 'red';
        }

        // Reset quantity về 1
        document.getElementById('quantity').value = 1;
        document.getElementById('quantity').max = quantity;
    });
});
document.addEventListener("DOMContentLoaded", function() {
    // Tìm tất cả các timer
    var timers = document.querySelectorAll("[data-end]");
    
    console.log("Found timers:", timers.length);
    
    timers.forEach(function(timer) {
        var endTime = parseInt(timer.getAttribute("data-end"));
        var dealBanner = timer.closest(".deal-banner");
        console.log("Timer element:", timer);
        console.log("End timestamp:", endTime);
        console.log("End date:", new Date(endTime).toLocaleString());
        
        function updateCountdown() {
            var now = Date.now();
            var remaining = endTime - now;
            
            if (remaining <= 0) {
                if(dealBanner) {
                    dealBanner.style.display = "none";
                }
                return;
            }
            
            // Tính tổng số giây còn lại
            var totalSeconds = Math.floor(remaining / 1000);
            
            // Tính số ngày, giờ, phút, giây
            var days = Math.floor(totalSeconds / (24 * 3600));
            var hours = Math.floor((totalSeconds % (24 * 3600)) / 3600);
            var minutes = Math.floor((totalSeconds % 3600) / 60);
            var seconds = totalSeconds % 60;
            
            console.log("Total seconds:", totalSeconds);
            console.log("Days:", days, "Hours:", hours, "Minutes:", minutes, "Seconds:", seconds);
            
            // Format với 2 chữ số
            var h = String(hours).padStart(2, '0');
            var m = String(minutes).padStart(2, '0');
            var s = String(seconds).padStart(2, '0');
            
            var displayText = '';

            // Nếu có ngày
            if (days > 0) {
                displayText += '<span class="time-box">' + days + '</span> ngày ';
            }

            // Thêm giờ, phút, giây với class time-box
            displayText +=
                '<span class="time-box">' + h + '</span>' +
                '<span class="colon">:</span>' +
                '<span class="time-box">' + m + '</span>' +
                '<span class="colon">:</span>' +
                '<span class="time-box">' + s + '</span>';

            // Gán vào innerHTML thay vì textContent để HTML được render
            
            timer.innerHTML = displayText;
            console.log("Display:", displayText);
        }
        
        // Chạy ngay
        updateCountdown();
        
        // Lặp mỗi giây
        setInterval(updateCountdown, 1000);
    });
});
</script>
</body>
</html>