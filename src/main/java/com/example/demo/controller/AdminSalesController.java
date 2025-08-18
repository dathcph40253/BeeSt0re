package com.example.demo.controller;

import com.example.demo.Entity.*;
import com.example.demo.repository.BillRepository;
import com.example.demo.repository.DiscountRepo;
import com.example.demo.repository.PaymentMethodRepository;
import com.example.demo.service.BillService;
import com.example.demo.service.CartService;
import com.example.demo.service.ProductDetailService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/admin/sales")
public class AdminSalesController {

    @Autowired
    private ProductDetailService productDetailService;

    @Autowired
    private CartService cartService;

    @Autowired
    private BillService billService;

    @Autowired
    private PaymentMethodRepository paymentMethodRepository;

    @Autowired
    private DiscountRepo discountRepo;

    @Autowired
    private BillRepository billRepository;

    // Trang bán hàng dành cho admin/nhân viên với 3 bảng: sản phẩm, giỏ hàng, hóa đơn gần đây
    @GetMapping
    public String salesPage(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/Login";
        }

        List<ProductDetail> productDetails = productDetailService.getAll();
        List<Cart> cartItems = cartService.getCartByUser(user);
        Double cartTotal = cartService.getCartTotal(user);
        List<PaymentMethod> paymentMethods = paymentMethodRepository.findByStatusTrue();
        List<Discount> availableDiscounts = discountRepo.findByDeleteFalse();
        List<Bill> recentBills = billRepository.findTop10ByOrderByCreateDateDesc();

        model.addAttribute("productDetails", productDetails);
        model.addAttribute("cartItems", cartItems);
        model.addAttribute("cartTotal", cartTotal);
        model.addAttribute("paymentMethods", paymentMethods);
        model.addAttribute("discounts", availableDiscounts);
        model.addAttribute("recentBills", recentBills);
        model.addAttribute("customer", user.getCustomer());

        return "admin/sales";
    }

    // Click vào sản phẩm để thêm vào giỏ hàng (mặc định +1)
    @PostMapping("/cart/add")
    public String addToCart(@RequestParam("productDetailId") Long productDetailId,
                            @RequestParam(value = "quantity", required = false, defaultValue = "1") Integer quantity,
                            HttpSession session,
                            RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/Login";
        }
        try {
            ProductDetail productDetail = productDetailService.getProductDetailById(productDetailId);
            if (productDetail == null) {
                redirectAttributes.addFlashAttribute("error", "Sản phẩm không tồn tại");
                return "redirect:/admin/sales";
            }
            if (productDetail.getQuantity() == null || productDetail.getQuantity() < quantity) {
                redirectAttributes.addFlashAttribute("error", "Không đủ hàng trong kho");
                return "redirect:/admin/sales";
            }
            cartService.addToCart(user, productDetail, quantity);
            redirectAttributes.addFlashAttribute("success", "Đã thêm vào giỏ hàng");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Lỗi: " + e.getMessage());
        }
        return "redirect:/admin/sales";
    }

    // Cập nhật số lượng sản phẩm trong giỏ (theo cartId)
    @PostMapping("/cart/update")
    public String updateCartItem(@RequestParam("cartId") Long cartId,
                                 @RequestParam("quantity") Integer quantity,
                                 RedirectAttributes redirectAttributes) {
        try {
            Cart updated = cartService.updateCartItemQuantity(cartId, quantity);
            if (updated == null) {
                redirectAttributes.addFlashAttribute("success", "Đã xóa sản phẩm khỏi giỏ hàng");
            } else {
                redirectAttributes.addFlashAttribute("success", "Đã cập nhật số lượng");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/sales";
    }

    // Xóa một item khỏi giỏ
    @PostMapping("/cart/remove")
    public String removeCartItem(@RequestParam("cartId") Long cartId,
                                 RedirectAttributes redirectAttributes) {
        try {
            cartService.removeFromCart(cartId);
            redirectAttributes.addFlashAttribute("success", "Đã xóa sản phẩm khỏi giỏ hàng");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/sales";
    }

    // Tạo hóa đơn và chuyển giỏ hàng thành chi tiết hóa đơn
    @PostMapping("/place-order")
    public String placeOrder(@RequestParam("billingAddress") String billingAddress,
                             @RequestParam("invoiceType") String invoiceType,
                             @RequestParam("paymentMethodId") Long paymentMethodId,
                             @RequestParam(value = "discountId", required = false) Long discountId,
                             HttpSession session,
                             RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/Login";
        }
        try {
            // Kiểm tra tồn kho trước khi tạo hóa đơn
            if (!cartService.validateCartStock(user)) {
                redirectAttributes.addFlashAttribute("error", "Một số sản phẩm trong giỏ hàng không đủ số lượng");
                return "redirect:/admin/sales";
            }
            PaymentMethod paymentMethod = paymentMethodRepository.findById(paymentMethodId).orElse(null);
            Discount discount = null;
            if (discountId != null) {
                discount = discountRepo.findById(discountId).orElse(null);
            }
            Bill bill = billService.createBillFromCart(user, billingAddress, invoiceType, paymentMethod, discount);
            redirectAttributes.addFlashAttribute("success", "Đã tạo hóa đơn thành công! Mã: " + bill.getCode());
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Đặt hàng thất bại: " + e.getMessage());
        }
        return "redirect:/admin/sales";
    }
}

