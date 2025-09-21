package com.example.demo.controller;

import com.example.demo.Entity.*;
import com.example.demo.repository.BillRepository;
import com.example.demo.repository.DiscountRepo;
import com.example.demo.repository.PaymentMethodRepository;
import com.example.demo.repository.UserRepone;
import com.example.demo.service.BillService;
import com.example.demo.service.InvoicePdfService;
import com.example.demo.service.ProductDetailService;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.util.*;

@Controller
@RequestMapping("/admin/sales")
public class AdminSalesController {

    @Autowired
    private ProductDetailService productDetailService;

    @Autowired
    private BillService billService;

    @Autowired
    private PaymentMethodRepository paymentMethodRepository;

    @Autowired
    private DiscountRepo discountRepo;

    @Autowired
    private BillRepository billRepository;

    @Autowired
    private UserRepone userrepo;

    @Autowired
    private InvoicePdfService invoicePdfService; // ✅ inject service in PDF

    // Helper: lấy map giỏ hàng từ session
    @SuppressWarnings("unchecked")
    private Map<Integer, List<Cart>> getAllCarts(HttpSession session) {
        Map<Integer, List<Cart>> carts = (Map<Integer, List<Cart>>) session.getAttribute("carts");
        if (carts == null) {
            carts = new HashMap<>();
            session.setAttribute("carts", carts);
        }
        return carts;
    }

    // Trang bán hàng (multi-cart)
    @GetMapping
    public String salesPage(HttpSession session, Model model,
                            @RequestParam(value = "keyword", required = false) String keyword,
                            @RequestParam(value = "tab", required = false) Integer tabId,
                            @RequestParam(value = "newTab", required = false) Boolean newTab,
                            @RequestParam(value = "removeTab", required = false) Integer removeTab) {

        User sessionUser = (User) session.getAttribute("user");
        if (sessionUser == null) return "redirect:/Login";

        User user = userrepo.findById(sessionUser.getId()).orElse(null);
        if (user == null) return "redirect:/Login";

        Customer customer = user.getCustomer();
        Map<Integer, List<Cart>> carts = getAllCarts(session);

        // Xóa tab
        if (removeTab != null) {
            carts.remove(removeTab);
            if (carts.isEmpty()) {
                carts.put(1, new ArrayList<>());
                tabId = 1;
            }
            session.setAttribute("carts", carts);
            return "redirect:/admin/sales?tab=" + (tabId != null ? tabId : 1);
        }

        // Thêm tab mới
        if (newTab != null && newTab) {
            int nextTab = carts.isEmpty() ? 1 : Collections.max(carts.keySet()) + 1;
            carts.put(nextTab, new ArrayList<>());
            session.setAttribute("carts", carts);
            return "redirect:/admin/sales?tab=" + nextTab;
        }

        // Nếu chưa chọn tab hoặc tab không tồn tại → lấy tab nhỏ nhất
        if (tabId == null || !carts.containsKey(tabId)) {
            tabId = carts.isEmpty() ? 1 : Collections.min(carts.keySet());
            carts.putIfAbsent(tabId, new ArrayList<>());
        }

        // Load sản phẩm
        List<ProductDetail> productDetails = (keyword != null && !keyword.trim().isEmpty())
                ? productDetailService.findByProductNameContainingIgnoreCase(keyword)
                : productDetailService.getAll();

        List<Cart> cartItems = carts.get(tabId);
        double cartTotal = cartItems.stream().mapToDouble(Cart::getTotalPrice).sum();

        model.addAttribute("productDetails", productDetails);
        model.addAttribute("cartItems", cartItems);
        model.addAttribute("cartTotal", cartTotal);
        model.addAttribute("paymentMethods", paymentMethodRepository.findByStatusTrue());
        model.addAttribute("discounts", discountRepo.findByDeleteFalse());
        model.addAttribute("recentBills", billRepository.findTop10ByOrderByCreateDateDesc());
        model.addAttribute("customer", customer);
        model.addAttribute("currentTab", tabId);
        model.addAttribute("carts", carts);

        return "admin/sales";
    }

    // Thêm sản phẩm vào giỏ (trừ tồn kho tạm thời)
    @PostMapping("/cart/add")
    public String addToCart(@RequestParam("productDetailId") Long productDetailId,
                            @RequestParam(value = "quantity", defaultValue = "1") Integer quantity,
                            @RequestParam("tabId") Integer tabId,
                            HttpSession session,
                            RedirectAttributes redirectAttributes) {
        Map<Integer, List<Cart>> carts = getAllCarts(session);
        List<Cart> cartItems = carts.getOrDefault(tabId, new ArrayList<>());

        ProductDetail productDetail = productDetailService.getProductDetailById(productDetailId);
        if (productDetail == null || productDetail.getQuantity() < quantity) {
            redirectAttributes.addFlashAttribute("error", "Sản phẩm không đủ tồn kho");
            return "redirect:/admin/sales?tab=" + tabId;
        }

        // trừ kho ngay khi thêm
        productDetail.setQuantity(productDetail.getQuantity() - quantity);
        productDetailService.save(productDetail);

        Optional<Cart> existing = cartItems.stream()
                .filter(c -> c.getProductDetail().getId().equals(productDetailId))
                .findFirst();

        if (existing.isPresent()) {
            existing.get().setQuantity(existing.get().getQuantity() + quantity);
        } else {
            Cart c = new Cart();
            c.setProductDetail(productDetail);
            c.setQuantity(quantity);
            cartItems.add(c);
        }

        carts.put(tabId, cartItems);
        session.setAttribute("carts", carts);
        redirectAttributes.addFlashAttribute("success", "Đã thêm vào giỏ Đơn " + tabId);

        return "redirect:/admin/sales?tab=" + tabId;
    }

    // Xóa sản phẩm (hoàn lại tồn kho)
    @PostMapping("/cart/remove")
    public String removeCartItem(@RequestParam("cartIndex") Integer cartIndex,
                                 @RequestParam("tabId") Integer tabId,
                                 HttpSession session,
                                 RedirectAttributes redirectAttributes) {
        Map<Integer, List<Cart>> carts = getAllCarts(session);
        List<Cart> cartItems = carts.getOrDefault(tabId, new ArrayList<>());

        if (cartIndex >= 0 && cartIndex < cartItems.size()) {
            Cart removed = cartItems.remove((int) cartIndex);
            ProductDetail pd = removed.getProductDetail();
            pd.setQuantity(pd.getQuantity() + removed.getQuantity()); // hoàn lại
            productDetailService.save(pd);
            redirectAttributes.addFlashAttribute("success", "Đã xóa sản phẩm");
        } else {
            redirectAttributes.addFlashAttribute("error", "Không tìm thấy sản phẩm");
        }

        carts.put(tabId, cartItems);
        session.setAttribute("carts", carts);
        return "redirect:/admin/sales?tab=" + tabId;
    }

    // Thanh toán 1 tab
    @PostMapping("/place-order")
    public String placeOrder(@RequestParam("billingAddress") String billingAddress,
                             @RequestParam("invoiceType") String invoiceType,
                             @RequestParam("paymentMethodId") Long paymentMethodId,
                             @RequestParam(value = "discountId", required = false) Long discountId,
                             @RequestParam("tabId") Integer tabId,
                             HttpSession session,
                             RedirectAttributes redirectAttributes) {
        Map<Integer, List<Cart>> carts = getAllCarts(session);
        List<Cart> cartItems = carts.getOrDefault(tabId, new ArrayList<>());

        if (cartItems.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Giỏ hàng trống");
            return "redirect:/admin/sales?tab=" + tabId;
        }

        try {
            PaymentMethod paymentMethod = paymentMethodRepository.findById(paymentMethodId).orElse(null);
            Discount discount = (discountId != null) ? discountRepo.findById(discountId).orElse(null) : null;

            User sessionUser = (User) session.getAttribute("user");
            Bill bill = billService.createBillFromTempCart(sessionUser, billingAddress, invoiceType, paymentMethod, discount, cartItems);

            // Xóa giỏ của tab đã thanh toán
            carts.remove(tabId);
            session.setAttribute("carts", carts);

            // ✅ Thêm lastBillId để JSP hiện nút in PDF
            redirectAttributes.addFlashAttribute("lastBillId", bill.getId());

            redirectAttributes.addFlashAttribute("success", "Đã tạo hóa đơn thành công: " + bill.getCode());
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Thanh toán thất bại: " + e.getMessage());
        }

        return "redirect:/admin/sales";
    }

    // In PDF
    @GetMapping("/print/{billId}")
    public void printInvoice(@PathVariable("billId") Long billId,
                             HttpServletResponse response) {
        try {
            Bill bill = billRepository.findById(billId).orElse(null);
            if (bill != null) {
                invoicePdfService.exportBillToPdf(bill, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy hóa đơn");
            }
        } catch (Exception e) {
            e.printStackTrace();
            try {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi in hóa đơn");
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        }
    }
}
