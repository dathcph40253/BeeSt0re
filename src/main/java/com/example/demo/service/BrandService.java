package com.example.demo.service;

import com.example.demo.Entity.Brand;
import com.example.demo.repository.BrandRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BrandService {
    @Autowired
    private BrandRepo brandRepo;
    public List<Brand> getAllBrand(){
        return brandRepo.findAll();
    }
}
