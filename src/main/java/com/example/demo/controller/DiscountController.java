package com.example.demo.controller;

import com.example.demo.Entity.Discount;
import com.example.demo.repository.DiscountRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/BeeStore")
public class DiscountController {
    @Autowired
    private DiscountRepo discountRepo;

    @GetMapping("/Discount")
    public String discount(Model model) {
        List<Discount> discounts = discountRepo.findByDeleteFalse();
        model.addAttribute("discounts", discounts);
        return "discount";
    }
    @GetMapping("/Discount/delete")
    public String delete(@RequestParam(required = false) Long id) {
        Discount discounts = discountRepo.findById(id).orElse(null);
        if (discounts != null) {
            discounts.setDelete(true);
            discountRepo.save(discounts);
        }
        return "redirect:/BeeStore/Discount";
    }
}
