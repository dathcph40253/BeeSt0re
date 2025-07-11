package com.example.demo.service;

import com.example.demo.Entity.Color;
import com.example.demo.repository.ColorRepo;
import com.example.demo.repository.ProductDetailRepo;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ColorService {
    private final ColorRepo colorRepo;
    private final ProductDetailRepo productDetailRepo;

    public ColorService(ColorRepo colorRepo, ProductDetailRepo productDetailRepo){
        this.colorRepo = colorRepo;
        this.productDetailRepo = productDetailRepo;
    }

    public List<Color> getAll(){
        List<Color> colors = colorRepo.findAll();
        return colors;
    }

    public boolean isColorInUse(Long colorId) {
        return productDetailRepo.existsByColorId(colorId);
    }
}
