package com.example.demo.controller;

import com.example.demo.Entity.Brand;
import com.example.demo.Entity.Category;
import com.example.demo.Entity.Material;
import com.example.demo.Entity.SanPham;
import com.example.demo.service.BrandService;
import com.example.demo.service.CategoryService;
import com.example.demo.service.MaterialService;
import com.example.demo.service.SanPhamService;
import jakarta.validation.Valid;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class SanPhamController {
    private final SanPhamService sanPhamService;
    private final BrandService brandService;
    private final CategoryService categoryService;
    private final MaterialService materialService;

    public SanPhamController(SanPhamService sanPhamService, BrandService brandService,
                             CategoryService categoryService,
                             MaterialService materialService) {

        this.sanPhamService = sanPhamService;
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
    public String getProduct(Model model){
        List<SanPham> products = sanPhamService.getAll();
        model.addAttribute("products", products);
        return "/san-pham/show";
    }

    @GetMapping("/product/create")
    public String getCreateProductPage(Model model) {
        model.addAttribute("newProduct", new SanPham());
        return "/san-pham/create";
    }

    @PostMapping("/product/create")
    public String createProduct(@Valid @ModelAttribute("newProduct") SanPham sanPham, BindingResult bindingResult) {
        List<FieldError> errors = bindingResult.getFieldErrors();
        for(FieldError error : errors){
            System.out.println(">>>>>>" + error.getField() + "-" + error.getDefaultMessage());
        }
        if(bindingResult.hasErrors()){
            return "/san-pham/create";
        }
        sanPham.setCreate_date(new Date());
        sanPham.setDelete_flag(1);
        sanPham.setGender(1);
        sanPhamService.handleSaveProduct(sanPham);
        return "redirect:/product";
    }

    @GetMapping("/product/update/{id}")
    public String getPageUpdate(Model model, @PathVariable("id") Long id){
        SanPham product = sanPhamService.getProductById(id);
        model.addAttribute("product", product);
        return "san-pham/update";
    }

    @PostMapping("/product/update")
    public String updateProduct(@Valid @ModelAttribute("product") SanPham sanPham, BindingResult bindingResult){
        System.out.println(">>>>>>>>>>>>" + sanPham.getCreate_date());
        if(bindingResult.hasErrors()){
            List<FieldError> errors = bindingResult.getFieldErrors();
            for(FieldError error : errors){
                System.out.println(">>>>>>" + error.getField() + "-" + error.getDefaultMessage());
            }
            return "/san-pham/update";
        }

        sanPham.setUpdated_date(new Date());
        sanPhamService.handleSaveProduct(sanPham);

        return "redirect:/product";
    }

}
