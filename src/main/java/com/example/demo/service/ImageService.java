package com.example.demo.service;

import com.example.demo.Entity.Image;
import com.example.demo.repository.ImageRepo;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ImageService {
    private final ImageRepo imageRepo;
    public ImageService(ImageRepo imageRepo){
        this.imageRepo = imageRepo;
    }
    public void handleSaveImage(Image image){
        this.imageRepo.save(image);
    }
}
