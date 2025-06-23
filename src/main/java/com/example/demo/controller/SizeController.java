package com.example.demo.controller;

import com.example.demo.Entity.Size;
import com.example.demo.repository.MaterialRepo;
import com.example.demo.repository.SizeRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/BeeStore")
public class SizeController {

    @Autowired
    private SizeRepo sizeRepo;

    @GetMapping("/Size")
    public String Size(Model model) {
        List<Size> sizes;
        sizes = sizeRepo.findByDeleteFalse();
        model.addAttribute("sizes", sizes);
        return "size";
    }

    @GetMapping("/Size/delete")
    public String SizeDelete(@RequestParam(required = false) Long id) {
        Size size = sizeRepo.findById(id).orElse(null);
        if (size != null) {
            size.setDelete(true);
            sizeRepo.save(size);
        }
        return "redirect:/BeeStore/Size";
    }
    @PostMapping("/Size/add")
    public String SizeAdd(@RequestParam String name,
                          @RequestParam String code,
                          RedirectAttributes redirectAttributes) {
        List<Size> sizes = sizeRepo.findByCode(code);
        if(!sizes.isEmpty()) {
            redirectAttributes.addFlashAttribute("message","bị trùng");
            redirectAttributes.addFlashAttribute("messageType","danger");
            return "redirect:/BeeStore/Size";
        }
        try{
            Size size = Size.builder()
                    .name(name)
                    .code(code)
                    .delete(false)
                    .build();
            sizeRepo.save(size);
            redirectAttributes.addFlashAttribute("message","Thêm size thành công");
            redirectAttributes.addFlashAttribute("messageType","succes");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("message","thêm thất bại");
            redirectAttributes.addFlashAttribute("messageType","error");
        }
        return "redirect:/BeeStore/Size";
    }
    @PostMapping("/Size/update")
    public String updateAdd(@ModelAttribute Size size, RedirectAttributes redirectAttributes) {
        List<Size> sizes = sizeRepo.findAllById(List.of(size.getId()));
        if(!sizes.isEmpty()) {
            Size size1 = sizes.get(0);
            size1.setName(size.getName());
            size1.setCode(size.getCode());
            sizeRepo.save(size1);
            redirectAttributes.addFlashAttribute("message","sửa thành công");
            redirectAttributes.addFlashAttribute("messageType","success");
        }else{
            redirectAttributes.addFlashAttribute("message","sửa thất bại");
            redirectAttributes.addFlashAttribute("messageType","error");
        }
        return "redirect:/BeeStore/Size";
    }
    @GetMapping("/Size/search")
    public String searchSize(@RequestParam(name = "id") String id, Model model) {
        List<Size> sizes;
        if( id!= null && !id.isBlank()){
            try{
                Long ids = Long.parseLong(id);
                Size size = sizeRepo.findById(ids).orElse(null);
                if(size != null) {
                    sizes = List.of(size);
                }else {
                    sizes = new ArrayList<>();
                }
            }catch (NumberFormatException e){
                sizes = new ArrayList<>();
            }
            model.addAttribute("sizes", sizes);
        }
        return "size";
    }
}
