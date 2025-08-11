package com.foreverstack.javaapi.controller;

import org.springframework.web.bind.annotation.*;
import org.springframework.http.ResponseEntity;
import java.util.Map;
import java.util.HashMap;
import java.time.Instant;

@RestController
@RequestMapping("/")
public class ApiController {

    @GetMapping("/")
    public ResponseEntity<Map<String, Object>> home() {
        Map<String, Object> response = new HashMap<>();
        response.put("message", "Java API is running!");
        response.put("status", "ok");
        response.put("timestamp", Instant.now().getEpochSecond());
        response.put("service", "java-basic");
        return ResponseEntity.ok(response);
    }

    @GetMapping("/health")
    public ResponseEntity<Map<String, Object>> health() {
        Map<String, Object> response = new HashMap<>();
        response.put("status", "healthy");
        response.put("service", "java");
        response.put("uptime", Instant.now().getEpochSecond());
        return ResponseEntity.ok(response);
    }

    @GetMapping("/info")
    public ResponseEntity<Map<String, Object>> info() {
        Map<String, Object> response = new HashMap<>();
        response.put("service", "Java Basic API");
        response.put("version", "1.0.0");
        response.put("description", "A simple Java web application without database");
        response.put("endpoints", new String[]{"/", "/health", "/info", "/echo", "/math/add", "/math/multiply", "/data"});
        response.put("modules", "Spring Boot Web only");
        return ResponseEntity.ok(response);
    }

    @GetMapping("/echo")
    public ResponseEntity<Map<String, Object>> echo(@RequestParam(value = "message", defaultValue = "Hello World!") String message) {
        Map<String, Object> response = new HashMap<>();
        response.put("echo", message);
        response.put("timestamp", Instant.now().getEpochSecond());
        return ResponseEntity.ok(response);
    }

    @GetMapping("/math/add")
    public ResponseEntity<Map<String, Object>> add(
            @RequestParam(value = "a", defaultValue = "0") int a,
            @RequestParam(value = "b", defaultValue = "0") int b) {
        Map<String, Object> response = new HashMap<>();
        response.put("operation", "addition");
        response.put("a", a);
        response.put("b", b);
        response.put("result", a + b);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/math/multiply")
    public ResponseEntity<Map<String, Object>> multiply(
            @RequestParam(value = "a", defaultValue = "1") int a,
            @RequestParam(value = "b", defaultValue = "1") int b) {
        Map<String, Object> response = new HashMap<>();
        response.put("operation", "multiplication");
        response.put("a", a);
        response.put("b", b);
        response.put("result", a * b);
        return ResponseEntity.ok(response);
    }

    @PostMapping("/data")
    public ResponseEntity<Map<String, Object>> data(@RequestBody Map<String, Object> data) {
        Map<String, Object> response = new HashMap<>();
        response.put("received", data);
        response.put("processed", Instant.now().getEpochSecond());
        response.put("message", "Data received successfully");
        return ResponseEntity.ok(response);
    }
}
