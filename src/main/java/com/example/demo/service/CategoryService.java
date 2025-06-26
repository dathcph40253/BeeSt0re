package com.example.demo.service;

import com.example.demo.Entity.Category;
import com.example.demo.repository.CategoryRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CategoryService {
    @Autowired
    private CategoryRepo categoryRepo;
    public List<Category> getAllCategory(){
        return categoryRepo.findAll();
    }
}
