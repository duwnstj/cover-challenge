package com.coverchallenge.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController             // @Controller + @ResponseBody: JSON 응답을 자동으로 처리
@RequestMapping("/api")     // 이 컨트롤러의 모든 엔드포인트는 /api 로 시작
public class HealthCheckController {

    /**
     * 서버 상태 확인용 엔드포인트
     * GET /api/health → {"status": "UP"}
     *
     * 나중에 Docker, ECS, ALB 등에서 이 엔드포인트로 컨테이너 상태를 주기적으로 체크함
     * → 응답 없으면 컨테이너 재시작 or 트래픽 차단
     */
    @GetMapping("/health")
    public ResponseEntity<Map<String, String>> health() {
        return ResponseEntity.ok(Map.of("status", "UP"));
        // Map.of() : Java 9+에서 사용 가능한 불변 Map 생성
        // ResponseEntity.ok() : HTTP 200 + body 반환
    }
}
