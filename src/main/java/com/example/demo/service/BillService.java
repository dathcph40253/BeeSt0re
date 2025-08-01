package com.example.demo.service;

import com.example.demo.Entity.*;
import com.example.demo.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class BillService {

    @Autowired
    private BillRepository billRepository;

    @Autowired
    private BillDetailRepository billDetailRepository;

    @Autowired
    private CartRepository cartRepository;

    @Autowired
    private ProductDetailService productDetailService;

    // Tạo hóa đơn từ giỏ hàng
    public Bill createBillFromCart(User user, String billingAddress, String invoiceType, PaymentMethod paymentMethod, Discount discount) {
        List<Cart> cartItems = cartRepository.findByAccountOrderByCreateDateDesc(user);
        
        if (cartItems.isEmpty()) {
            throw new RuntimeException("Giỏ hàng trống");
        }

        // Tạo hóa đơn
        Bill bill = Bill.builder()
                .code(generateBillCode())
                .billingAddress(billingAddress)
                .invoiceType(invoiceType)
                .customer(user.getCustomer())
                .paymentMethod(paymentMethod)
                .discountCode(discount)
                .status("PENDING")
                .build();

        // Tính tổng tiền
        double totalAmount = 0;
        for (Cart cartItem : cartItems) {
            totalAmount += cartItem.getTotalPrice();
        }
        bill.setAmount(totalAmount);

        // Áp dụng giảm giá
        if (discount != null) {
            double discountAmount = calculateDiscountAmount(totalAmount, discount);
            bill.setPromotionPrice(discountAmount);
        }

        bill = billRepository.save(bill);

        // Tạo chi tiết hóa đơn
        for (Cart cartItem : cartItems) {
            BillDetail billDetail = BillDetail.builder()
                    .bill(bill)
                    .productDetail(cartItem.getProductDetail())
                    .quantity(cartItem.getQuantity())
                    .momentPrice(cartItem.getProductDetail().getPrice())
                    .build();
            billDetailRepository.save(billDetail);

            // Cập nhật số lượng tồn kho
            ProductDetail productDetail = cartItem.getProductDetail();
            productDetail.setQuantity(productDetail.getQuantity() - cartItem.getQuantity());
            productDetailService.save(productDetail);
        }

        // Xóa giỏ hàng
        cartRepository.deleteByAccount(user);

        return bill;
    }

    // Cập nhật trạng thái hóa đơn
    public Bill updateBillStatus(Long billId, String newStatus, String updatedBy) {
        Optional<Bill> billOpt = billRepository.findById(billId);
        if (billOpt.isPresent()) {
            Bill bill = billOpt.get();
            bill.setStatus(newStatus);
            return billRepository.save(bill);
        }
        throw new RuntimeException("Không tìm thấy hóa đơn");
    }

    // Tính toán số tiền giảm giá
    private double calculateDiscountAmount(double totalAmount, Discount discount) {
        if (discount.getPercentage() != null && discount.getPercentage() > 0) {
            double discountAmount = totalAmount * discount.getPercentage() / 100;
            if (discount.getMaximumAmount() != null) {
                return Math.min(discountAmount, discount.getMaximumAmount());
            }
            return discountAmount;
        } else if (discount.getAmount() != null) {
            return discount.getAmount();
        }
        return 0;
    }

    // Tạo mã hóa đơn
    private String generateBillCode() {
        List<String> latestCodes = billRepository.findLatestBillCode();
        int nextNumber = 1;
        if (!latestCodes.isEmpty()) {
            String lastCode = latestCodes.get(0);
            String numberPart = lastCode.substring(2);
            try {
                nextNumber = Integer.parseInt(numberPart) + 1;
            } catch (NumberFormatException e) {
                nextNumber = 1;
            }
        }
        return String.format("HD%06d", nextNumber);
    }

    // Lấy hóa đơn theo ID
    public Bill getBillById(Long id) {
        return billRepository.findById(id).orElse(null);
    }

    // Lấy hóa đơn theo customer
    public List<Bill> getBillsByCustomer(Customer customer) {
        return billRepository.findByCustomerOrderByCreateDateDesc(customer);
    }

    // Lấy tất cả hóa đơn
    public List<Bill> getAllBills() {
        return billRepository.findAll();
    }

    // Lấy hóa đơn theo trạng thái
    public List<Bill> getBillsByStatus(String status) {
        return billRepository.findByStatusOrderByCreateDateDesc(status);
    }

    // Tính tổng doanh thu
    public Double getTotalRevenue() {
        return billRepository.getTotalRevenue();
    }

    // Tính doanh thu theo khoảng thời gian
    public Double getRevenueByDateRange(LocalDateTime startDate, LocalDateTime endDate) {
        return billRepository.getTotalRevenueByDateRange(startDate, endDate);
    }
}
