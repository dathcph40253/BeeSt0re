package com.example.demo.service;

import com.example.demo.Entity.Brand;
import com.example.demo.repository.BrandRepo;
import com.example.demo.repository.ProductRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BrandService {
    @Autowired
    private BrandRepo brandRepo;

    @Autowired
    private ProductRepo productRepo;

    public List<Brand> getAllBrand(){
        return brandRepo.findAll();
    }

    public boolean isBrandInUse(Long brandId) {
        return productRepo.existsByBrandId(brandId);
    }
}
