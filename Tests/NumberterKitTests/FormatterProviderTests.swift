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
}
