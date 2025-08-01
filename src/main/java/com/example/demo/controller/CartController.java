package com.example.demo.controller;

import com.example.demo.Entity.*;
import com.example.demo.service.*;
import com.example.demo.repository.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Controller
@RequestMapping("/cart")
public class CartController {

    @Autowired
    private CartService cartService;

    @Autowired
    private ProductDetailService productDetailService;

    @Autowired
    private BillService billService;

    @Autowired
    private PaymentMethodRepository paymentMethodRepository;

    @Autowired
    private DiscountRepo discountRepo;

    // Hiển thị giỏ hàng
    @GetMapping("")
    public String viewCart(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/Login";
        }

        List<Cart> cartItems = cartService.getCartByUser(user);
        Double cartTotal = cartService.getCartTotal(user);

        model.addAttribute("cartItems", cartItems);
        model.addAttribute("cartTotal", cartTotal);
        model.addAttribute("cartItemCount", cartItems.size());

        return "user/client/cart";
    }

    // Thêm sản phẩm vào giỏ hàng
    @PostMapping("/add")
    @ResponseBody
    public String addToCart(@RequestParam Long productDetailId, 
                           @RequestParam Integer quantity,
                           HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "error:Vui lòng đăng nhập";
        }

        try {
            ProductDetail productDetail = productDetailService.getProductDetailById(productDetailId);
            if (productDetail == null) {
                return "error:Sản phẩm không tồn tại";
            }

            if (productDetail.getQuantity() < quantity) {
                return "error:Không đủ hàng trong kho";
            }

            cartService.addToCart(user, productDetail, quantity);
            return "success:Đã thêm vào giỏ hàng";
        } catch (Exception e) {
            return "error:" + e.getMessage();
        }
    }

    // Cập nhật số lượng sản phẩm trong giỏ hàng
    @PostMapping("/update")
    @ResponseBody
    public String updateCartItem(@RequestParam Long cartId, 
                                @RequestParam Integer quantity) {
        try {
            cartService.updateCartItemQuantity(cartId, quantity);
            return "success:Cập nhật thành công";
        } catch (Exception e) {
            return "error:" + e.getMessage();
        }
    }

    // Xóa sản phẩm khỏi giỏ hàng
    @PostMapping("/remove")
    @ResponseBody
    public String removeFromCart(@RequestParam Long cartId) {
        try {
            cartService.removeFromCart(cartId);
            return "success:Đã xóa khỏi giỏ hàng";
        } catch (Exception e) {
            return "error:" + e.getMessage();
        }
    }

    // Trang thanh toán
    @GetMapping("/checkout")
    public String checkout(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/Login";
        }

        List<Cart> cartItems = cartService.getCartByUser(user);
        if (cartItems.isEmpty()) {
            return "redirect:/cart";
        }

        // Kiểm tra tồn kho
        if (!cartService.validateCartStock(user)) {
            model.addAttribute("error", "Một số sản phẩm trong giỏ hàng không đủ số lượng");
            return "redirect:/cart";
        }

        Double cartTotal = cartService.getCartTotal(user);
        List<PaymentMethod> paymentMethods = paymentMethodRepository.findByStatusTrue();
        List<Discount> availableDiscounts = discountRepo.findByDeleteFalse();

        model.addAttribute("cartItems", cartItems);
        model.addAttribute("cartTotal", cartTotal);
        model.addAttribute("paymentMethods", paymentMethods);
        model.addAttribute("discounts", availableDiscounts);
        model.addAttribute("customer", user.getCustomer());

        return "user/client/checkout";
    }

    // Xử lý đặt hàng
    @PostMapping("/place-order")
    public String placeOrder(@RequestParam String billingAddress,
                           @RequestParam String invoiceType,
                           @RequestParam Long paymentMethodId,
                           @RequestParam(required = false) Long discountId,
                           HttpSession session,
                           RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/Login";
        }

        try {
            PaymentMethod paymentMethod = paymentMethodRepository.findById(paymentMethodId).orElse(null);
            Discount discount = null;
            if (discountId != null) {
                discount = discountRepo.findById(discountId).orElse(null);
            }

            Bill bill = billService.createBillFromCart(user, billingAddress, invoiceType, paymentMethod, discount);
            
            redirectAttributes.addFlashAttribute("success", "Đặt hàng thành công! Mã đơn hàng: " + bill.getCode());
            return "redirect:/orders/" + bill.getId();
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Đặt hàng thất bại: " + e.getMessage());
            return "redirect:/cart/checkout";
        }
    }

    // Lấy số lượng item trong giỏ hàng (AJAX)
    @GetMapping("/count")
    @ResponseBody
    public long getCartItemCount(HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return 0;
        }
        return cartService.getCartItemCount(user);
    }

    // API tính toán discount
    @PostMapping("/api/discount/calculate")
    @ResponseBody
    public Map<String, Object> calculateDiscount(@RequestBody Map<String, Object> request) {
        Map<String, Object> response = new HashMap<>();

        try {
            Long discountId = Long.valueOf(request.get("discountId").toString());
            Double totalAmount = Double.valueOf(request.get("totalAmount").toString());

            Optional<Discount> discountOpt = discountRepo.findById(discountId);

            if (discountOpt.isPresent()) {
                Discount discount = discountOpt.get();
                double discountAmount = 0;

                if (discount.getPercentage() != null && discount.getPercentage() > 0) {
                    // Giảm theo phần trăm
                    discountAmount = totalAmount * discount.getPercentage() / 100;
                    if (discount.getMaximumAmount() != null && discountAmount > discount.getMaximumAmount()) {
                        discountAmount = discount.getMaximumAmount();
                    }
                } else if (discount.getAmount() != null) {
                    // Giảm theo số tiền cố định
                    discountAmount = discount.getAmount();
                }

                // Kiểm tra điều kiện tối thiểu
                if (discount.getMinimumAmountInCart() != null && totalAmount < discount.getMinimumAmountInCart()) {
                    response.put("success", false);
                    response.put("message", "Đơn hàng chưa đạt giá trị tối thiểu để áp dụng mã giảm giá này");
                    return response;
                }

                response.put("success", true);
                response.put("discountAmount", discountAmount);
                response.put("message", "Áp dụng mã giảm giá thành công");
            } else {
                response.put("success", false);
                response.put("message", "Mã giảm giá không tồn tại");
            }
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Có lỗi xảy ra khi tính toán giảm giá");
        }

        return response;
    }
}
