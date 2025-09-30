package com.example.demo.controller;


import com.example.demo.service.AccountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;


@Controller
public class PasswordResetController {
    @Autowired
    private AccountService accountService;

    // Xử lý yêu cầu GET để hiển thị trang "Quên Mật khẩu"
    @GetMapping("/forgot-password")
    public String showForgotPasswordPage() {
        return "forgot-password";
    }

    // Xử lý yêu cầu POST để xử lý logic "Quên Mật khẩu"
    @PostMapping("/api/auth/forgot-password")
    @ResponseBody
    public ResponseEntity<String> forgotPassword(@RequestParam String email) {
        String message = accountService.forgotPassword(email);
        return ResponseEntity.ok(message);
    }

    // Xử lý yêu cầu GET để hiển thị trang "Đặt lại Mật khẩu"
    @GetMapping("/reset-password")
    public String showResetPasswordPage() {
        return "reset-password";
    }

    // Xử lý yêu cầu POST để xử lý logic "Đặt lại Mật khẩu"
    @PostMapping("/api/auth/reset-password")
    @ResponseBody
    public ResponseEntity<String> resetPassword(@RequestParam String code, @RequestParam String newPassword) {
        String message = accountService.resetPassword(code, newPassword);
        return ResponseEntity.ok(message);
    }
}
