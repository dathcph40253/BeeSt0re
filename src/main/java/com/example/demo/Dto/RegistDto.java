package com.example.demo.Dto;

import jakarta.persistence.Column;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.*;

import java.time.LocalDateTime;
import java.util.Date;

@Builder
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class RegistDto {

    @NotBlank(message = "email ko được để trống")
    @Email( message =  "email ko đúng định dạng")
    private String email;

    @NotBlank(message = "mật khẩu không được để trống")
    @Size( min = 6, message = "mật khẩu nhỏ hơn 6 kí tự")
    private String password;

    private LocalDateTime birthDay;

    private Long roleId;

    @Builder.Default
    private Boolean isNonLocked = true;

}
