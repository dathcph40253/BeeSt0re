package com.example.demo.Api;

import com.example.demo.Dto.UserDto;
import com.example.demo.Entity.User;
import com.example.demo.repository.UserRepone;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/BeeStore")
public class ApiController {
    @Autowired
    private UserRepone userReponse;

    @PostMapping("/DangKy")
    public List<User> getUser(@RequestBody List<User> user) {
        return userReponse.saveAll(user);
    }

    @GetMapping("/NguoiDung")
    public List<User> NguoiDung(@RequestParam(name = "id", required = false) List<Integer> id) {
        if (id == null || id.isEmpty()) {
            return userReponse.findAll();
        } else {
            return userReponse.findByIdIn(id);
        }
    }

    @PostMapping("/DangNhap")
    @ResponseBody
    public List<String> LoginUser(@RequestBody List<UserDto> users) {
        List<String> results = new ArrayList<>();
        for (UserDto user : users) {
            Optional<User> existed = userReponse.findByNameAndPassword(user.getName(), user.getPassword());
            if (existed.isPresent()) {
                results.add("Đăng nhập thành công " + user.getName() + " VaiTro " + existed.get().getRole());
            } else {
                results.add("Đăng nhập thất bại " + user.getName());
            }
        }
        return results;
    }
}

