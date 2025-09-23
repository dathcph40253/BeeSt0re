package com.example.demo.controller;

import com.example.demo.Entity.Material;
import com.example.demo.repository.MaterialRepo;
import com.example.demo.service.MaterialService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.List;

@Controller
public class MaterialController {

    @Autowired
    private MaterialRepo materialRepo;

    @Autowired
    private MaterialService materialService;

    @GetMapping("/Material")
    public String material(Model model) {
        List<Material> materials = materialRepo.findByDeleteFalse();
        model.addAttribute("materials", materials);
        return "material";
    }
    @GetMapping("/Material/delete")
    public String deleteStatus(@RequestParam(required = false) Long id, RedirectAttributes redirectAttributes) {
        // Kiểm tra xem chất liệu có đang được sử dụng không
        try {
            materialService.deleteMaterial(id);
            redirectAttributes.addFlashAttribute("success", "xóa thành công");
        }catch (IllegalStateException e){
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/Material";
    }
    @PostMapping("/Material/add")
    public String addMaterial(@RequestParam String code,
            @RequestParam String name,
            @RequestParam Boolean status,
            RedirectAttributes redirectAttributes){
        List<Material> materials = materialRepo.findByCode(code);
        if(!materials.isEmpty()){
            redirectAttributes.addFlashAttribute("message","bị trùng");
            redirectAttributes.addFlashAttribute("messageType", "danger");
            return "redirect:/Material";
        }
        try{
            Material material = Material.builder().
                    code(code)
                    .status(status).
                    delete(false)
                    .name(name).build();
            materialRepo.save(material);
            redirectAttributes.addFlashAttribute("message", "thêm thành công");
            redirectAttributes.addFlashAttribute("messageType", "success");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("message", "thêm thất bại");
            redirectAttributes.addFlashAttribute("messageType", "error");
        }
        return "redirect:/Material";
    }
    @PostMapping("/Material/update")
    public String updateMaterial(@ModelAttribute Material material, RedirectAttributes redirectAttributes){
        List<Material> materials = materialRepo.findAllById(List.of(material.getId()));
        if(!materials.isEmpty()){
            Material material1 = materials.get(0);
            material1.setName(material.getName());
            material1.setCode(material.getCode());
            material1.setStatus(material.getStatus());
            materialRepo.save(material1);
            redirectAttributes.addFlashAttribute("message", "sửa thành công");
            redirectAttributes.addFlashAttribute("messageType", "success");
        }else{
            redirectAttributes.addFlashAttribute("message", "sửa thất bại");
            redirectAttributes.addFlashAttribute("messageType", "error");
        }
        return "redirect:/Material";
    }
    @GetMapping("/Material/search")
    public String searchMaterial(@RequestParam(name = "id") String id, Model model){
        List<Material> materials;
        if(id!=null && !id.isBlank()) {
            try{
                Long ids = Long.parseLong(id);
                Material material = materialRepo.findById(ids).orElse(null);
                if(material!=null){
                    materials = List.of(material);
                }else{
                    materials = new ArrayList<>();
                }
            }catch (NumberFormatException e){
                materials = new ArrayList<>();
            }
            model.addAttribute("materials", materials);
        }
        return "material";
    }
}
