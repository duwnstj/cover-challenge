# ==========================================
# Stage 1: Build Stage (소스를 컴파일하는 방)
# ==========================================
FROM gradle:8.7.0-jdk17 AS builder

# 작업할 컨테이너 내부 폴더 지정
WORKDIR /build

# 호스트(Windows)의 파일들을 컨테이너 내부로 복사
COPY gradlew settings.gradle build.gradle ./
COPY gradle ./gradle
COPY src ./src

# 실행 파일 권한 부여 및 실제 빌드 진행 (테스트는 무시해서 속도 향상)
RUN chmod +x ./gradlew
RUN ./gradlew bootJar --no-daemon

# ==========================================
# Stage 2: Run Stage (알맹이만 가볍게 실행하는 방)
# ==========================================
FROM eclipse-temurin:17-jre-alpine

# 보안을 위해 컨테이너 내부 작업 디렉토리 분리
WORKDIR /app

# Stage 1(builder)의 결과물인 가벼운 .jar 파일만 쏙 빼서 복사 (★FinOps 포인트)
COPY --from=builder /build/build/libs/*.jar app.jar

# 외부와 소통할 포트 명시
EXPOSE 8080

# 컨테이너가 켜질 때 Spring Boot 서버를 실행하는 명령어
ENTRYPOINT ["java", "-jar", "app.jar"]