# NumberterKit

![Swift](https://img.shields.io/badge/Swift-5.7%2B-orange)
![Version](https://img.shields.io/github/v/tag/Taerogrammer/NumberterKit)
[![Changelog](https://img.shields.io/badge/Changelog-View-blue)](CHANGELOG.md)

**NumberterKit**은 Swift에서 숫자 데이터를 깔끔하고 일관된 방식으로 처리하기 위한 유틸리티 라이브러리입니다.  
숫자 포맷팅, 통화 및 퍼센트 표현, 형 변환, 반올림 등 다양한 수치 기반 연산을 간결하게 다룰 수 있도록 돕습니다.  
현재는 `Decimal`과 `Int64` 중심으로 구성되어 있으며, 향후 다양한 숫자 타입으로의 확장을 지속적으로 지원할 예정입니다.

<br>

## 주요 기능

- **유연한 숫자 포맷팅 지원**  
  쉼표 포함 포맷, 고정 소수점 자리, 퍼센트 표현 등 실무에서 자주 사용되는 포맷을 간단하게 처리할 수 있습니다.

- **통화 및 퍼센트 표현 기능**  
  `₩`, `$` 등 통화 단위를 포함한 표현을 스타일에 따라 출력할 수 있으며, 퍼센트 기호 간격 등 세부 설정도 가능합니다.

- **정밀한 반올림 및 후처리 기능**  
  소수점 자리수 및 반올림 모드 지정 가능하며, 다양한 기본 타입으로의 변환도 지원합니다.

- **다양한 숫자 타입 간 변환 지원**  
  `Decimal` 값을 `Int`, `Float`, `Double`, `Bool`, `String`, `NSDecimalNumber` 등으로 안전하게 변환할 수 있습니다.

- **확장 중심의 설계**  
  기능은 각 숫자 타입에 대한 Extension 형태로 제공되어 사용법이 직관적이고 코드 가독성이 뛰어납니다.

- **고정된 포맷터 인스턴스 재사용**  
  내부적으로 포맷터는 캐싱되어 재사용되며, 성능 최적화에 유리합니다.

<br><br><br>

# 설치 방법

### Swift Package Manager (SPM)

NumberterKit은 Swift Package Manager만 지원합니다.

#### Xcode를 이용한 설치

1. `File > Add Packages...` 메뉴 선택
2. 다음 URL 입력: ```https://github.com/Taerogrammer/NumberterKit.git```
3. 원하는 버전 선택 후 `Add Package`

#### 수동으로 `Package.swift`에 추가

```swift
dependencies: [
 .package(url: "https://github.com/yourname/NumberterKit.git", from: "1.0.2")
]
```

<br><br><br>

# 사용 예시

## 숫자 포맷 (쉼표 포함)

```
let value: Decimal = 1234567.89
let formatted = value.formatted
// 결과: "1,234,568"
```

<br>

## 퍼센트 포맷
```
let rate: Decimal = 0.12345

rate.percentString()
// 결과: "12.35%"

rate.percentString(withSpacing: true)
// 결과: "12.35 %"
```

<br>

### 통화 포맷
```
let price: Decimal = 123456.78

price.currencyString(.won)
// 결과: "123,457 ₩"

price.currencyString(.dollar, withSpacing: false)
// 결과: "123,457$"
```

<br>

### 반올림 처리
```
let value: Decimal = 1234.5678

value.rounded(scale: 2)
// 결과: Decimal(1234.57)

value.toRoundedInt()
// 결과: 1235

value.toRoundedDouble(scale: 1)
// 결과: 1234.6
```
<br>

### 기본 타입 변환
```
let value: Decimal = 789.01

let intVal = value.intValue          // Int
let doubleVal = value.doubleValue    // Double
let boolVal = value.boolValue        // Bool
let stringVal = value.stringValue    // String
let nsDecimal = value.nsDecimalNumber // NSDecimalNumber
```

<br><br><br>

# 요구사항
- Swift 5.7 이상

<br><br>

# 버전 정보


현재 최신 버전: **v1.0.5**

NumberterKit은 시맨틱 버전(Semantic Versioning)을 따릅니다.  
전체 변경 이력은 [CHANGELOG.md](CHANGELOG.md)에서 확인하실 수 있습니다.

| 버전  | 주요 변경 사항 |
|--------|----------------|
| 1.0.5 | 	SpinLock 기법 도입으로 NumberFormatter 공유 시 멀티스레드 안정성 확보<br>성능 측정 및 단위 테스트 코드 추가 |
| 1.0.4 | .formatted, .percentString(), .currencyString() 등의 API를 Int 및 Double 타입에도 확장 적용 |
| 1.0.3 | 지정된 소수점 자리수로 포맷된 문자열을 반환하는 기능 |
| 1.0.2 | (재배포) 내부 배포 문제로 인한 코드 변경 없는 릴리스 |
| 1.0.1 | `Decimal` 복합 연산자 오버로딩 제거 (`+=`, `-=`, `*=`, `/=`) |
| 1.0.0 | `Decimal` 및 `Int64` 기반 숫자 포맷팅, 통화, 퍼센트, 형 변환 기능 최초 릴리스 |

<br><br><br>

# 성능 비교

NumberFormatter 인스턴스를 매번 생성하는 방식과
SpinLock 기반으로 공유 인스턴스를 동기화하여 재사용하는 방식의 성능을 비교하였습니다.

<br>

## 테스트 환경


- 싱글 스레드 10,000회 호출
- 멀티 스레드 (10개의 스레드 × 1,000회 호출)

<br>

| 환경           | 방식                        |
| ------------ | ------------------------- |
| 테스트 기기       | MacBook Pro (Apple Silicon M1)      |
| 테스트 도구       | Xcode XCTest.measure |
| 테스트 횟수 | 기본 10회 반복 측정      |
| 성능 지표 | 평균 실행 시간 (Wall Clock Time) |
| 비교 대상 | 공유 인스턴스 방식 vs 매번 새 인스턴스 생성 방식 |

<br>


| 환경           | 방식                        | 평균 실행 시간 (초) |
| ------------ | ------------------------- | ------------ |
| 싱글 스레드       | 매번 생성 (`newDecimal`)      | `~0.327s`     |
| 싱글 스레드       | 공유 + SpinLock (`decimal`) | `~0.0796s`     |
| 멀티 스레드 (10개) | 매번 생성 (`newDecimal`)      | `~0.265s`     |
| 멀티 스레드 (10개) | 공유 + SpinLock (`decimal`) | `~0.122s`     |

<br>