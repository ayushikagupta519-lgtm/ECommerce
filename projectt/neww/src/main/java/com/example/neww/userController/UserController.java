package com.example.neww.userController;

import java.util.List;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.neww.user.User;
import com.example.neww.userService.UserService;

@RestController
@CrossOrigin(origins = "http://localhost:8080") 
public class UserController {
    
    private final UserService userService;
    
    public UserController(UserService userService) {
        this.userService = userService;
    }
    
    @PostMapping("/user")
    public User saveUser(@ModelAttribute User user) {
        if (user.getRole() == null || user.getRole().isEmpty()) {
            user.setRole("USER");
        }
        return userService.saveUser(user);
    }
    
    @GetMapping("/users")
    public List<User> getAllUser(){
        return userService.getAllUser();
    }

    @PostMapping("/login")
    public ResponseEntity<String> loginUser(@RequestParam("id") int id, @RequestParam("password") String password) {
        List<User> users = userService.getAllUser();
        for (User user : users) {
            if (user.getId() == id) {
                if (user.getpassword().equals(password)) {
                    if ("ADMIN".equalsIgnoreCase(user.getRole())) {
                        return ResponseEntity.ok("ADMIN_PANEL:" + user.getFirstName());
                    } else {
                        return ResponseEntity.ok("USER_DASHBOARD:" + user.getFirstName());
                    }
                }
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Login Failed: Incorrect password.");
            }
        }
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Login Failed: User ID not found.");
    }

}