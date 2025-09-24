package com.example.demo.controller;

import com.example.demo.Entity.Discount;
import com.example.demo.repository.DiscountRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class DiscountController {
    @Autowired
    private DiscountRepo discountRepo;

    @GetMapping("/Discount")
    public String discount(Model model) {
        List<Discount> discounts = discountRepo.findByDeleteFalse();
        model.addAttribute("discounts", discounts);
        return "admin/discount/discount";
    }

    @GetMapping("/Discount/delete")
    public String delete(@RequestParam(required = false) Long id) {
        Discount discounts = discountRepo.findById(id).orElse(null);
        if (discounts != null) {
            discounts.setDelete(true);
            discountRepo.save(discounts);
        }
        return "redirect:/admin/Discount";
    }

    @GetMapping("/Discount/search")
    public String search(@RequestParam(name = "id") String id, Model model) {
        List<Discount> discounts;
        if (id != null && !id.isBlank()) {
            try {
                Long ids = Long.parseLong(id);
                Discount discount = discountRepo.findById(ids).orElse(null);
                if (discount != null && !discount.isDelete()) {
                    discounts = List.of(discount);
                } else {
                    discounts = new ArrayList<>();
                }
            } catch (NumberFormatException e) {
                discounts = new ArrayList<>();
            }
        } else {
            discounts = discountRepo.findByDeleteFalse();
        }
        model.addAttribute("discounts", discounts);
        return "admin/discount/discount";
    }

    // GET: Hiển thị form tạo mới discount
    @GetMapping("/Discount/create")
    public String createDiscountForm(Model model) {
        model.addAttribute("discount", new Discount());
        return "admin/discount/create";
    }

    // POST: Xử lý tạo mới discount
    @PostMapping("/Discount/add")
    public String addDiscount(
            @RequestParam("code") String code,
            @RequestParam("detail") String detail,
            @RequestParam(value = "amount", required = false) Float amount,
            @RequestParam(value = "percentage", required = false) Integer percentage,
            @RequestParam("startDate") @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm") LocalDateTime startDate,
            @RequestParam("endDate") @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm") LocalDateTime endDate,
            @RequestParam(value = "maximumAmount", required = false) Integer maximumAmount,
            @RequestParam(value = "maximumUsage", required = false) Integer maximumUsage,
            @RequestParam(value = "minimumAmountInCart", required = false) Float minimumAmountInCart,
            @RequestParam("status") Integer status,
            @RequestParam("type") Integer type,
            RedirectAttributes redirectAttributes
    ) {
        try {
            // Validation
            if (code == null || code.trim().isEmpty()) {
                redirectAttributes.addFlashAttribute("message", "Mã giảm giá không được để trống!");
                redirectAttributes.addFlashAttribute("messageType", "danger");
                return "redirect:/admin/Discount/create";
            }

            // Kiểm tra mã đã tồn tại
            List<Discount> existingDiscounts = discountRepo.findByDeleteFalse();
            boolean codeExists = existingDiscounts.stream()
                    .anyMatch(d -> code.equals(d.getCode()));

            if (codeExists) {
                redirectAttributes.addFlashAttribute("message", "Mã giảm giá đã tồn tại!");
                redirectAttributes.addFlashAttribute("messageType", "danger");
                return "redirect:/admin/Discount/create";
            }

            // Tạo discount mới
            Discount discount = Discount.builder()
                    .code(code)
                    .detail(detail)
                    .amount(amount)
                    .percentage(percentage)
                    .startDate(startDate)
                    .endDate(endDate)
                    .maximumAmount(maximumAmount)
                    .maximumUsage(maximumUsage)
                    .minimumAmountInCart(minimumAmountInCart)
                    .status(status)
                    .type(type)
                    .delete(false)
                    .build();

            discountRepo.save(discount);
            redirectAttributes.addFlashAttribute("message", "Thêm mã giảm giá thành công!");
            redirectAttributes.addFlashAttribute("messageType", "success");

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("message", "Lỗi khi thêm mã giảm giá: " + e.getMessage());
            redirectAttributes.addFlashAttribute("messageType", "danger");
        }

        return "redirect:/admin/Discount";
    }
}
