package com.example.demo.controller;

import com.example.demo.Entity.Brand;
import com.example.demo.Entity.Category;
import com.example.demo.Entity.Material;
import com.example.demo.Entity.Product;
import com.example.demo.service.BrandService;
import com.example.demo.service.CategoryService;
import com.example.demo.service.MaterialService;
import com.example.demo.service.ProductService;
import jakarta.validation.Valid;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ProductController {
    private final ProductService productService;
    private final BrandService brandService;
    private final CategoryService categoryService;
    private final MaterialService materialService;

    public ProductController(ProductService productService, BrandService brandService,
                             CategoryService categoryService,
                             MaterialService materialService) {

        this.productService = productService;
        this.brandService = brandService;
        this.categoryService = categoryService;
        this.materialService = materialService;
    }

    @ModelAttribute("listBrand")
    public Map<Long, String> listBrand() {
        Map<Long, String> map = new HashMap<>();
        List<Brand> brands = brandService.getAllBrand();
        for(Brand brand : brands){
            map.put(brand.getId(), brand.getName());
        }
        return map;
    }

    @ModelAttribute("listCategory")
    public Map<Long, String> listCategory() {
        Map<Long, String> map = new HashMap<>();
        List<Category> categories = categoryService.getAllCategory();
        for(Category category : categories){
            map.put(category.getId(), category.getName());
        }
        return map;
    }


    @ModelAttribute("listMaterial")
    public Map<Long, String> listMaterial() {
        Map<Long, String> map = new HashMap<>();
        List<Material> materials = materialService.getAllMaterial();
        for(Material material : materials){
            map.put(material.getId(), material.getName());
        }
        return map;
    }

    @GetMapping("/product")
    public String getProduct(Model model,
                           @RequestParam(value = "categoryId", required = false) Long categoryId,
                           @RequestParam(value = "status", required = false) String status,
                           @RequestParam(value = "sortBy", required = false) String sortBy){

        List<Product> products = productService.getAll();

        // Set default sort if not specified
        if (sortBy == null || sortBy.isEmpty()) {
            sortBy = "newest";
        }

        // Filter by category
        if (categoryId != null && categoryId > 0) {
            products = products.stream()
                    .filter(p -> p.getCategory().getId().equals(categoryId))
                    .collect(java.util.stream.Collectors.toList());
        }

        // Filter by status (stock availability)
        if (status != null && !status.isEmpty()) {
            if ("1".equals(status)) { // Còn hàng
                products = products.stream()
                        .filter(p -> p.getTotalQuantity() > 0)
                        .collect(java.util.stream.Collectors.toList());
            } else if ("0".equals(status)) { // Hết hàng
                products = products.stream()
                        .filter(p -> p.getTotalQuantity() == 0)
                        .collect(java.util.stream.Collectors.toList());
            }
        }

        // Sort products
        if (sortBy != null && !sortBy.isEmpty()) {
            switch (sortBy) {
                case "newest":
                    products.sort((p1, p2) -> p2.getCreate_date().compareTo(p1.getCreate_date()));
                    break;
                case "price_asc":
                    products.sort((p1, p2) -> {
                        double price1 = p1.getProductDetailList().isEmpty() ? 0 :
                                p1.getProductDetailList().get(0).getPrice();
                        double price2 = p2.getProductDetailList().isEmpty() ? 0 :
                                p2.getProductDetailList().get(0).getPrice();
                        return Double.compare(price1, price2);
                    });
                    break;
                case "price_desc":
                    products.sort((p1, p2) -> {
                        double price1 = p1.getProductDetailList().isEmpty() ? 0 :
                                p1.getProductDetailList().get(0).getPrice();
                        double price2 = p2.getProductDetailList().isEmpty() ? 0 :
                                p2.getProductDetailList().get(0).getPrice();
                        return Double.compare(price2, price1);
                    });
                    break;
            }
        }

        model.addAttribute("products", products);
        model.addAttribute("selectedCategoryId", categoryId);
        model.addAttribute("selectedStatus", status);
        model.addAttribute("selectedSortBy", sortBy);

        return "admin/product/show";
    }

    @GetMapping("/product/create")
    public String getCreateProductPage(Model model) {
        model.addAttribute("newProduct", new Product());
        return "admin/product/create";
    }

    @PostMapping("/product/create")
    public String createProduct(@Valid @ModelAttribute("newProduct") Product product, BindingResult bindingResult,
                                Model model) {
        List<FieldError> errors = bindingResult.getFieldErrors();
        for(FieldError error : errors){
            System.out.println(">>>>>>" + error.getField() + "-" + error.getDefaultMessage());
        }
        if(bindingResult.hasErrors()){
            return "admin/product/create";
        }
        if (productService.getProductByName(product.getName()) != null) {
            String message = "Sản phẩm đã tồn tại";
            model.addAttribute("message", message);
            return "admin/product/create";
        }
        product.setCreate_date(LocalDateTime.now());
        product.setDelete_flag(false);
        product.setGender(1);
        productService.handleSaveProduct(product);
        return "redirect:/product";
    }

    @GetMapping("/product/update/{id}")
    public String getPageUpdate(Model model, @PathVariable("id") Long id){
        Product product = this.productService.getProductById(id);
        model.addAttribute("product", product);
        return "admin/product/update";
    }

    @PostMapping("/product/update")
    public String updateProduct(@Valid @ModelAttribute("product") Product product, BindingResult bindingResult){
        System.out.println(">>>>>>>>>>>>" + product.getCreate_date());
        if(bindingResult.hasErrors()){
            List<FieldError> errors = bindingResult.getFieldErrors();
            for(FieldError error : errors){
                System.out.println(">>>>>>" + error.getField() + "-" + error.getDefaultMessage());
            }
            return "admin/product/update";
        }

        product.setUpdated_date(LocalDateTime.now());
        productService.handleSaveProduct(product);
        return "redirect:/product";
    }

    @GetMapping("/product/delete/{id}")
    public String deleteProduct(@PathVariable("id") long id){
        Product product = productService.getProductById(id);
        product.setDelete_flag(true);
        productService.handleSaveProduct(product);
        return "redirect:/product";
    }
}

