package com.coverchallenge.service;

import com.coverchallenge.domain.CoverChallenge;
import com.coverchallenge.repository.CoverChallengeRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor  // final 필드 생성자 주입 자동 생성 (Lombok)
public class CoverChallengeService {

    private final CoverChallengeRepository repository;  // ✅ 생성자 주입 — 테스트 용이

    @Transactional
    public CoverChallenge save(String title, String artist) {
        return repository.save(
            CoverChallenge.builder()
                .title(title)
                .artist(artist)
                .build()
        );
    }

    @Transactional(readOnly = true)  // 읽기 전용 트랜잭션 — DB 성능 최적화
    public List<CoverChallenge> findAll() {
        return repository.findAll();
    }
}