package com.foreverstack.javaapi.controller;

import org.springframework.web.bind.annotation.*;
import org.springframework.http.ResponseEntity;
import java.util.Map;
import java.util.HashMap;

@RestController
@RequestMapping("/")
public class ApiController {

    @GetMapping("/")
    public ResponseEntity<Map<String, Object>> home() {
        Map<String, Object> response = new HashMap<>();
        response.put("message", "Java API is running!");
        response.put("status", "ok");
        return ResponseEntity.ok(response);
    }

    @GetMapping("/health")
    public ResponseEntity<Map<String, Object>> health() {
        Map<String, Object> response = new HashMap<>();
        response.put("status", "healthy");
        response.put("service", "java");
        return ResponseEntity.ok(response);
    }

    @GetMapping("/users")
    public ResponseEntity<Map<String, Object>> getUsers() {
        Map<String, Object> response = new HashMap<>();
        response.put("message", "Users endpoint - implement database connection");
        return ResponseEntity.ok(response);
    }

    @PostMapping("/users")
    public ResponseEntity<Map<String, Object>> createUser(@RequestBody Map<String, String> user) {
        Map<String, Object> response = new HashMap<>();
        response.put("message", "User created successfully");
        response.put("name", user.get("name"));
        response.put("email", user.get("email"));
        return ResponseEntity.ok(response);
    }
}
