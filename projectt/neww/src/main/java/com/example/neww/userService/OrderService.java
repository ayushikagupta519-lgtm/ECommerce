package com.example.neww.userService;

import java.util.List;
import java.util.Optional;
import org.springframework.stereotype.Service;
import com.example.neww.user.ProductOrder;
import com.example.neww.userRepository.OrderRepository;

@Service
public class OrderService {

    private final OrderRepository orderRepository;

    public OrderService(OrderRepository orderRepository) {
        this.orderRepository = orderRepository;
    }

    public ProductOrder saveOrder(ProductOrder order) {
        return orderRepository.save(order);
    }

    public List<ProductOrder> getAllOrders() {
        return orderRepository.findAll();
    }

    public Optional<ProductOrder> getOrderById(int id) {
        return orderRepository.findById(id);
    }
}