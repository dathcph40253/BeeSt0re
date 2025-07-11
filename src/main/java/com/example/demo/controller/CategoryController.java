package com.example.demo.controller;


import com.example.demo.Entity.Category;
import com.example.demo.repository.CategoryRepo;
import com.example.demo.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.List;

@Controller
public class CategoryController {

    @Autowired
    private CategoryRepo categoryRepo;

    @Autowired
    private CategoryService categoryService;

    @GetMapping("/Category")
    public String category(Model model) {
        List<Category>  categories = categoryRepo.findByDeleteFalse();
        model.addAttribute("categories", categories);
        return "category";
    }
    @GetMapping("/Category/delete")
    public String deleteCategory(@RequestParam(required = false) Long id, RedirectAttributes redirectAttributes) {
        // Kiểm tra xem danh mục có đang được sử dụng không
        if (categoryService.isCategoryInUse(id)) {
            redirectAttributes.addFlashAttribute("message", "Không thể xóa danh mục này vì đang có sản phẩm sử dụng!");
            redirectAttributes.addFlashAttribute("messageType", "danger");
            return "redirect:/Category";
        }

        Category category = categoryRepo.findById(id).orElse(null);
        if(category != null) {
            category.setDelete(true);
            categoryRepo.save(category);
            redirectAttributes.addFlashAttribute("message", "Xóa danh mục thành công!");
            redirectAttributes.addFlashAttribute("messageType", "success");
        }
        return "redirect:/Category";
    }
    @PostMapping("/Category/add")
    public String addCategory(@RequestParam String code,
                              @RequestParam String name,
                              @RequestParam Boolean status,
                              RedirectAttributes redirectAttributes) {
        List<Category> categories = categoryRepo.findByCode(code);
        if(!categories.isEmpty()) {
            redirectAttributes.addFlashAttribute("message", "Bị trùng");
            redirectAttributes.addFlashAttribute("messageType", "danger");
            return "redirect:/Category";
        }try{
            Category category = Category.builder()
                    .code(code)
                    .name(name)
                    .status(status)
                    .delete(false).build();
            categoryRepo.save(category);
            redirectAttributes.addFlashAttribute("message", "Thêm thành công");
            redirectAttributes.addFlashAttribute("messageType", "success");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("message", "thêm thất bại");
            redirectAttributes.addFlashAttribute("messageType", "error");
        }
        return "redirect:/Category";
    }
    @PostMapping("/Category/update")
    public String updateCategory(@ModelAttribute Category category, RedirectAttributes redirectAttributes) {
        List<Category> categories = categoryRepo.findAllById(List.of(category.getId()));
        if(!categories.isEmpty()) {
            Category category1 = categories.get(0);
            category1.setName(category.getName());
            category1.setCode(category.getCode());
            category1.setStatus(category.getStatus());
            categoryRepo.save(category1);
            redirectAttributes.addFlashAttribute("message", "sửa thành công");
            redirectAttributes.addFlashAttribute("messageType", "success");
        }else {
            redirectAttributes.addFlashAttribute("message" , "sửa thất bại");
            redirectAttributes.addFlashAttribute("messageType", "error");
        }
        return "redirect:/Category";
    }
    @GetMapping("/Category/search")
    public String searchCategory(@RequestParam(name = "id") String id, Model model) {
        List<Category> categories;
        if(id !=null &&  !id.isBlank()) {
            try {
                Long ids = Long.parseLong(id);
                Category category = categoryRepo.findById(ids).orElse(null);
                if (category != null) {
                    categories = List.of(category);
                } else {
                    categories = new ArrayList<>();
                }
            } catch (NumberFormatException e) {
                categories = new ArrayList<>();
            }
        }else{
                categories = categoryRepo.findByDeleteFalse();
            }
            model.addAttribute("categories", categories);
            return "category";
        }
    }

