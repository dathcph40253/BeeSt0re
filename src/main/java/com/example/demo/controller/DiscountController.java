package com.example.demo.controller;

import com.example.demo.Entity.Discount;
import com.example.demo.repository.DiscountRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@Controller
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
        return "redirect:/Discount";
    }
    @GetMapping("/Discount/search")
    public String search(@RequestParam(name = "id") String id, Model model) {
        List<Discount> discounts;
        if(id != null && !id.isBlank() ) {
            try{
                Long ids =  Long.parseLong(id);
                Discount discount = discountRepo.findById(ids).orElse(null);
                if(discount != null) {
                    discounts = List.of(discount);
                }else{
                    discounts = new ArrayList<>();
                }
            }catch (NumberFormatException e){
                discounts = new ArrayList<>();
            }
            }
        else{
            discounts = discountRepo.findByDeleteFalse();
        }
        model.addAttribute("discounts", discounts);
        return "discount";
    }
}
