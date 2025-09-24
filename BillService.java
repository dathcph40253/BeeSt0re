package com.example.demo.service;

import com.example.demo.Entity.*;
import com.example.demo.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.ArrayList;
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

    @Autowired
    private DiscountRepo discountRepo;

    // ================== Tạo hóa đơn từ giỏ hàng trong DB ==================
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

            // ✅ Trừ kho khi tạo bill từ giỏ DB
            ProductDetail productDetail = cartItem.getProductDetail();
            productDetail.setQuantity(productDetail.getQuantity() - cartItem.getQuantity());
            productDetailService.save(productDetail);
        }

        // Xóa giỏ DB
        cartRepository.deleteByAccount(user);

        // ✅ Trừ số lượt mã giảm giá
        if (discount != null && discount.getMaximumUsage() != null && discount.getMaximumUsage() > 0) {
            discount.setMaximumUsage(discount.getMaximumUsage() - 1);
            discountRepo.save(discount);
        }

        return bill;
    }

    // ================== Tạo hóa đơn từ giỏ hàng tạm (multi-cart POS) ==================
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
        }

        // ✅ Trừ số lượt mã giảm giá
        if (discount != null && discount.getMaximumUsage() != null && discount.getMaximumUsage() > 0) {
            discount.setMaximumUsage(discount.getMaximumUsage() - 1);
            discountRepo.save(discount);
        }

        return bill;
    }

    // ================== Hủy hóa đơn (hoàn kho + hoàn mã giảm giá) ==================
    public void cancelBill(Long billId) {
        Bill bill = billRepository.findById(billId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy hóa đơn"));

        // Hoàn kho sản phẩm
        for (BillDetail detail : bill.getBillDetails()) {
            ProductDetail pd = detail.getProductDetail();
            pd.setQuantity(pd.getQuantity() + detail.getQuantity());
            productDetailService.save(pd);
        }

        // Hoàn lại lượt mã giảm giá
        Discount discount = bill.getDiscountCode();
        if (discount != null && discount.getMaximumUsage() != null) {
            discount.setMaximumUsage(discount.getMaximumUsage() + 1);
            discountRepo.save(discount);
        }

        bill.setStatus("CANCELLED");
        billRepository.save(bill);
    }

    // ================== Cập nhật trạng thái ==================
    public Bill updateBillStatus(Long billId, String newStatus, String updatedBy) {
        Optional<Bill> billOpt = billRepository.findById(billId);
        if (billOpt.isPresent()) {
            Bill bill = billOpt.get();
            bill.setStatus(newStatus);
            return billRepository.save(bill);
        }
        throw new RuntimeException("Không tìm thấy hóa đơn");
    }

    // ================== Hàm tính toán giảm giá ==================
    private double calculateDiscountAmount(double totalAmount, Discount discount) {
        if (discount.getStatus() == null || discount.getStatus() != 1) {
            throw new RuntimeException("Mã giảm giá không hợp lệ hoặc đã bị vô hiệu");
        }
        if (discount.getStartDate() != null && LocalDateTime.now().isBefore(discount.getStartDate())) {
            throw new RuntimeException("Mã giảm giá chưa đến thời gian áp dụng");
        }
        if (discount.getEndDate() != null && LocalDateTime.now().isAfter(discount.getEndDate())) {
            throw new RuntimeException("Mã giảm giá đã hết hạn");
        }
        if (discount.getMinimumAmountInCart() != null && totalAmount < discount.getMinimumAmountInCart()) {
            throw new RuntimeException("Đơn hàng của bạn tối thiểu " + discount.getMinimumAmountInCart() + " để áp dụng mã");
        }
        if (discount.getMaximumUsage() != null && discount.getMaximumUsage() <= 0) {
            throw new RuntimeException("Mã giảm giá đã hết lượt sử dụng");
        }

        if (discount.getType() != null) {
            if (discount.getType() == 1 && discount.getPercentage() != null && discount.getPercentage() > 0) {
                double discountAmount = totalAmount * discount.getPercentage() / 100.0;
                if (discount.getMaximumAmount() != null) {
                    discountAmount = Math.min(discountAmount, discount.getMaximumAmount());
                }
                return discountAmount;
            } else if (discount.getType() == 2 && discount.getAmount() != null && discount.getAmount() > 0) {
                return discount.getAmount();
            }
        }

        return 0;
    }

    // ================== Sinh mã hóa đơn ==================
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

    // ================== Các hàm tiện ích ==================
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


    //show mã giảm gia ho le theo gia theienf
    public List<Discount> filterValidDiscounts(double cartTotal) {
        List<Discount> all = discountRepo.findByDeleteFalse();
        List<Discount> valid = new ArrayList<>();
        for (Discount d : all) {
            try {
                calculateDiscountAmount(cartTotal, d);
                valid.add(d);
            } catch (Exception ignored) {}
        }
        return valid;
    }

}
