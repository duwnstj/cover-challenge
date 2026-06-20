package com.coverchallenge.controller;

import com.coverchallenge.domain.CoverChallenge;
import com.coverchallenge.service.CoverChallengeService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/covers")
@RequiredArgsConstructor
public class CoverChallengeController {

    private final CoverChallengeService service;

    // POST /api/covers
    // Body: {"title": "Dynamite", "artist": "BTS"}
    @PostMapping
    public ResponseEntity<CoverChallenge> create(@RequestBody CoverRequest request) {
        return ResponseEntity.ok(service.save(request.title(), request.artist()));
    }

    // GET /api/covers
    @GetMapping
    public ResponseEntity<List<CoverChallenge>> findAll() {
        return ResponseEntity.ok(service.findAll());
    }

    // Record — DTO 역할, 불변 객체 (Java 16+)
    record CoverRequest(String title, String artist) {}
}