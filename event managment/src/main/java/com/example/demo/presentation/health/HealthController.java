package com.example.demo.presentation.health;

import com.example.demo.common.ApiMessage;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/health")
public class HealthController {

    @GetMapping
    public ApiMessage health() {
        return new ApiMessage("Event Management System starter is running.");
    }
}
