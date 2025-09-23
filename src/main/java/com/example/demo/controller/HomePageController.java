package com.example.demo.controller;

import com.example.demo.Entity.Product;
import com.example.demo.Entity.ProductDetail;
import com.example.demo.service.ProductDetailService;
import com.example.demo.service.ProductService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class HomePageController {   
    private final ProductDetailService productDetailService;
    private final ProductService productService;
    public HomePageController(ProductService productService, ProductDetailService productDetailService){
        this.productDetailService = productDetailService;
        this.productService = productService;
    }
    @GetMapping("")
    public String getHomePage(Model model){
        List<Product> products = productService.getAll();
        model.addAttribute("products", products);
        return "user/client/home";
    }

    @GetMapping("product/{id}")
    public String getProductDetail(@PathVariable("id") Long id, Model model){
        Product product = productService.getProductById(id);
        List<ProductDetail> productDetails = productDetailService.getProductByProductId(id);

        // Debug logging
        System.out.println("Product ID: " + id);
        System.out.println("Product Details found: " + productDetails.size());
        for (ProductDetail detail : productDetails) {
            System.out.println("Detail ID: " + detail.getId() +
                             ", Color: " + (detail.getColor() != null ? detail.getColor().getName() : "null") +
                             ", Size: " + (detail.getSize() != null ? detail.getSize().getName() : "null") +
                             ", Price: " + detail.getPrice() +
                             ", Quantity: " + detail.getQuantity());
        }

        model.addAttribute("product", product);
        model.addAttribute("details", productDetails);

        // Nếu không có product details, hiển thị trang với nút thêm
        if(productDetails.isEmpty()){
            return "user/client/detail-empty";
        }

        return "user/client/detail";
    }

    // Debug endpoint để kiểm tra ProductDetail
    @GetMapping("/debug/product-details/{productId}")
    @ResponseBody
    public String debugProductDetails(@PathVariable("productId") Long productId) {
        List<ProductDetail> details = productDetailService.getProductByProductId(productId);
        StringBuilder sb = new StringBuilder();
        sb.append("<h3>Product ID: ").append(productId).append("</h3>");
        sb.append("<p>Found <strong>").append(details.size()).append("</strong> product details:</p>");

        if (details.isEmpty()) {
            sb.append("<p style='color: red;'>❌ Không có ProductDetail nào cho sản phẩm này!</p>");
            sb.append("<p>Cần tạo ProductDetail trong Admin Panel:</p>");
            sb.append("<ol>");
            sb.append("<li>Vào Admin → Product Detail → Create</li>");
            sb.append("<li>Chọn Product ID: ").append(productId).append("</li>");
            sb.append("<li>Chọn Color và Size khác nhau</li>");
            sb.append("<li>Nhập Price và Quantity</li>");
            sb.append("</ol>");
        } else {
            sb.append("<table border='1' style='border-collapse: collapse; width: 100%;'>");
            sb.append("<tr style='background: #f0f0f0;'>");
            sb.append("<th>Detail ID</th><th>Color</th><th>Size</th><th>Price</th><th>Quantity</th>");
            sb.append("</tr>");

            for (ProductDetail detail : details) {
                sb.append("<tr>");
                sb.append("<td>").append(detail.getId()).append("</td>");
                sb.append("<td>").append(detail.getColor() != null ? detail.getColor().getName() : "❌ NULL").append("</td>");
                sb.append("<td>").append(detail.getSize() != null ? detail.getSize().getName() : "❌ NULL").append("</td>");
                sb.append("<td>").append(detail.getPrice()).append(" VND</td>");
                sb.append("<td>").append(detail.getQuantity()).append("</td>");
                sb.append("</tr>");
            }
            sb.append("</table>");

            // Thống kê màu sắc
            long uniqueColors = details.stream()
                .filter(d -> d.getColor() != null)
                .map(d -> d.getColor().getId())
                .distinct()
                .count();

            sb.append("<p><strong>Số màu unique:</strong> ").append(uniqueColors).append("</p>");

            if (uniqueColors <= 1) {
                sb.append("<p style='color: orange;'>⚠️ Chỉ có ").append(uniqueColors).append(" màu!</p>");
                sb.append("<p>Để có nhiều màu, cần tạo thêm ProductDetail với Color khác.</p>");
            }
        }

        return sb.toString();
    }

    // Chuyển cart và pay-cart sang CartController
    // @GetMapping("/cart") - đã chuyển sang CartController
    // @GetMapping("/pay-cart") - đã chuyển sang CartController với tên /cart/checkout
}
