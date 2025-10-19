# KakaoSearch

카카오 검색(Open API)을 기반으로 블로그, 이미지, 동영상 콘텐츠를 통합 검색하는 iOS 앱 프로젝트입니다.  
모듈별로 역할을 분리하고, Clean Architecture 및 TCA(The Composable Architecture)를 적용하여  
유지보수성과 확장성을 고려한 구조로 설계되었습니다.

---

## 🧩 프로젝트 구조

KakaoSearch/
├── Projects/
│   ├── App/                 # App 진입 지점 (DI 조립, 라우팅)
│   ├── Presentation/        # UI / Feature (SwiftUI + TCA)
│   ├── Domain/              # 비즈니스 로직 (UseCase / Entity)
│   ├── Data/                # Repository / DataSource (Network, Persistence)
│   └── Core/                # 공통 유틸 / Network / Persistence / Logger 등
└── Tuist/                   # 프로젝트 생성 템플릿

---

## 🛠️ 기술 스택

| Layer | Stack / Framework | Description |
|-------|-------------------|--------------|
| **Architecture** | Clean Architecture + Modular | Domain / Data / Presentation / Core 분리 |
| **DI (의존성 주입)** | [Swinject](https://github.com/Swinject/Swinject) | 의존성 주입 컨테이너 |
| **UI Framework** | SwiftUI | 선언형 UI 기반 |
| **State Management** | [The Composable Architecture (TCA)](https://github.com/pointfreeco/swift-composable-architecture) | 상태/이벤트 기반 아키텍처 |
| **Async / Concurrency** | Swift Concurrency (async/await) | 비동기 네트워킹 |
| **Networking** | Alamofire | HTTP Client, Kakao API 연동 |
| **Project Generation** | [Tuist](https://tuist.io) | 프로젝트 자동 생성 및 의존성 관리 |
| **Test** | XCTest | 단위 테스트 및 모듈 테스트 구성 |

---

## ⚙️ 프로젝트 실행 방법

이 프로젝트는 **Tuist** 를 사용하여 Xcode 프로젝트를 생성합니다.  
아래 순서대로 실행하면 바로 빌드가 가능합니다.

### 1. Tuist 설치
```bash
brew install tuist

2. Tuist 환경 업데이트

tuist install

3. 프로젝트 생성

tuist generate

성공 시 KakaoSearch.xcworkspace 가 생성됩니다.

4. Xcode 실행

open KakaoSearch.xcworkspace

5. 실행 타겟 선택 및 빌드
    •    타겟: App
    •    시뮬레이터: iPhone 15 Pro (또는 지원 기기)
    •    ⌘ + R 로 실행

⸻


🧪 테스트 실행

tuist test

또는 Xcode 내에서

⌘ + U

를 눌러 테스트 전체 실행이 가능합니다.

⸻

📦 의존성 요약
    •    Tuist — 모듈 기반 프로젝트 생성 및 관리
    •    Swinject — 의존성 주입(DI) 컨테이너
    •    TCA — 피처 단위 상태/이벤트 관리
    •    Alamofire — HTTP 네트워킹
    •    XCTest — 단위 테스트

⸻

📁 모듈 개요

Module    Role
Core    NetworkClient, Logger, Persistence 등 공용 유틸
Data    API 통신, Repository 구현, Kakao Platform Error 핸들링
Domain    Entity, UseCase, Repository Protocol 정의
Presentation    SwiftUI 화면 + TCA Feature 구성
App    DI 조립 및 실행 진입점


⸻

🧑‍💻 개발 환경

항목    버전
macOS    15.6+
Xcode    16.0+
Swift    6.0
iOS Deployment Target    17.0


⸻

🚀 빌드 문제 발생 시

# 1. Tuist 캐시 정리
tuist clean

# 2. DerivedData 제거
rm -rf ~/Library/Developer/Xcode/DerivedData

# 3. 다시 생성
tuist generate


⸻

🧭 참고
    •    Kakao Developers API 문서
    •    Tuist 공식 문서
    •    TCA Documentation
