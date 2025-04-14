# CHANGELOG

이 문서는 [Semantic Versioning](https://semver.org/lang/ko/)에 따라 NumberterKit의 모든 변경 사항을 기록합니다.

---

## [1.0.3] - 2025-04-14

### 추가됨

- Decimal.formatted(fractionDigits:) 메서드 추가
  - 지정된 소수점 자리수로 포맷된 문자열을 반환하는 기능

    예: Decimal(1234.5678).formatted(fractionDigits: 2) → "1,234.57"
- 기본 ```.formatted```와 일관된 인터페이스를 제공하면서 정밀한 포맷 제어 가능

## [1.0.2] - 2025-04-09

### 변경 없음
- 내부 배포 과정에서 문제가 발생하여 동일한 코드를 다시 배포한 버전입니다.
- 기능적으로는 `1.0.1`과 완전히 동일합니다.

---

## [1.0.1] - 2025-04-09

### 제거됨
- `Decimal` 타입에 대해 명시적으로 정의되어 있던 **복합 대입 연산자 오버로딩 (`+=`, `-=`, `*=`, `/=`)** 제거
  - 해당 연산자들은 Swift 표준 라이브러리에 이미 정의되어 있어, 중복 정의가 의미 없고 혼란을 유발할 수 있었음
  - 중복 정의를 제거함으로써 코드의 명확성과 유지보수성을 향상시킴

---

## [1.0.0] - 2025-04-08

### 추가됨
- `Decimal` 확장
  - `.formatted`: 쉼표 포함 숫자 포맷팅
  - `.percentString()`: 소수점 고정 퍼센트 문자열 출력
  - `.currencyString(style:)`: `₩`, `$` 등의 통화 표현
  - `.rounded(scale:mode:)`: 정밀 반올림 기능
  - `.toRoundedInt()`, `.toRoundedDouble()` 등 편리한 후처리
  - `.intValue`, `.floatValue`, `.stringValue`, `.boolValue` 등 타입 변환 기능
- `FormatterProvider`
  - `NumberFormatter` 인스턴스를 캐싱하여 성능 최적화
  - `ko_KR`, `en_US` 기반의 기본 포맷터 제공
- `CurrencyStyle` 열거형
  - `.won`, `.dollar` 스타일과 로케일 자동 매핑 지원
- 기본 `Int64` 확장 구조 정의 (기능 추가 예정)

---

## 포맷 안내

- `추가됨 (Added)` – 새로운 기능 도입
- `변경됨 (Changed)` – 기존 기능의 동작 혹은 구조 변경 (호환성 유지)
- `제거됨 (Removed)` – 더 이상 사용되지 않는 기능 제거
- `수정됨 (Fixed)` – 버그 또는 오작동 수정
