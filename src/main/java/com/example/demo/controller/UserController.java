package com.example.demo.controller;

import ch.qos.logback.core.model.Model;
import com.example.demo.Dto.LoginDto;
import com.example.demo.Entity.User;
import com.example.demo.repository.CustomerRepo;
import com.example.demo.repository.UserRepone;
import com.example.demo.service.CustomerService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.*;

@Controller
public class UserController {

    @Autowired
    private UserRepone userReponse;

    @Autowired
    private PasswordEncoder passwordEncoder;

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
                    String roleName = user.getRole().getName(); // VD: ROLE_ADMIN
                    List<GrantedAuthority> authorities = List.of(new SimpleGrantedAuthority(roleName));
                    Authentication authToken = new UsernamePasswordAuthenticationToken(user, null, authorities);
                    SecurityContextHolder.getContext().setAuthentication(authToken);
                    re.addFlashAttribute("message", "Đăng nhập thành công " + user.getEmail());
                    if ("ROLE_ADMIN".equals(roleName)) {
                        return "redirect:/admin/Home";
                    } else {
                        return "redirect:";
                    }
                } else {
                    re.addFlashAttribute("message", "Tài khoản đã bị khóa");
                    return "redirect:/Login";
                }
            }
        }

        re.addFlashAttribute("message", "Email hoặc mật khẩu không đúng");
        return "redirect:/Login";
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
        return "redirect:/Home";
    }
    @GetMapping("/search")
    public String searchName(@RequestParam("keyword") String keyword) {
        String newKeyword = keyword.toLowerCase();
        switch (newKeyword) {
            case "home":
                return "redirect:/Home";
            case "product":
                return "redirect:/product";
            case "order":
                return "redirect:/admin/order";
            case "category":
                return "redirect:/Category";
            case "color":
                return "redirect:/Color";
            case "size":
                return "redirect:/Size";
            case "brand":
                return "redirect:/Brand";
            case "material":
                return "redirect:/Material";
            case "account":
                return "redirect:/admin/account";
            case "report":
                return "redirect:/admin/report";
            default:
                return "home";
        }
    }
}
