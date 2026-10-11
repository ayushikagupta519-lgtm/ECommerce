package com.example.neww.userRepository;
import org.springframework.data.jpa.repository.JpaRepository;
import com.example.neww.user.*;
public interface ProductRepository extends JpaRepository<Product,Integer> {

}
