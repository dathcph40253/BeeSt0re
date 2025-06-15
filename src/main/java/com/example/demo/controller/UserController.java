package com.example.demo.controller;

import com.example.demo.Dto.UserDto;
import com.example.demo.Entity.User;
import com.example.demo.repository.UserRepone;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.*;

@Controller
@RequestMapping("/BeeStore")
public class UserController {

    @Autowired
    private UserRepone userReponse;

    @GetMapping("/Home")
    public String home() {
        return "home";
    }

    @GetMapping("/Login")
    public String DangNhap() {
        return "User";
    }

    @PostMapping("/Login")
    public String getLogin(UserDto userDto, RedirectAttributes re, HttpSession session) {
        Optional<User> user = userReponse.findByNameAndPassword(userDto.getName(), userDto.getPassword());
        if (user.isPresent()) {
            session.setAttribute("user", user.get());
            re.addFlashAttribute("message", "Đăng nhập thành công " + user.get().getName());
            return "redirect:/BeeStore/Home?User=" + user.get().getId();
        } else {
            re.addFlashAttribute("message", "chưa đăng nhập hoặc chưa nhập đủ thông tin");
            return "redirect:/BeeStore/Login";
        }
    }
    
    @GetMapping("/Logout")
    public String logout(HttpSession session, RedirectAttributes redirectAttributes) {
        // Xóa thông tin người dùng khỏi session
        session.removeAttribute("user");
        // Hủy toàn bộ session
        session.invalidate();
        // Thêm thông báo đăng xuất thành công
        redirectAttributes.addFlashAttribute("message", "Đăng xuất thành công");
        // Chuyển hướng về trang home thay vì trang đăng nhập
        return "redirect:/BeeStore/Home";
    }

}
