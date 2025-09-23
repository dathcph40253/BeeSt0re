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

    // ============aas===== Tạo hóa đơn từ giỏ hàng trong DB =================
    public Bill createBillFromCart(User user, String billingAddress, String invoiceType,
                                   PaymentMethod paymentMethod, Discount discount) {
        List<Cart> cartItems = cartRepository.findByAccountOrderByCreateDateDesc(user);

        if (cartItems.isEmpty()) {
            throw new RuntimeException("Giỏ hàng trống");
        }

        double totalAmount = cartItems.stream()
                .mapToDouble(Cart::getTotalPrice)
                .sum();

        double discountAmount = 0.0;
        if (discount != null) {
            discountAmount = calculateDiscountAmount(totalAmount, discount);
        }

        Bill bill = Bill.builder()
                .code(generateBillCode())
                .billingAddress(billingAddress)
                .invoiceType(invoiceType)
                .customer(user.getCustomer())
                .paymentMethod(paymentMethod)
                .discountCode(discount)
                .createDate(LocalDateTime.now())
                .status("PENDING")
                .build();

        // đảm bảo set tiền
        bill.setAmount(totalAmount);
        bill.setPromotionPrice(discountAmount);

        bill = billRepository.save(bill);

        for (Cart cartItem : cartItems) {
            BillDetail billDetail = BillDetail.builder()
                    .bill(bill)
                    .productDetail(cartItem.getProductDetail())
                    .quantity(cartItem.getQuantity())
                    .momentPrice(cartItem.getProductDetail().getPrice())
                    .returnQuantity(0)
                    .build();
            billDetailRepository.save(billDetail);

            ProductDetail productDetail = cartItem.getProductDetail();
            productDetail.setQuantity(productDetail.getQuantity() - cartItem.getQuantity());
            productDetailService.save(productDetail);
        }

        cartRepository.deleteByAccount(user);

        return bill;
    }

    // ================= Tạo hóa đơn từ giỏ hàng tạm (multi-cart POS) =================
    public Bill createBillFromTempCart(User user, String billingAddress, String invoiceType,
                                       PaymentMethod paymentMethod, Discount discount,
                                       List<Cart> cartItems) {
        if (cartItems == null || cartItems.isEmpty()) {
            throw new RuntimeException("Giỏ hàng trống");
        }

        double totalAmount = cartItems.stream()
                .mapToDouble(Cart::getTotalPrice)
                .sum();

        double discountAmount = 0.0;
        if (discount != null) {
            discountAmount = calculateDiscountAmount(totalAmount, discount);
        }

        Bill bill = Bill.builder()
                .code(generateBillCode())
                .billingAddress(billingAddress)
                .invoiceType(invoiceType)
                .customer(user.getCustomer())
                .paymentMethod(paymentMethod)
                .discountCode(discount)
                .createDate(LocalDateTime.now())
                .status("SUCCESS")
                .build();

        // đảm bảo set tiền
        bill.setAmount(totalAmount);
        bill.setPromotionPrice(discountAmount);



        bill = billRepository.save(bill);

        for (Cart c : cartItems) {
            BillDetail detail = BillDetail.builder()
                    .bill(bill)
                    .productDetail(c.getProductDetail())
                    .quantity(c.getQuantity())
                    .momentPrice(c.getProductDetail().getPrice())
                    .returnQuantity(0)
                    .build();
            billDetailRepository.save(detail);

            ProductDetail pd = c.getProductDetail();
            pd.setQuantity(pd.getQuantity() - c.getQuantity());
            productDetailService.save(pd);
        }

        return bill;
    }

    // ================= Các hàm hỗ trợ =================

    public Bill updateBillStatus(Long billId, String newStatus, String updatedBy) {
        Optional<Bill> billOpt = billRepository.findById(billId);
        if (billOpt.isPresent()) {
            Bill bill = billOpt.get();
            bill.setStatus(newStatus);
            return billRepository.save(bill);
        }
        throw new RuntimeException("Không tìm thấy hóa đơn");
    }

    private double calculateDiscountAmount(double totalAmount, Discount discount) {
        if( discount.getMinimumAmountInCart() != null && totalAmount < discount.getMinimumAmountInCart()){
            return 0;
        }
        if (discount.getType() != null) {
            if (discount.getType() == 1 && discount.getPercentage() != null && discount.getPercentage() > 0) {
                double discountAmount = totalAmount * discount.getPercentage() / 100;
                if (discount.getMaximumAmount() != null) {
                    return Math.min(discountAmount, discount.getMaximumAmount());
                }
                return discountAmount;
            } else if (discount.getType() == 2 && discount.getAmount() != null && discount.getAmount() > 0) {
                return discount.getAmount();
            }else  if (discount.getType() == 3 && discount.getPercentage() != null && discount.getPercentage() > 0) {
                double discountAmount = totalAmount * discount.getPercentage() / 100;
                if (discount.getMaximumAmount() != null) {
                    return Math.min(discountAmount, discount.getMaximumAmount());
                }
                return discountAmount;
        }
    }   
        return 0;
    }

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

    public Bill getBillById(Long id) {
        return billRepository.findById(id).orElse(null);
    }

    public List<Bill> getBillsByCustomer(Customer customer) {
        return billRepository.findByCustomerOrderByCreateDateDesc(customer);
    }

    public List<Bill> getAllBills() {
        return billRepository.findAll();
    }

    public List<Bill> getBillsByStatus(String status) {
        return billRepository.findByStatusOrderByCreateDateDesc(status);
    }

    public Double getTotalRevenue() {
        return billRepository.getTotalRevenue();
    }

    public Double getRevenueByDateRange(LocalDateTime startDate, LocalDateTime endDate) {
        return billRepository.getTotalRevenueByDateRange(startDate, endDate);
    }
}
