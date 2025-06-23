package com.example.demo.controller;

import com.example.demo.Entity.Brand;
import com.example.demo.repository.BrandRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/BeeStore")
public class BrandController {

    @Autowired
    private BrandRepo repo;

    @GetMapping("/Brand")
    public String Brand( Model model) {
        List<Brand> brands;
        brands = repo.findByDeleteFalse();
        model.addAttribute("brands", brands);
        return "brands";
    }
    @GetMapping("/Brand/delete")
    public String BrandDelete(@RequestParam(required = false) Long id) {
        Brand brand = repo.findById(id).orElse(null);
        if(brand != null) {
            brand.setDelete(true);
            repo.save(brand);
        }
        return "redirect:/BeeStore/Brand";
    }

    @PostMapping("/Brand/add")
    public String addBrand(@RequestParam String code,
                          @RequestParam String name,
                          @RequestParam Boolean status,
                          RedirectAttributes redirectAttributes) {
        List<Brand> brands = repo.findByCode(code);
        if(!brands.isEmpty()) {
            redirectAttributes.addFlashAttribute("message", "mã code đã tồn tại");
            redirectAttributes.addFlashAttribute("messageType","danger");
            return  "redirect:/BeeStore/Brand";
        }
        try {
            Brand brand = Brand.builder()
                    .code(code)
                    .name(name)
                    .status(status)
                    .delete(false)
                    .build();
            repo.save(brand);
            redirectAttributes.addFlashAttribute("message", "Thêm thương hiệu thành công!");
            redirectAttributes.addFlashAttribute("messageType", "success");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("message", "Lỗi khi thêm thương hiệu: " + e.getMessage());
            redirectAttributes.addFlashAttribute("messageType", "error");
        }
        return "redirect:/BeeStore/Brand";
    }

    @PostMapping("/Brand/update")
    public String updateBrand(@ModelAttribute Brand brand, RedirectAttributes redirectAttributes) {
        List<Brand> brands = repo.findAllById(List.of(brand.getId())); // trả về List<Brand>

        if (!brands.isEmpty()) {
            Brand existing = brands.get(0);
            existing.setCode(brand.getCode());
            existing.setName(brand.getName());
            existing.setStatus(brand.getStatus());
            repo.save(existing);
            redirectAttributes.addFlashAttribute("message", "Cập nhật thương hiệu thành công!");
            redirectAttributes.addFlashAttribute("messageType", "success");
        } else {
            redirectAttributes.addFlashAttribute("message", "Không tìm thấy thương hiệu!");
            redirectAttributes.addFlashAttribute("messageType", "danger");
        }
        return "redirect:/BeeStore/Brand";
    }
    @GetMapping("/Brand/search")
    public String searchBrand(@RequestParam(name = "id") String id, Model model) {
        List<Brand>  brands;
        if(id !=null &&  !id.isBlank()) {
            try{
                Long ids = Long.parseLong(id);
                Brand brand = repo.findById(ids).orElse(null);
                if (brand != null) {
                    brands = List.of(brand);
                } else {
                    brands = new ArrayList<>();
                }
            }catch (NumberFormatException e){
                brands = new ArrayList<>();
            }
            }
            else{
                brands = repo.findByDeleteFalse();
            }
            model.addAttribute("brands", brands);
            return "brands";
        }
    }


