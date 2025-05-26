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

    func testDecimalWithVariousFractionDigits() {
        let value = NSNumber(value: 1234.5678)
        for digits in 0...4 {
            let formatter = FormatterProvider.decimal(fractionDigits: digits)
            let result = formatter.string(from: value)
            XCTAssertNotNil(result, "digits: \(digits) 포맷 결과가 nil입니다.")
        }
    }

    func testIntegerDecimalFormatterOutput() {
        let value = NSNumber(value: 1234567.0)
        let result = FormatterProvider.integerDecimal().string(from: value)
        XCTAssertEqual(result, "1,234,567", "정수 포맷 출력이 예상과 다릅니다.")
    }

    func testCurrencySymbolOutput() {
        let value = Decimal(1234.56)

        let won = value.currencyString(.won)
        XCTAssertTrue(won.contains("₩"), "₩ 통화 기호가 누락되었습니다.")

        let dollar = value.currencyString(.dollar)
        XCTAssertTrue(dollar.contains("$"), "$ 통화 기호가 누락되었습니다.")
    }

    func testPercentFormattingEdgeCases() {
        let value = Decimal(string: "0.0")!
        let percent = value.percentString(withSpacing: true)
        XCTAssertEqual(percent, "0.00 %", "0% 출력이 올바르지 않습니다.")

        let full = Decimal(string: "1.0")!
        let percent100 = full.percentString()
        XCTAssertEqual(percent100, "100.00%", "100% 출력이 올바르지 않습니다.")
    }

    func testDecimalNegativeFormatting() {
        let value = Decimal(string: "-1234.5678")!
        let formatted = value.formatted(fractionDigits: 1)
        XCTAssertEqual(formatted, "-1,234.6", "음수 포맷 결과가 예상과 다릅니다.")
    }

    func testVariousFractionDigits() {
        let number = Decimal(string: "1234.5678")!
        XCTAssertEqual(number.formatted(fractionDigits: 0), "1,235")
        XCTAssertEqual(number.formatted(fractionDigits: 1), "1,234.6")
        XCTAssertEqual(number.formatted(fractionDigits: 3), "1,234.568")
    }

    func testNegativeDecimalFormatting() {
        let number = Decimal(string: "-9876.54321")!
        XCTAssertEqual(number.formatted(fractionDigits: 2), "-9,876.54")
    }

    func testCurrencySymbolSpacingOptions() {
        let number = Decimal(string: "1234.56")!
        XCTAssertEqual(number.currencyString(.won, withSpacing: true), "1,235 ₩")
        XCTAssertEqual(number.currencyString(.won, withSpacing: false), "1,235₩")
    }

    func testPercentBoundaries() {
        let zero = Decimal(string: "0")!
        let full = Decimal(string: "1")!
        XCTAssertEqual(zero.percentString(), "0.00%")
        XCTAssertEqual(full.percentString(), "100.00%")
    }

    func testFormatterConfigurationValues() {
        let formatter = FormatterProvider.decimal(fractionDigits: 2)
        XCTAssertEqual(formatter.minimumFractionDigits, 2)
        XCTAssertEqual(formatter.maximumFractionDigits, 2)
        XCTAssertEqual(formatter.numberStyle, .decimal)
        XCTAssertEqual(formatter.groupingSeparator, ",")
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
