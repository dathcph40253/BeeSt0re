package com.example.demo.controller;

import com.example.demo.Entity.Bill;
import com.example.demo.dto.SePayWebhookRequest;
import com.example.demo.repository.BillRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.regex.Pattern;
import java.util.regex.Matcher;
import java.util.Optional;

@RestController
@RequestMapping("/api/webhooks")
@RequiredArgsConstructor
public class WebhookController {

    private final BillRepository billRepository;

@PostMapping("/sepay-payment")
public ResponseEntity<String> handleWebhook(@RequestBody SePayWebhookRequest request) {
    System.out.println("===== 📩 Webhook SePay =====");
    System.out.println("📄 Description: " + request.getDescription());
    System.out.println("💰 Amount: " + request.getAmount());
    System.out.println("✅ Status: " + request.getStatus());

    String billCode = extractBillCode(request.getDescription());

    if (billCode == null) {
        return ResponseEntity.badRequest().body("❌ Không tìm thấy mã hóa đơn trong mô tả");
    }

    Optional<Bill> optionalBill = billRepository.findByCode(billCode);
    if (optionalBill.isEmpty()) {
        return ResponseEntity.badRequest().body("❌ Không tìm thấy hóa đơn với mã: " + billCode);
    }

    Bill bill = optionalBill.get();
    bill.setStatus(request.getStatus().toUpperCase()); // hoặc đổi sang "PAID" nếu bạn dùng enum
    billRepository.save(bill);

    return ResponseEntity.ok("✅ Đã cập nhật hóa đơn " + billCode + " thành " + request.getStatus());
}

private String extractBillCode(String description) {
    if (description == null) return null;
    description = description.trim().toUpperCase();

    // Dùng regex để tìm mã bắt đầu bằng HD + số
    Pattern pattern = Pattern.compile("(HD\\d+)");
    Matcher matcher = pattern.matcher(description);

    if (matcher.find()) {
        return matcher.group(1);
    }
    return null;
}

}
