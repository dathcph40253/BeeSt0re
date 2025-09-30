package com.example.demo.service;
import com.example.demo.Entity.Account;
import com.example.demo.Entity.VerificationCode;
import com.example.demo.repository.AccountRepository;
import com.example.demo.repository.VerificationCodeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.Optional;
import java.util.UUID;

@Service
public class AccountService {
    @Autowired
    private AccountRepository accountRepository;

    @Autowired
    private VerificationCodeRepository verificationCodeRepository;

    // Khai báo và tiêm (inject) PasswordEncoder đã được cấu hình sẵn
    @Autowired
    private PasswordEncoder passwordEncoder;

    public String forgotPassword(String email) {
        // ... (phần logic này giữ nguyên) ...
        return "Mã xác minh đã được gửi đến email của bạn.";
    }

    public String resetPassword(String code, String newPassword) {
        Optional<VerificationCode> optionalVerificationCode = verificationCodeRepository.findByCode(code);

        if (optionalVerificationCode.isEmpty()) {
            return "Mã xác minh không hợp lệ.";
        }

        VerificationCode verificationCode = optionalVerificationCode.get();
        if (verificationCode.getExpiryTime().isBefore(LocalDateTime.now())) {
            verificationCodeRepository.delete(verificationCode);
            return "Mã xác minh đã hết hạn.";
        }

        // Cập nhật mật khẩu mới bằng cách sử dụng passwordEncoder để băm
        Account account = verificationCode.getAccount();
        account.setPassword(passwordEncoder.encode(newPassword));
        accountRepository.save(account);

        // Xóa mã xác minh sau khi sử dụng thành công
        verificationCodeRepository.delete(verificationCode);

        return "Mật khẩu của bạn đã được đặt lại thành công.";
    }
}
