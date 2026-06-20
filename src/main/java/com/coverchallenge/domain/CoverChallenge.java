package com.coverchallenge.domain;

import jakarta.persistence.*;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;  // 추가

import java.time.LocalDateTime;

@Entity
@Getter
@NoArgsConstructor  // JPA는 기본 생성자 필수
@Table(name = "cover_challenges")
public class CoverChallenge {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)  // MySQL AUTO_INCREMENT 사용
    private Long id;

    @Column(nullable = false)
    private String title;   // 곡 제목

    @Column(nullable = false)
    private String artist;  // 아티스트명

    @CreationTimestamp
    @Column(updatable = false)  // 생성 후 수정 불가
    private LocalDateTime createdAt;

    @Builder  // 생성자 대신 빌더 패턴 사용 — 가독성 + 불변성
    public CoverChallenge(String title, String artist) {
        this.title = title;
        this.artist = artist;
    }
}