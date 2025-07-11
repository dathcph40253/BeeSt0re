package com.example.demo.service;

import com.example.demo.Entity.Color;
import com.example.demo.repository.ColorRepo;
import com.example.demo.repository.ProductDetailRepo;
import com.example.demo.repository.ProductRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ColorService {
    private final ColorRepo colorRepo;

    @Autowired
    public ProductDetailRepo detailRepo;
    public ColorService(ColorRepo colorRepo){
        this.colorRepo = colorRepo;
    }

    public List<Color> getAll(){
        List<Color> colors = colorRepo.findAll();
        return colors;
    }

    public void deleteColor(Long id){
        if(detailRepo.existsByColorIdAndQuantityGreaterThan(id, 0)){
            throw new IllegalStateException("không xóa được do sản phẩm còn hàng");
        }
        colorRepo.deleteById(id);
    }
}
