package com.example.demo.controller;


import com.example.demo.Entity.ProductDetail;
import com.example.demo.service.ProductDiscountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDateTime;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class ProductDiscountController {

    @Autowired
    private ProductDiscountService productDiscountService;

    // GET: Hiển thị danh sách biến thể và giảm giá
    @GetMapping("/ProductDiscount")
    public String viewDiscountPage(Model model) {
        List<ProductDetail> productDetails = productDiscountService.getAllProductDetails();
        model.addAttribute("productDetails", productDetails);
        return "admin/product-discount/productdiscount";
    }

    // POST: Cập nhật hoặc thêm giảm giá cho biến thể
    @PostMapping("/update")
    public String updateDiscount(
            @RequestParam("productDetailId") Long productDetailId,
            @RequestParam("discountedAmount") Float discountedAmount,
            @RequestParam("startDate") @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm") LocalDateTime startDate,
            @RequestParam("endDate") @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm") LocalDateTime endDate,
            @RequestParam("closed") Boolean closed,
            RedirectAttributes redirectAttributes
    ) {
        try {
            productDiscountService.saveOrUpdateDiscount(productDetailId, discountedAmount, startDate, endDate, closed);
            redirectAttributes.addFlashAttribute("message", "Cập nhật giảm giá thành công!");
            redirectAttributes.addFlashAttribute("messageType", "success");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("message", "Lỗi khi cập nhật giảm giá!");
            redirectAttributes.addFlashAttribute("messageType", "danger");
        }
        return "redirect:/ProductDiscount";
    }

    // (Tùy chọn) POST: Xóa giảm giá
    @PostMapping("/delete")
    public String deleteDiscount(@RequestParam("discountId") Long discountId,
                                 RedirectAttributes redirectAttributes) {
        try {
            productDiscountService.deleteDiscountById(discountId);
            redirectAttributes.addFlashAttribute("message", "Đã xóa giảm giá.");
            redirectAttributes.addFlashAttribute("messageType", "success");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("message", "Lỗi khi xóa giảm giá.");
            redirectAttributes.addFlashAttribute("messageType", "danger");
        }
        return "redirect:/ProductDiscount";
    }
}
