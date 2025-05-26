//
//  FormatterProviderTests.swift
//  NumberterKit
//
//  Created by 김태형 on 4/19/25.
//

import XCTest
@testable import NumberterKit

final class FormatterProviderTests: XCTestCase {

    func testDecimalFormatterWithFractionDigits() {
        let formatter = FormatterProvider.decimal(fractionDigits: 2)
        XCTAssertEqual(formatter.minimumFractionDigits, 2)
        XCTAssertEqual(formatter.maximumFractionDigits, 2)
        XCTAssertEqual(formatter.locale.identifier, "ko_KR")
    }

    func testIntegerDecimalFormatter() {
        let formatter = FormatterProvider.integerDecimal()
        XCTAssertEqual(formatter.maximumFractionDigits, 0)
        XCTAssertEqual(formatter.numberStyle, .decimal)
        XCTAssertEqual(formatter.locale.identifier, "ko_KR")
    }

    func testWonCurrencyFormatter() {
        let formatter = FormatterProvider.wonCurrency()
        XCTAssertEqual(formatter.maximumFractionDigits, 0)
        XCTAssertEqual(formatter.locale.identifier, "ko_KR")
        XCTAssertEqual(formatter.numberStyle, .decimal)
    }

    func testDollarCurrencyFormatter() {
        let formatter = FormatterProvider.dollarCurrency()
        XCTAssertEqual(formatter.maximumFractionDigits, 0)
        XCTAssertEqual(formatter.locale.identifier, "en_US")
        XCTAssertEqual(formatter.numberStyle, .decimal)
    }

    func testPercent2DigitsFormatter() {
        let formatter = FormatterProvider.percent2Digits()
        XCTAssertEqual(formatter.minimumFractionDigits, 2)
        XCTAssertEqual(formatter.maximumFractionDigits, 2)
        XCTAssertEqual(formatter.locale.identifier, "ko_KR")
        XCTAssertEqual(formatter.numberStyle, .decimal)
    }

    func testDecimalFormattingOutput() {
        let number = NSNumber(value: 1234.5678)
        let formatter = FormatterProvider.decimal(fractionDigits: 1)
        let result = formatter.string(from: number)
        XCTAssertEqual(result, "1,234.6", "포맷 결과가 예상과 다릅니다.")
    }

    func testIntToStringConversion() {
        let value: Int = 1234
        let formatted = value.formatted  // 가정: 확장 메서드
        XCTAssertEqual(formatted, "1,234")       // 기대값 비교
    }

    func testDecimalRounding() {
        let value = Decimal(string: "123.4567")!
        let rounded = value.rounded(scale: 2)  // 소수점 둘째 자리 반올림 가정
        XCTAssertEqual(rounded, Decimal(string: "123.46"))
    }


    // MARK: - 성능 테스트
    // MARK: 싱글 스레드
    /// NumberFormatter 생성
    func testFormatterCreationPerformance() {
        measure {
            for _ in 0..<10_000 {
                let formatter = NumberFormatter()
                _ = formatter.string(from: 1234.5678)
            }
        }
    }
    /// 공유 인스턴스
    func testSharedFormatterWithSpinLockPerformance() {
        let number = NSNumber(value: 1234.5678)

        measure {
            for _ in 0..<10_000 {
                _ = FormatterProvider.decimal(fractionDigits: 2).string(from: number)
            }
        }
    }

    // MARK: 멀티 스레드
    /// NumberFormatter 생성
    func testNewFormatterCreationPerformanceMultiThread() {
        let number = NSNumber(value: 1234.5678)
        let iterations = 10_000

        measure {
            DispatchQueue.concurrentPerform(iterations: 10) { _ in
                for _ in 0..<(iterations / 10) {
                    let formatter = NumberFormatter()
                    formatter.numberStyle = .decimal
                    formatter.minimumFractionDigits = 2
                    formatter.maximumFractionDigits = 2
                    formatter.groupingSeparator = ","
                    formatter.locale = Locale(identifier: "ko_KR")

                    _ = formatter.string(from: number)
                }
            }
        }
    }
    /// 공유 인스턴스
    func testSharedFormatterPerformanceMultiThread() {
        let number = NSNumber(value: 1234.5678)
        let iterations = 10_000

        measure {
            DispatchQueue.concurrentPerform(iterations: 10) { _ in
                for _ in 0..<(iterations / 10) {
                    _ = FormatterProvider.decimal(fractionDigits: 2).string(from: number)
                }
            }
        }
    }
}
