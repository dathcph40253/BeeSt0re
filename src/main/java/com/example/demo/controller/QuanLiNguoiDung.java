package com.example.demo.controller;

import com.example.demo.Entity.User;
import com.example.demo.repository.UserRepone;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/BeeStore")
public class QuanLiNguoiDung {

    @Autowired
    private UserRepone xyz;

    @GetMapping("/QuanLiNguoiDung")
    public String QuanLiNguoiDung(@RequestParam(name = "id", required = false) List<Long> keyword, Model model) {
        List<User> users;
        if(keyword != null && !keyword.isEmpty()) {
            users = xyz.findByIdIn(keyword);
        }else {
            users = xyz.findAll();
        }
        model.addAttribute("users", users);
        model.addAttribute("keyword", keyword);
        return "taikhoan";
    }


}
