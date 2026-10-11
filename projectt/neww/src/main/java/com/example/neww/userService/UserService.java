package com.example.neww.userService;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.neww.user.User;
import com.example.neww.userRepository.UserRepository;

@Service
public class UserService {
private UserRepository userRepository;
public UserService(UserRepository userRepository) {
	this.userRepository=userRepository;
}
public User saveUser(User user) {
	return userRepository.save(user);
}
public List<User> getAllUser(){
	return userRepository.findAll();
}
}
