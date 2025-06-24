package com.example.demo.controller;

import com.example.demo.Entity.Customer;
import com.example.demo.Entity.Role;
import com.example.demo.Dto.RegistDto;
import com.example.demo.Entity.User;
import com.example.demo.repository.UserRepone;
import com.example.demo.service.CustomerService.CustomerService;
import com.example.demo.service.UserService.UserService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDateTime;
import java.util.Objects;
import java.util.Random;
import java.util.UUID;


@Controller
@RequestMapping("/BeeStore")
public class RegistController {

    @Autowired
    private UserRepone repone;

    @Autowired
    private UserService userService;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private CustomerService customerService;
    @GetMapping("/DangKy")
    public String DangKy(Model model) {
        // Nếu chưa có user trong model (lần đầu truy cập), thì tạo mới
        if (!model.containsAttribute("RegistDto")) {
            model.addAttribute("RegistDto", new RegistDto());
        }
        // Nếu chưa có isSubmitted thì mặc định là false
        if (!model.containsAttribute("isSubmitted")) {
            model.addAttribute("isSubmitted", false);
        }

        return "register";
    }

    @PostMapping("/DangKy")
    public String Register(
            @ModelAttribute("RegistDto") @Valid RegistDto registDto,
            BindingResult result,
            RedirectAttributes redirectAttributes
    ) {
        // Kiểm tra lỗi validation
        if (result.hasErrors()) {
            // Đưa kết quả validate và dữ liệu nhập lại về trang Register
            redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.RegistDto", result);
            redirectAttributes.addFlashAttribute("RegistDto", registDto);
            redirectAttributes.addFlashAttribute("isSubmitted", true); // Đánh dấu đã nhấn nút
            return "redirect:/BeeStore/DangKy";
        }
        User user = new User();
        try {
            Customer customer = new Customer();
            customer.setEmail(registDto.getEmail());
            customer.setCode(customerService.generateCustomerCode());
            Customer newCustomer = customerService.saveCustomer(customer);
            String passWord = passwordEncoder.encode(registDto.getPassword());
            if(repone.findByEmail(registDto.getEmail()).isPresent()) {
                redirectAttributes.addFlashAttribute("message", "bị trùng email");
                return "redirect:/BeeStore/DangKy";
            }
            user.setEmail(registDto.getEmail());
            user.setCustomer(newCustomer);
            user.setPassword(passWord);
            user.setCode(userService.generateAccountCode());
            // Mặc định trạng thái là true nếu không được chọn
            if (user.getIsNonLocked() == null) {
                user.setIsNonLocked(true);
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


