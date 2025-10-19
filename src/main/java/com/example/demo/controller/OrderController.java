package com.example.demo.controller;

import com.example.demo.Entity.*;
import com.example.demo.repository.BillDetailRepository;
import com.example.demo.service.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
public class OrderController {

    @Autowired
    private BillService billService;

    @Autowired
    private BillDetailRepository billDetailRepository;

    // Hiển thị chi tiết đơn hàng
    @GetMapping("/orders/{id}")
    public String viewOrderDetail(@PathVariable Long id, HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/Login";
        }

        Bill bill = billService.getBillById(id);
        if (bill == null) {
            return "redirect:/orders";
        }

        // Kiểm tra quyền xem đơn hàng (chỉ chủ đơn hàng hoặc admin)
        if (!bill.getCustomer().getId().equals(user.getCustomer().getId()) && 
            !"ROLE_ADMIN".equals(user.getRole().getName()) && 
            !"ROLE_EMPLOYEE".equals(user.getRole().getName())) {
            return "redirect:/orders";
        }

        List<BillDetail> billDetails = billDetailRepository.findByBill(bill);

        model.addAttribute("bill", bill);
        model.addAttribute("billDetails", billDetails);

        return "user/client/order-detail";
    }

    // Danh sách đơn hàng của user
    @GetMapping("/orders")
    public String viewOrders(
        @RequestParam(value = "status", required = false) String status,
        HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/Login";
        }

        List<Bill> bills;
        if (status != null && !status.isEmpty()) {
            bills = billService.getBillsByCustomerAndStatus(user.getCustomer(), status);
        } else {
            bills = billService.getBillsByCustomer(user.getCustomer());
        }
        model.addAttribute("bills", bills);
        model.addAttribute("status", status);

        return "user/client/orders";
    }

    // Hủy đơn hàng
    @PostMapping("/orders/{id}/cancel")
    public String cancelOrder(@PathVariable Long id, 
                             HttpSession session, 
                             RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/Login";
        }

        try {
            Bill bill = billService.getBillById(id);
            if (bill == null) {
                redirectAttributes.addFlashAttribute("error", "Không tìm thấy đơn hàng");
                return "redirect:/orders";
            }

            // Kiểm tra quyền hủy đơn hàng
            if (!bill.getCustomer().getId().equals(user.getCustomer().getId())) {
                redirectAttributes.addFlashAttribute("error", "Bạn không có quyền hủy đơn hàng này");
                return "redirect:/orders";
            }

            // Cho tất cả được hủy trừ trạng thái cancelled and delivered and shipping
            if ( "CANCELLED".equals(bill.getStatus()) && "DELIVERED".equals(bill.getStatus()) && "SHIPPING".equals(bill.getStatus())) {
                redirectAttributes.addFlashAttribute("error", "Không thể hủy đơn hàng ở trạng thái hiện tại");
                return "redirect:/orders/" + id;
            }

            billService.updateBillStatus(id, "CANCELLED", user.getEmail());
            redirectAttributes.addFlashAttribute("success", "Đã hủy đơn hàng thành công");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Hủy đơn hàng thất bại: " + e.getMessage());
        }

        return "redirect:/orders/" + id;
    }

    // Admin - Quản lý đơn hàng
    @GetMapping("/admin/orders")
    public String adminViewOrders(@RequestParam(required = false) String status, Model model) {
        List<Bill> bills;
        if (status != null && !status.isEmpty()) {
            bills = billService.getBillsByStatus(status);
        } else {
            bills = billService.getAllBills();
        }

        model.addAttribute("bills", bills);
        model.addAttribute("selectedStatus", status);

        return "admin/orders/list";
    }

@GetMapping("/admin/orders/{id}")
public String adminViewOrderDetail(@PathVariable Long id, HttpSession session, Model model) {
    User user = (User) session.getAttribute("user");
    if (user == null || 
        (!"ROLE_ADMIN".equals(user.getRole().getName()) && !"ROLE_EMPLOYEE".equals(user.getRole().getName()))) {
        return "redirect:/Login";
    }

    Bill bill = billService.getBillById(id);
    if (bill == null) {
        return "redirect:/admin/orders";
    }

    List<BillDetail> billDetails = billDetailRepository.findByBill(bill);
    model.addAttribute("bill", bill);
    model.addAttribute("billDetails", billDetails);

    return "admin/orders/detail";
}



    // Admin - Cập nhật trạng thái đơn hàng
    @PostMapping("/admin/orders/{id}/update-status")
    public String adminUpdateOrderStatus(@PathVariable Long id,
                                       @RequestParam String status,
                                       HttpSession session,
                                       RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/Login";
        }

        try {
            billService.updateBillStatus(id, status, user.getEmail());
            redirectAttributes.addFlashAttribute("success", "Cập nhật trạng thái thành công cho đơn hàng #" + id);
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Cập nhật thất bại: " + e.getMessage());
        }

        return "redirect:/admin/orders";
    }
        @GetMapping("/admin/search-orders")
    public String searchOrders(@RequestParam("query") String query, Model model) {
        List<Bill> bills = billService.searchBills(query);
        model.addAttribute("bills", bills);
        model.addAttribute("searchQuery", query);
        return "admin/orders/list";
    }
}
