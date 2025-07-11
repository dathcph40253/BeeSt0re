package com.example.demo.service;

import com.example.demo.Entity.Product;
import com.example.demo.repository.ProductDetailRepo;
import com.example.demo.repository.ProductRepo;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductService {
    private final ProductRepo productRepo;
    private final ProductDetailRepo productDetailRepo;

    public ProductService(ProductRepo productRepo, ProductDetailRepo productDetailRepo){
        this.productRepo = productRepo;
        this.productDetailRepo = productDetailRepo;
    }
    public Product handleSaveProduct(Product product){
        return this.productRepo.save(product);
    }
    public List<Product> getAll(){
        List<Product> products = productRepo.findByDeleteFlag(false);
        return products;
    }
    public Product getProductById(Long id){
        Product product = this.productRepo.findById(id).get();
        return product;
    }

    public Product getProductByName(String name){
        return this.productRepo.findByName(name);
    }

    public void updateProductStatus(Long productId){
        boolean status = productDetailRepo.existsByProduct_IdAndQuantityGreaterThan(productId, 0);

        Product product = productRepo.findById(productId).orElse(null);
        if(product != null){
            if(status){
                product.setStatus(1);
            }else{
                product.setStatus(0);
            }
            productRepo.save(product);
        }
    }

}
