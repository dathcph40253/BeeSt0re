package com.example.demo.service;

import com.example.demo.Entity.Size;
import com.example.demo.repository.SizeRepo;
import com.example.demo.repository.ProductDetailRepo;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SizeService {
    private final SizeRepo sizeRepo;
    private final ProductDetailRepo productDetailRepo;

    public SizeService(SizeRepo sizeRepo, ProductDetailRepo productDetailRepo){
        this.sizeRepo = sizeRepo;
        this.productDetailRepo = productDetailRepo;
    }

    public List<Size> getAll(){
        List<Size> sizes = sizeRepo.findAll();
        return sizes;
    }

    public boolean isSizeInUse(Long sizeId) {
        return productDetailRepo.existsBySizeId(sizeId);
    }
}
