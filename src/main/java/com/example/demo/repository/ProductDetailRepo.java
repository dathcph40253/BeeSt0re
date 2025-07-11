package com.example.demo.repository;

import com.example.demo.Entity.ProductDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductDetailRepo extends JpaRepository<ProductDetail, Long> {
    @Query("SELECT pd FROM ProductDetail pd WHERE pd.product.id = :productId")
    List<ProductDetail> findByProductId(@Param("productId") Long productId);

    Boolean existsByColorIdAndQuantityGreaterThan(Long colorId, Integer quantity);

    Boolean existsBySizeIdAndQuantityGreaterThan(Long sizeId, Integer quantity);

}
