package com.example.demo.repository;

import com.example.demo.Entity.Category;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CategoryRepo extends JpaRepository<Category, Long> {
    List<Category> findByDeleteFalse();

    List<Category> findByName(String name);

    List<Category> findByCode(String code);
}
