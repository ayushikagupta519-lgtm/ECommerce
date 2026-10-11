package com.example.neww.userController;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.example.neww.user.Product;
import com.example.neww.userService.ProductService;

@RestController
@CrossOrigin(origins = "http://localhost:8080") // Overrides browser security policies to stop button blocking
public class ProductController {

    private final ProductService productService;

    public ProductController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping("/product")
    public List<Map<String, Object>> getAllProduct() {
        List<Product> products = productService.getAllProduct();
        List<Map<String, Object>> responseList = new ArrayList<>();
        
        for (Product p : products) {
            Map<String, Object> map = new HashMap<>();
            map.put("id", p.getId());
            map.put("name", p.getName());
            map.put("price", p.getPrice());
            map.put("category", p.getCategory());
            // If the image byte array exists inside this database row, transform it to a Base64 String URI
            if (p.getImage() != null && p.getImage().length > 0) {
                String base64Image = Base64.getEncoder().encodeToString(p.getImage());
                // Creates a valid Data URI string that any <img> tag can read natively
                map.put("base64Image", "data:image/jpeg;base64," + base64Image);
            } else {
                map.put("base64Image", ""); // Empty fallback placeholder string
            }
            responseList.add(map);
        }
        return responseList;
    }

    // FIXED: Added @RequestParam("category") to capture the dropdown value from admin.jsp
    @PostMapping("/products")
    public ResponseEntity<String> saveProduct(
            @RequestParam("id") int id,
            @RequestParam("name") String name,
            @RequestParam("price") int price,
            @RequestParam("category") String category, // <-- ADD THIS LINE
            @RequestParam(value = "imageFile", required = false) MultipartFile file) { 
        try {
            Product product = new Product();
            product.setId(id);
            product.setName(name);
            product.setPrice(price);
            product.setCategory(category); // <-- ADD THIS LINE to save it to the DB
            
            if (file != null && !file.isEmpty()) {
                product.setImage(file.getBytes());
            }
            
            productService.saveProduct(product);
            return ResponseEntity.ok("Product added successfully!");
        } catch (IOException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error processing file upload: " + e.getMessage());
        }
    }

    @PostMapping("/products/{id}")
    public ResponseEntity<String> updateProduct(
            @PathVariable("id") int id,
            @RequestParam("name") String name,
            @RequestParam("price") int price,
            @RequestParam("category") String category, // <-- ADD THIS LINE
            @RequestParam(value = "imageFile", required = false) MultipartFile file) {
        
        List<Product> products = productService.getAllProduct();
        for (Product existingProduct : products) {
            if (existingProduct.getId() == id) {
                existingProduct.setName(name);
                existingProduct.setPrice(price);
                existingProduct.setCategory(category); // <-- ADD THIS LINE
                
                if (file != null && !file.isEmpty()) {
                    try {
                        existingProduct.setImage(file.getBytes());
                    } catch (IOException e) {
                        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error processing file update.");
                    }
                }
                
                productService.saveProduct(existingProduct);
                return ResponseEntity.ok("Product updated successfully!");
            }
        }
        return ResponseEntity.notFound().build();
    }


    // 4. FIXED: MATCHES DELETION ROUTE PATH /products/delete/{id} USING POST METHOD
    @PostMapping("/products/delete/{id}")
    public ResponseEntity<String> deleteProduct(@PathVariable int id) {
        productService.deleteProduct(id);
        return ResponseEntity.ok("Product deleted successfully.");
    }
}
