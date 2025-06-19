package com.example.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ProductRepo extends JpaRepository<com.example.demo.Entity.Product, Long> {
    com.example.demo.Entity.Product save(com.example.demo.Entity.Product product);

}
