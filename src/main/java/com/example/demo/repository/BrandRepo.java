package com.example.demo.repository;

import com.example.demo.Entity.Brand;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface BrandRepo extends JpaRepository<Brand, Long> {
    List<Brand> findByDeleteFalse();

    Optional<Brand> findById(Long id); // Mặc định Spring Data cung cấp

    List<Brand> findByCode(String code);

    Long id(Long id);
}
