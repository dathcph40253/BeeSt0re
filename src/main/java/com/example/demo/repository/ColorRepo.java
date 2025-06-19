package com.example.demo.repository;

import com.example.demo.Entity.Color;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Service;

@Service
public interface ColorRepo extends JpaRepository<Color, Long> {

}
