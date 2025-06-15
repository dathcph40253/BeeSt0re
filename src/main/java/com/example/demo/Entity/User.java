package com.example.demo.Entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.*;
import java.time.LocalDateTime;
import java.time.LocalDate;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Entity
@Table(name = "NguoiDung")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Integer id;

    @Column(name = "TenTaiKhoan", nullable = false, unique = true)
    @NotBlank(message = "Không được để trống tên tài khoản")
    private String name;

    @Column(name = "MatKhau", nullable = false)
    @NotBlank(message = "Không được để trống mật khẩu")
    @Size(min = 6, message = "Mật khẩu phải có ít nhất 6 ký tự")
    private String password;

    @Column(name = "VaiTro", nullable = false)
    @NotBlank(message = "Vui lòng chọn vai trò")
    private String role;

    @Column(name = "HoTen", nullable = false)
    @NotBlank(message = "Không được để trống họ tên")
    private String hoTen;

    @Column(name = "GioiTinh")
    @NotBlank(message = "Vui lòng chọn giới tính")
    private String gioiTinh;

    @Column(name = "NgaySinh")
    @NotNull(message = "Vui lòng chọn ngày sinh")
    private LocalDate ngaySinh;

    @Column(name = "Email")
    @NotBlank(message = "Không được để trống email")
    @Email(message = "Email không hợp lệ")
    private String email;

    @Column(name = "SoDienThoai")
    @NotBlank(message = "Không được để trống số điện thoại")
    @Pattern(regexp = "^(0|\\+84)[0-9]{9}$", message = "Số điện thoại không hợp lệ")
    private String soDienThoai;

    @Column(name = "DiaChi")
    @NotBlank(message = "Không được để trống địa chỉ")
    private String diaChi;

    @Column(name = "TrangThai")
    private Boolean trangThai;

    @Column(name = "NgayTao", updatable = false)
    private LocalDate ngayTao;

}
