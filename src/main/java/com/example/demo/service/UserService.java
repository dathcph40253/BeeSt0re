package com.example.demo.service;

import com.example.demo.Entity.User;
import com.example.demo.repository.UserRepone;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;

@Service
public class UserService {
    @Autowired
    private UserRepone userReponse;

    public User saveUser(User user) {
        // Nếu ngày tạo chưa được set từ phía controller, set tại đây
        if (user.getNgayTao() == null) {
            user.setNgayTao(LocalDate.now());
        }
        return userReponse.save(user);
    }
}
