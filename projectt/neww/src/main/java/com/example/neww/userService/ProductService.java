package com.example.neww.userService;

import java.io.IOException;
import java.util.List;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.example.neww.user.Product;
import com.example.neww.userRepository.ProductRepository;

@Service
public class ProductService {

    private final ProductRepository productRepository;

    public ProductService(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }

    // NEW: OVERLOADED SAVE METHOD TO ACCEPT COMPLETED OBJECTS (Crucial for editing/updating entries)
    public Product saveProduct(Product product) {
        return productRepository.save(product);
    }

    // YOUR EXISTING CREATION METHOD (Kept completely intact for backward compatibility)
    public Product saveProduct(int id, String name, int price,String category, MultipartFile image) throws IOException {
        Product product = new Product();
        product.setId(id);
        product.setName(name);
        product.setPrice(price);
        product.setCategory(category);
        if (image != null && !image.isEmpty()) {
            product.setImage(image.getBytes());
        }
        
        return productRepository.save(product);
    }

    // NEW: FETCHES ALL REGISTERED INVENTORY ITEMS FROM DATABASE ROWS
    public List<Product> getAllProduct() {
        return productRepository.findAll();
    }

    public Product getProduct(int id) {
        return productRepository.findById(id).orElse(null);
    }

    public void deleteProduct(int id) {
        productRepository.deleteById(id);
    }
}
