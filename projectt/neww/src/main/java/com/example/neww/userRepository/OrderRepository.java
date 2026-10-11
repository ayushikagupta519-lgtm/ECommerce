package com.example.neww.userRepository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.neww.user.ProductOrder;

public interface OrderRepository extends JpaRepository<ProductOrder,Integer>{

}
