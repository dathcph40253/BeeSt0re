package com.example.demo.service;

import com.example.demo.Entity.SanPham;
import com.example.demo.repository.SanPhamRepo;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SanPhamService {
    private final SanPhamRepo sanPhamRepo;
    public SanPhamService (SanPhamRepo sanPhamRepo){
        this.sanPhamRepo = sanPhamRepo;
    }
    public SanPham handleSaveProduct(SanPham sanPham){
        return this.sanPhamRepo.save(sanPham);
    }
    public List<SanPham> getAll(){
        List<SanPham> products = sanPhamRepo.findAll();
        return products;
    }
    public SanPham getProductById(Long id){
        SanPham product = sanPhamRepo.findById(id).get();
        return product;
    }

}
