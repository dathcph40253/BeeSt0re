package com.example.demo.service;

import com.example.demo.Entity.Size;
import com.example.demo.repository.ProductDetailRepo;
import com.example.demo.repository.SizeRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SizeService {
    private final SizeRepo sizeRepo;

    @Autowired
    public ProductDetailRepo detailRepo;

    public SizeService(SizeRepo sizeRepo){
        this.sizeRepo = sizeRepo;
    }
    public List<Size> getAll(){
        List<Size> sizes = sizeRepo.findAll();
        return sizes;
    }

    public void deleteSize(Long id){
        if(detailRepo.existsBySizeIdAndQuantityGreaterThan(id, 0)){
            throw new IllegalStateException("không xóa được do sản phẩm còn hàng");
        }
        sizeRepo.deleteById(id);
    }
}
