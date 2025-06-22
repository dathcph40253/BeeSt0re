package com.example.demo.service;

import com.example.demo.Entity.Product;
import com.example.demo.repository.ProductRepo;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductService {
    private final ProductRepo productRepo;
    public ProductService(ProductRepo productRepo){
        this.productRepo = productRepo;
    }
    public Product handleSaveProduct(Product product){
        return this.productRepo.save(product);
    }
    public List<Product> getAll(){
        List<Product> products = productRepo.findByDeleteFlag(true);
        return products;
    }
    public Product getProductById(Long id){
        Product product = this.productRepo.findById(id).get();
        return product;
    }



}
