#!/bin/bash
# ==========================================
# [FinOps/데브옵스] 무중단 배포(Blue/Green) 모의 스크립트
# ==========================================

# 1. 현재 구동 중인 환경 파악
# (도커 프로세스를 긁어와 현재 8080(Blue)이 돌고 있는지 확인)
CURRENT_PORT=$(docker ps --filter "name=app" --format "{{.Ports}}")

if [[ $CURRENT_PORT == *"8080"* ]]; then
  TARGET_COLOR="green"
  TARGET_PORT=8081
else
  TARGET_COLOR="blue"
  TARGET_PORT=8080
fi

echo "=> 배포 타겟 환경: $TARGET_COLOR (포트: $TARGET_PORT)"

# 2. 신버전(Target) 이미지 내려받기 및 컨테이너 띄우기
echo "=> Docker Hub에서 최신 이미지를 Pull 받습니다..."
docker pull ${DOCKERHUB_USERNAME}/cover-challenge:latest

echo "=> 신버전 컨테이너를 구동합니다..."
# 실제로는 prod 파일을 명시하여 구동: docker-compose -f docker-compose.prod.yml up -d --no-build ${TARGET_COLOR}

# 3. [안전장치: 파이프라인 방지] Health Check (통합테스트가 아님!)
echo "=> Health Check 대기 중..."
sleep 10
# HTTP 200 OK가 떨어지는지 검증. 만약 여기서 에러가 나면(서버가 뻗었다면)
# exit 1 로 스크립트를 강제 종료하여 아래의 Nginx 스위칭을 막아야 대참사를 방지함.

# 4. Nginx 트래픽 스위칭 (0초 다운타임)
echo "=> Nginx 라우팅 포트를 $TARGET_PORT 로 변경하고 Reload 합니다."
# nginx.conf 수정 후: docker exec nginx nginx -s reload

# 5. [운영 영향 방어] Graceful Shutdown 및 구버전 종료
echo "=> 구버전 컨테이너에 SIGTERM 신호를 보내어 Graceful Shutdown을 유도합니다."
# docker stop 명령은 즉시 끄는 게 아니라, 결제 중이던 로직이 끝날 때까지 유예 시간을 줌
# docker stop ${CURRENT_COLOR}

echo "=> 무중단 배포 완료."
