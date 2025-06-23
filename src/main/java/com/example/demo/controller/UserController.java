package com.example.demo.controller;

import com.example.demo.Dto.LoginDto;
import com.example.demo.Entity.User;
import com.example.demo.repository.CustomerRepo;
import com.example.demo.repository.UserRepone;
import com.example.demo.service.CustomerService.CustomerService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.*;

@Controller
@RequestMapping("/BeeStore")
public class UserController {

    @Autowired
    private UserRepone userReponse;

    @Autowired
    private PasswordEncoder passwordEncoder;
    @Autowired
    private CustomerRepo customerRepo;
    @Autowired
    private CustomerService customerService;

    @GetMapping("/Home")
    public String home() {
        return "home";
    }

    @GetMapping("/Login")
    public String DangNhap() {
        return "user";
    }

    @PostMapping("/Login")
    public String getLogin(LoginDto loginDto, RedirectAttributes re, HttpSession session) {
        // Tìm user theo email
        Optional<User> userOpt = userReponse.findByEmail(loginDto.getName());
        if (userOpt.isPresent()) {
            User user = userOpt.get();
            // Kiểm tra mật khẩu với BCrypt
            if (passwordEncoder.matches(loginDto.getPassword(), user.getPassword())) {
                // Kiểm tra tài khoản có bị khóa không
                if (user.getIsNonLocked()) {
                    session.setAttribute("user", user);
                    session.setAttribute("customer", user.getCustomer());
                    re.addFlashAttribute("message", "Đăng nhập thành công " + user.getEmail());
                    return "redirect:/BeeStore/Home?User=" + user.getId();
                } else {
                    re.addFlashAttribute("message", "Tài khoản đã bị khóa");
                    return "redirect:/BeeStore/Login";
                }
            }
        }

        re.addFlashAttribute("message", "Email hoặc mật khẩu không đúng");
        return "redirect:/BeeStore/Login";
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
