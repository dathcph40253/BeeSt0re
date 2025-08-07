package com.example.demo.controller;


import com.example.demo.Entity.Customer;
import com.example.demo.Entity.User;
import com.example.demo.dto.LoginDto;
import com.example.demo.repository.UserRepone;
import com.example.demo.service.CustomerService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
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
    
    @Autowired
    private CustomerService customerService;
    
    @GetMapping("/Home")
    public String home() {
        return "home";
    }

    @GetMapping("/admin/Home")
    public String adminHome() {
        return "home";
    }

    @GetMapping("/Login")
    public String DangNhap() {
        return "user";
    }
  @PostMapping("/Login")
    public String getLogin(LoginDto loginDto, RedirectAttributes re, HttpSession session, HttpServletRequest request) {
        // Tìm user theo email
        Optional<User> userOpt = userReponse.findByEmail(loginDto.getName());
        if (userOpt.isPresent()) {
            User user = userOpt.get();
            // Kiểm tra mật khẩu với BCrypt
            if (passwordEncoder.matches(loginDto.getPassword(), user.getPassword())) {
                // Kiểm tra tài khoản có bị khóa không
                if (user.getIsNonLocked()) {
                    session.setAttribute("user", user);
                    Customer customer = user.getCustomer();
                    if (customer != null) {
                    session.setAttribute("customer", customer); // ✅ Thêm dòng này
                    }
                    String roleName = user.getRole().getName(); // VD: ROLE_ADMIN
                    List<GrantedAuthority> authorities = List.of(new SimpleGrantedAuthority(roleName));
                    Authentication authToken = new UsernamePasswordAuthenticationToken(user.getEmail(), null, authorities);
                    // Lưu authentication vào SecurityContext và session
                    SecurityContext securityContext = SecurityContextHolder.createEmptyContext();
                    securityContext.setAuthentication(authToken);
                    SecurityContextHolder.setContext(securityContext);
                    session.setAttribute("SPRING_SECURITY_CONTEXT", securityContext);

                    re.addFlashAttribute("message", "Đăng nhập thành công " + user.getEmail());
                    if ("ROLE_ADMIN".equals(roleName) || "ROLE_EMPLOYEE".equals(roleName)) {
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
        // Clear Spring Security context
        SecurityContextHolder.clearContext();
        // Hủy toàn bộ session
        session.invalidate();
        // Thêm thông báo đăng xuất thành công
        redirectAttributes.addFlashAttribute("message", "Đăng xuất thành công");
        // Chuyển hướng về trang home thay vì trang đăng nhập
        return "redirect:/";
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
