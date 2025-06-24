package com.example.demo.controller;

import com.example.demo.Entity.Product;
import com.example.demo.Entity.ProductDetail;
import com.example.demo.repository.ProductDetailRepo;
import com.example.demo.repository.ProductRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/BeeStore")
public class ProductController {

    @Autowired
    private ProductRepo productRepo;

    @Autowired
    private ProductDetailRepo productDetailRepo;

    @GetMapping("/Product")
    public String product(Model model) {
        List<Product> products = productRepo.findAll();
        model.addAttribute("products", products);
        return "product";
    }
    @GetMapping("/Product/detail/{id}")
    public String productDetail(@PathVariable Long id, Model model) {
        Product product = productRepo.findById(id).orElse(null);
        List<ProductDetail> productDetails = productDetailRepo.findByProductId(id);
        model.addAttribute("detail", productDetails);
        model.addAttribute("product", product);
        return "productDetail";

    }
}
