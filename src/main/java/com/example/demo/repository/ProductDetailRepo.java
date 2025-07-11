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

    boolean existsByColorId(Long colorId);
    boolean existsBySizeId(Long sizeId);
    boolean existsByProductId(Long productId);

    boolean existsByColor_IdAndQuantityGreaterThan(Long colorId, Integer quantity);

    boolean existsBySize_IdAndQuantityGreaterThan(Long sizeId, Integer quantity);

    boolean existsByProduct_IdAndQuantityGreaterThan(Long productId, Integer quantity);
}
