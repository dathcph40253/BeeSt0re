package com.example.demo.service;

import com.example.demo.Entity.Color;
import com.example.demo.repository.ColorRepo;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ColorService {
    private final ColorRepo colorRepo;
    public ColorService(ColorRepo colorRepo){
        this.colorRepo = colorRepo;
    }

    public List<Color> getAll(){
        List<Color> colors = colorRepo.findAll();
        return colors;
    }
}
