package com.example.demo.controller;

import com.example.demo.Entity.User;
import com.example.demo.service.UserService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


@Controller
@RequestMapping("/BeeStore")
public class RegistController {

    @Autowired
    private UserService userService;

    @GetMapping("/DangKy")
    public String DangKy(Model model) {
        // Nếu chưa có user trong model (lần đầu truy cập), thì tạo mới
        if (!model.containsAttribute("user")) {
            model.addAttribute("user", new User());
        }

        // Nếu chưa có isSubmitted thì mặc định là false
        if (!model.containsAttribute("isSubmitted")) {
            model.addAttribute("isSubmitted", false);
        }

        return "Register";
    }

    @PostMapping("/DangKy")
    public String Register(
            @ModelAttribute("user") @Valid User user,
            BindingResult result,
            RedirectAttributes redirectAttributes
    ) {
        // Kiểm tra lỗi validation
        if (result.hasErrors()) {
            // Đưa kết quả validate và dữ liệu nhập lại về trang Register
            redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.user", result);
            redirectAttributes.addFlashAttribute("user", user);
            redirectAttributes.addFlashAttribute("isSubmitted", true); // Đánh dấu đã nhấn nút
            return "redirect:/BeeStore/DangKy";
        }

        try {
            // Mặc định trạng thái là true nếu không được chọn
            if (user.getTrangThai() == null) {
                user.setTrangThai(true);
            }
            
            userService.saveUser(user);
            redirectAttributes.addFlashAttribute("message", "Đăng ký thành công");
            return "redirect:/BeeStore/Home?id=" + user.getId();
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("message", "Đăng ký thất bại: " + e.getMessage());
            redirectAttributes.addFlashAttribute("user", user);
            redirectAttributes.addFlashAttribute("isSubmitted", true);
            return "redirect:/BeeStore/DangKy";
        }
    }

}


