package com.example.demo.controller;

import com.example.demo.Entity.Brand;
import com.example.demo.Entity.Color;
import com.example.demo.repository.ColorRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/BeeStore")
public class ColorController {

    @Autowired
    private ColorRepo colorRepo;

    @GetMapping("/Color")
    public String color(Model model) {
        List<Color> colors = colorRepo.findByDeleteFalse();
        model.addAttribute("colors", colors);
        return "color";
    }

    @GetMapping("/Color/delete")
    public String delete(@RequestParam(required = false) Long id) {
       Color colors = colorRepo.findById(id).orElse(null);
        if (colors != null) {
            colors.setDelete(true);
            colorRepo.save(colors);
        }
        return "redirect:/BeeStore/Color";
    }
    @PostMapping("/Color/add")
    public String addColor(@RequestParam String code,
                           @RequestParam String name,
                           RedirectAttributes  redirectAttributes) {
        List<Color> colors = colorRepo.findByCode(code);
        if(!colors.isEmpty()) {
            redirectAttributes.addFlashAttribute("message", "mã màu bị trùng ");
            redirectAttributes.addFlashAttribute("messageType", "danger");
            return  "redirect:/BeeStore/Color";
        }
        try {
            Color color = Color.builder()
                    .code(code).name(name).build();
            colorRepo.save(color);
            redirectAttributes.addFlashAttribute("messageType", "sửa màu thành công");
            redirectAttributes.addFlashAttribute("messageType", "success");
        }catch (Exception e) {
            redirectAttributes.addFlashAttribute("message", "thêm màu thất bại");
            redirectAttributes.addFlashAttribute("messageType", "error");
    }
        return "redirect:/BeeStore/Color";
    }
    @PostMapping("/Color/update")
    public String updateColor(@ModelAttribute Color color, RedirectAttributes redirectAttributes) {
        List<Color> colors =  colorRepo.findAllById(List.of(color.getId()));
        if(!colors.isEmpty()) {
            Color color1 = colors.get(0);
            color1.setCode(color.getCode());
            color1.setName(color.getName());
            colorRepo.save(color1);
            redirectAttributes.addFlashAttribute("message", "thêm màu thành công");
            redirectAttributes.addFlashAttribute("messageType", "success");
        }else{
            redirectAttributes.addFlashAttribute("message","Thêm màu thất bại");
            redirectAttributes.addFlashAttribute("messageType", "error");
        }
        return "redirect:/BeeStore/Color";
    }
    @GetMapping("/Color/search")
    public String searchColor(@RequestParam(name = "id") String id, Model model) {
        List<Color>  color;
        if(id !=null &&  !id.isBlank()) {
            try{
                Long ids = Long.parseLong(id);
                Color  color1 = colorRepo.findById(ids).orElse(null);
                if (color1 != null) {
                    color = List.of(color1);
                } else {
                    color = new ArrayList<>();
                }
            }catch (NumberFormatException e){
                color = new ArrayList<>();
            }
        }else{
            color = colorRepo.findByDeleteFalse();
        }
        model.addAttribute("colors", color);
        return "brands";
    }
}
