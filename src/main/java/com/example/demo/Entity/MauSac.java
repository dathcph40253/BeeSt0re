package com.example.demo.Entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import lombok.*;

import java.util.UUID;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Entity
@Table(name = "MauSac")
public class MauSac {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "MauSacID", columnDefinition = "uniqueidentifier")
    private UUID id;

    @Column(name = "MaMauSac", nullable = false, unique = true)
    @NotBlank(message = "Không được để trống mã màu sắc")
    private String maMauSac;

    @Column(name = "TenMauSac", nullable = false)
    @NotBlank(message = "Không được để trống tên màu sắc")
    private String tenMauSac;

    @Column(name = "TrangThai")
    private Boolean trangThai = true;
}
