package com.example.demo.repository;

import com.example.demo.Entity.Size;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SizeRepo extends JpaRepository<Size,Long> {
    List<Size> findByDeleteFalse();

    List<Size> findByCode(String code);
}
