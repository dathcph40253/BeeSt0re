package com.example.demo.controller;

import com.example.demo.Entity.Product;
import com.example.demo.Entity.ProductDetail;
import com.example.demo.service.ProductDetailService;
import com.example.demo.service.ProductService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

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

        model.addAttribute("product", product);
        model.addAttribute("details", productDetails);

        // Nếu không có product details, hiển thị trang với nút thêm
        if(productDetails.isEmpty()){
            return "user/client/detail-empty";
        }

        return "user/client/detail";
    }

    @GetMapping("/cart")
    public String getCartPage(){
        return "user/client/cart";
    }
    @GetMapping("/pay-cart")
    public String getPayCartPage(){
        return "user/client/payCart";
    }
}
