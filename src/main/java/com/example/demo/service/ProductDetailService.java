package com.example.demo.service;

import com.example.demo.Entity.ProductDetail;
import com.example.demo.repository.ProductDetailRepo;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class ProductDetailService {
    private final ProductDetailRepo productDetailRepo;
    public ProductDetailService(ProductDetailRepo productDetailRepo){
        this.productDetailRepo = productDetailRepo;
    }
    public List<ProductDetail> getAll(){
        List<ProductDetail> productDetails = productDetailRepo.findAll();
        return productDetails;
    }

    public void handleSaveProductDetail(ProductDetail productDetail){
        this.productDetailRepo.save(productDetail);
    }

    public ProductDetail getOneProductDetail(long id){
        ProductDetail productDetail = productDetailRepo.findById(id).get();
        return productDetail;
    }

    public List<ProductDetail> getProductByProductId(Long id){
        List<ProductDetail> productDetails = productDetailRepo.findByProductId(id);
        return productDetails;
    }

    public void deleteProductDetail(long id){
        this.productDetailRepo.deleteById(id);
    }
}
