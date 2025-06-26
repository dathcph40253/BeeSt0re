package com.example.demo.service;

import com.example.demo.Entity.Size;
import com.example.demo.repository.SizeRepo;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SizeService {
    private final SizeRepo sizeRepo;
    public SizeService(SizeRepo sizeRepo){
        this.sizeRepo = sizeRepo;
    }
    public List<Size> getAll(){
        List<Size> sizes = sizeRepo.findAll();
        return sizes;
    }
}
