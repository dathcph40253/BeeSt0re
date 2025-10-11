package com.example.demo.service;

import com.example.demo.Entity.Product;
import com.example.demo.repository.ProductDetailRepo;
import com.example.demo.repository.ProductRepo;
import org.springframework.stereotype.Service;
import com.example.demo.dto.ProductDetailDto;
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

    public List<Product> getRelatedProducts(Long productId) {
        Product product = getProductById(productId);
        if (product == null || product.getCategory() == null) return List.of();

        // Lấy 4 sản phẩm cùng category, khác sản phẩm hiện tại
        return productRepo.findTop5ByCategoryAndIdNot(product.getCategory(), product.getId());
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

    public List<ProductDetailDto> getAllProductForUser(){
        return productDetailRepo.findAll().stream()
        .map(detail -> new ProductDetailDto(
                detail.getId(),
                detail.getProduct().getName(),
                detail.getPrice(),
                detail.getDiscountedPrice()
        )).toList();
    }

}
