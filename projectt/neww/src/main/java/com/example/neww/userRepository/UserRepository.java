package com.example.neww.userRepository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.neww.user.User;

public interface UserRepository extends JpaRepository<User,Integer>{

}
