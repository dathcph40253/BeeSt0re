package com.example.demo.service;

import com.example.demo.Entity.Material;
import com.example.demo.repository.MaterialRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MaterialService {
    @Autowired
    private MaterialRepo materialRepo;
    public List<Material> getAllMaterial(){
        return materialRepo.findAll();
    }
}
