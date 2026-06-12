package com.coverchallenge;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication  // @Configuration + @EnableAutoConfiguration + @ComponentScan 세 개를 합친 어노테이션
public class CoverChallengeApplication {

    public static void main(String[] args) {
        SpringApplication.run(CoverChallengeApplication.class, args);
        // 내장 Tomcat이 여기서 시작됨 (기본 포트: 8080)
    }
}
