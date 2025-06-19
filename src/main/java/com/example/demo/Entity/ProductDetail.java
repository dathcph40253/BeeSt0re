package com.example.demo.Entity;

import com.example.demo.Custom.IntegerOnly;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.PositiveOrZero;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.io.File;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "product_detail")
public class ProductDetail {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column
    private Long id;
    @Column
    private String barcode;
    @Column
    @NotBlank(message = "giá không được bỏ trống")
    @PositiveOrZero(message = "giá phải lớn hơn hoặc bằng 0")
    private Double price;
    @Column
    @NotBlank(message = "số lượng không được bỏ trống")
    @PositiveOrZero(message = "số lượng phải lớn hơn hoặc bằng 0")
    @IntegerOnly
    private Integer quantity;
    @ManyToOne
    @JoinColumn(name = "color_id")
    private Color color;
    @ManyToOne
    @JoinColumn(name = "size_id")
    private Size size;
    @ManyToOne
    @JoinColumn(name = "product_id")
    private Product product;

}
