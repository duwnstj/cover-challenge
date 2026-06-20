package com.coverchallenge.repository;

import com.coverchallenge.domain.CoverChallenge;
import org.springframework.data.jpa.repository.JpaRepository;

// JpaRepository가 기본 CRUD 메서드 전부 제공 — 코드 작성 불필요
public interface CoverChallengeRepository extends JpaRepository<CoverChallenge, Long> {
}