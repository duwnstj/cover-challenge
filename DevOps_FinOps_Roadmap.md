# 🚀 CoverChallenge 데브옵스/FinOps 마스터 플랜 및 컨텍스트 인수인계

> **[Agent Context Handoff (인수인계 완료 상태)]**
> 이 문서(Roadmap.md)는 프로젝트의 **기술적 진행 상황(State)과 아키텍처 맥락**만을 담고 있습니다. AI 튜터의 행동 강령(소크라테스식 압박 면접, 정답 스포일러 금지 등)은 시스템에 등록된 글로벌 룰을 최우선으로 따르십시오.
> 
> - **완료된 아키텍처 상태:** 로컬 환경 `docker-compose.yml` 및 `Dockerfile` 최적화(레이어 캐싱, 볼륨, 보안망 격리), AWS 스왑 메모리 방어 논리, Nginx 기반 무중단 배포(Blue/Green) 로직 및 스크립트(`deploy.sh`) 설계 완료.
> - **다음 액션 플랜:** 시뮬레이션으로 구축된 파이프라인 코드들을 **실제 AWS EC2와 GitHub Actions 환경에 연동하고 배포 테스트**를 진행하는 것.


---

## 🗺️ 근본부터 다지는 데브옵스 마스터 로드맵 (진행도)

### [✅ 완료] Phase 1: 운영체제(Linux)와 네트워크의 본질
- `internal` 브릿지 네트워크와 Embedded DNS (127.0.0.11) 원리 체화.
- Nginx 리버스 프록시 패킷 흐름 및 DB(3306) 외부 노출 차단(Ransomware 방어) 원리 이해.

### [✅ 완료] Phase 2: 컨테이너 격리 기술의 딥다이브 (Docker)
- `Dockerfile` 레이어(Layer) 캐싱 최적화로 빌드 속도 단축 로직 완벽 해부.
- 도커 볼륨(Volume)을 통한 데이터 영속성(Persistence) 개념 확보.

### [✅ 완료] Phase 3: 클라우드 인프라와 FinOps 최적화 (AWS)
- 프리티어(RAM 1GB)에서 발생하는 OOM 및 쓰래싱(Thrashing) 병목 현상 인지.
- 인프라 과금을 방어하기 위한 스왑(Swap) 메모리 구축 타당성(FinOps 방어 논리) 확립.

### [✅ 완료] Phase 4: 무중단 배포 및 자동화 (CI/CD) 설계
- 단순 롤링 배포와 Blue/Green 배포의 차이점 완벽 인지.
- 무중단 배포의 핵심인 **Health Check**와 **Graceful Shutdown** 로직이 담긴 `deploy.sh` 모의 설계 완료.

### [✅ 완료] Phase 5: 실전! AWS 실서버 파이프라인 구축 (Next Step)
- **목표:** 시뮬레이션으로 짜둔 로직을 실제 AWS 자원(EC2)과 GitHub Actions에 연결하여 눈으로 다운타임 0초를 확인한다.
- **실습 완료 내역:**
  1. GitHub Actions 워크플로우(`.yml`) 실제 작성 완료 (Git Tag 기반 배포 트리거 및 경로 격리 적용).
  2. GitHub Secrets를 통한 EC2 `.pem` 키 은닉 및 FinOps 기반 과금/해킹 리스크 원천 차단 방어 논리 확립.
  3. 모든 연동이 완료된 후 "진짜 팩트 기반"의 무중단 배포 기술 블로그 최종 렌더링 완료.

---

### [✅ 완료] Phase 6: 파이프라인 고도화 (Slack & ECR 아키텍처)
- **목표:** 단일 장애점(SPOF)을 회피하고 배포 과정의 가시성과 재무적 효율(FinOps)을 극대화한다.
- **실습 완료 내역:**
  1. GitHub Actions 워크플로우에 Slack Webhook 알림(성공/실패 자동 색상 분기) 연동 완료.
  2. 무거운 Docker Build 작업을 EC2 내부가 아닌 외부(CI 환경)로 분리하여 EC2 Scale-Up 과금을 방어하는 FinOps 아키텍처 논의 완료.

---

### 📚 [블로그 인덱싱 데이터] (새 세션 AI 참고용)
> 새 채팅창이 열리면 AI 튜터는 아래 목록을 읽고, 내용이 방대하거나 겹치는 경우 사용자에게 블로그 글의 병합 또는 분할을 능동적으로 제안할 것.
> **[중요 컨텍스트 유지]** 아래 명시된 각 블로그 파일 하단에는 과거에 설계했던 파이프라인의 핵심 코드(`deploy.yml` 등)가 스니펫으로 영구 박제되어 있습니다. 새 세션의 AI는 반드시 이 코드를 파싱하여 100% 팩트 기반으로 과거의 기술적 컨텍스트를 완벽히 복원한 뒤 튜팅을 진행할 것.
1. `2026-06-26-Zero-Downtime-CICD-Phase5-Basic.md`: Phase 5 기초 내용 (Git Tag 배포 트리거 설계, Secrets 보안 연동).
2. `2026-06-26-Zero-Downtime-CICD-FinOps.md`: Phase 6 고도화 내용 (Slack 알림 연동, Docker Build 외부화).

