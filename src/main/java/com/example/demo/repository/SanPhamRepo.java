package com.example.demo.repository;

import com.example.demo.Entity.SanPham;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SanPhamRepo extends JpaRepository<SanPham, Long> {
    SanPham save(SanPham sanPham);

}
