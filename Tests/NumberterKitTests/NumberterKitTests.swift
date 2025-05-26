import XCTest
@testable import NumberterKit

final class DecimalFormatterTests: XCTestCase {

    func testFormattedInteger() {
        let value = Decimal(123456)
        let formatted = value.formatted
        XCTAssertEqual(formatted, "123,456", "정수 포맷이 잘못되었습니다")
    }

    func testFormattedDecimalWithFractionDigits() {
        let value = Decimal(string: "1234.5678")!
        let formatted = value.formatted(fractionDigits: 2)
        XCTAssertEqual(formatted, "1,234.57", "소수점 2자리 포맷이 잘못되었습니다")
    }

    func testPercentFormattingWithoutSpacing() {
        let value = Decimal(string: "0.1234")!
        let percent = value.percentString()
        XCTAssertEqual(percent, "12.34%", "퍼센트 포맷이 잘못되었습니다 (공백 없음)")
    }

    func testPercentFormattingWithSpacing() {
        let value = Decimal(string: "0.1234")!
        let percent = value.percentString(withSpacing: true)
        XCTAssertEqual(percent, "12.34 %", "퍼센트 포맷이 잘못되었습니다 (공백 있음)")
    }

    func testCurrencyStringWonDefault() {
        let value = Decimal(string: "1234.56")!
        let currency = value.currencyString(.won)
        XCTAssertEqual(currency, "1,235 ₩", "₩ 통화 포맷이 잘못되었습니다 (기본)")
    }

    func testCurrencyStringWonNoSpacing() {
        let value = Decimal(string: "1234.56")!
        let currency = value.currencyString(.won, withSpacing: false)
        XCTAssertEqual(currency, "1,235₩", "₩ 통화 포맷이 잘못되었습니다 (공백 없음)")
    }

    func testCurrencyStringDollarDefault() {
        let value = Decimal(string: "1234.56")!
        let currency = value.currencyString(.dollar)
        XCTAssertEqual(currency, "1,235 $", "$ 통화 포맷이 잘못되었습니다 (기본)")
    }

    func testCurrencyStringDollarNoSpacing() {
        let value = Decimal(string: "1234.56")!
        let currency = value.currencyString(.dollar, withSpacing: false)
        XCTAssertEqual(currency, "1,235$", "$ 통화 포맷이 잘못되었습니다 (공백 없음)")
    }
}
