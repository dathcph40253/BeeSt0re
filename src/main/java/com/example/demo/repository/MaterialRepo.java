package com.example.demo.repository;

import com.example.demo.Entity.Material;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MaterialRepo extends JpaRepository<Material,Long> {

    List<Material> findByDeleteFalse();

    List<Material> findByCode(String code);
}
