package com.example.demo.controller;

import com.example.demo.Entity.MauSac;
import com.example.demo.repository.MauSacRepone;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/BeeStore")
public class MauSacController {

    @Autowired
    private MauSacRepone mauSacRepone;

    @GetMapping("/MauSac")
    public String index(@RequestParam(name = "keyword", required = false) String keyword, Model model) {
        List<MauSac> danhSachMauSac;
        
        if (keyword != null && !keyword.isEmpty()) {
            danhSachMauSac = mauSacRepone.search(keyword);
            model.addAttribute("keyword", keyword);
        } else {
            danhSachMauSac = mauSacRepone.findAll();
        }
        
        model.addAttribute("danhSachMauSac", danhSachMauSac);
        
        if (!model.containsAttribute("mauSac")) {
            model.addAttribute("mauSac", new MauSac());
        }
        
        return "MauSac";
    }

    @PostMapping("/MauSac/save")
    public String save(@ModelAttribute("mauSac") @Valid MauSac mauSac, 
                      BindingResult result, 
                      RedirectAttributes redirectAttributes) {
        
        // Kiểm tra trùng mã màu sắc
        if (mauSac.getId() == null) {
            // Trường hợp thêm mới
            if (mauSacRepone.existsByMaMauSac(mauSac.getMaMauSac())) {
                result.rejectValue("maMauSac", "duplicate", "Mã màu sắc đã tồn tại");
            }
        } else {
            // Trường hợp cập nhật
            if (mauSacRepone.existsByMaMauSacAndIdNot(mauSac.getMaMauSac(), mauSac.getId())) {
                result.rejectValue("maMauSac", "duplicate", "Mã màu sắc đã tồn tại");
            }
        }
        
        if (result.hasErrors()) {
            redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.mauSac", result);
            redirectAttributes.addFlashAttribute("mauSac", mauSac);
            return "redirect:/BeeStore/MauSac";
        }
        
        try {
            mauSacRepone.save(mauSac);
            redirectAttributes.addFlashAttribute("message", 
                mauSac.getId() == null ? "Thêm màu sắc thành công" : "Cập nhật màu sắc thành công");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("message", "Lỗi: " + e.getMessage());
        }
        
        return "redirect:/BeeStore/MauSac";
    }

    @GetMapping("/MauSac/edit/{id}")
    public String edit(@PathVariable("id") UUID id, Model model, RedirectAttributes redirectAttributes) {
        try {
            MauSac mauSac = mauSacRepone.findById(id)
                .orElseThrow(() -> new Exception("Không tìm thấy màu sắc với ID: " + id));
            
            model.addAttribute("mauSac", mauSac);
            
            // Lấy danh sách màu sắc để hiển thị bảng
            List<MauSac> danhSachMauSac = mauSacRepone.findAll();
            model.addAttribute("danhSachMauSac", danhSachMauSac);
            
            return "MauSac";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("message", "Lỗi: " + e.getMessage());
            return "redirect:/BeeStore/MauSac";
        }
    }

    @GetMapping("/MauSac/delete/{id}")
    public String delete(@PathVariable("id") UUID id, RedirectAttributes redirectAttributes) {
        try {
            mauSacRepone.deleteById(id);
            redirectAttributes.addFlashAttribute("message", "Xóa màu sắc thành công");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("message", "Lỗi: " + e.getMessage());
        }
        
        return "redirect:/BeeStore/MauSac";
    }
}

