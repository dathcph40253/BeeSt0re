package com.example.demo.repository;

import com.example.demo.Entity.Color;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ColorRepo extends JpaRepository<Color, Long> {
    List<Color> findByDeleteFalse();

    List<Color> findByCode(String code);
}
