# ==========================================
# Stage 1: Build Stage (소스를 컴파일하는 방)
# ==========================================
FROM gradle:8.7.0-jdk17 AS builder

# 작업할 컨테이너 내부 폴더 지정
WORKDIR /build

# 호스트(Windows)의 파일들을 컨테이너 내부로 복사
# [FinOps/데브옵스 최적화] 변경이 잦지 않은 설정 파일부터 복사하여 레이어 캐시(Cache) 확보
COPY gradlew settings.gradle build.gradle ./
COPY gradle ./gradle

# 실행 파일 권한 부여 및 의존성 라이브러리만 먼저 다운로드
# (src 코드가 바뀌어도 여기까지는 캐시가 살아있어 재다운로드 방지)
RUN chmod +x ./gradlew
RUN ./gradlew dependencies --no-daemon

# [중요] 변경이 가장 잦은 소스 코드(src)는 캐싱이 끝난 가장 마지막 단계에 복사
COPY src ./src

# 실제 빌드 진행 (이미 캐시된 의존성을 쓰기 때문에 코드가 바뀌어도 빌드가 순식간에 끝남)
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