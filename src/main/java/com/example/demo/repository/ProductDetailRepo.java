package com.example.demo.repository;

import com.example.demo.Entity.ProductDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductDetailRepo extends JpaRepository<ProductDetail, Long> {

    List<ProductDetail> findByProductId(Long productId);
}
