//
//  File.swift
//  NumberterKit
//
//  Created by 김태형 on 4/14/25.
//

import Foundation

// MARK: - Int 포맷 관련 확장

public extension Int {

    /// 쉼표 포함된 숫자 포맷 문자열입니다.
    ///
    /// 내부적으로 `FormatterProvider.integerDecimal`을 사용합니다.
    ///
    /// ```swift
    /// Int(123456).formatted  // "123,456"
    /// ```
    var formatted: String {
        FormatterProvider.integerDecimal().string(from: NSNumber(value: self)) ?? "\(self)"
    }

    /// 지정된 소수점 자리수로 포맷된 문자열을 반환합니다.
    ///
    /// 내부적으로 `FormatterProvider.decimal(fractionDigits:)`를 사용합니다.
    ///
    /// ```swift
    /// Int(1234).formatted(fractionDigits: 2)  // "1,234.00"
    /// ```
    func formatted(fractionDigits: Int) -> String {
        FormatterProvider.decimal(fractionDigits: fractionDigits)
            .string(from: NSNumber(value: self)) ?? "\(self)"
    }

    /// 퍼센트 포맷 문자열을 반환합니다.
    ///
    /// - Parameter withSpacing: `%` 기호 앞에 공백을 넣을지 여부 (기본값: `false`)
    ///
    /// ```swift
    /// Int(12).percentString(withSpacing: true)  // "1,200.00 %"
    /// Int(12).percentString(withSpacing: false) // "1,200.00%"
    /// ```
    func percentString(withSpacing: Bool = false) -> String {
        let value = Double(self) * 100
        let formatted = FormatterProvider.percent2Digits()
            .string(from: NSNumber(value: value)) ?? "\(self)"
        return withSpacing ? "\(formatted) %" : "\(formatted)%"
    }

    /// 지정된 통화 스타일로 포맷된 문자열을 반환합니다.
    ///
    /// - Parameters:
    ///   - style: 통화 스타일 (.won, .dollar). 기본값은 `.won`
    ///   - withSpacing: 통화 기호 앞에 공백을 추가할지 여부. 기본값은 `true`
    ///
    /// ```swift
    /// Int(1234).currencyString(.won)                     // "1,234 ₩"
    /// Int(1234).currencyString(.won, withSpacing: false) // "1,234₩"
    /// ```
    func currencyString(_ style: CurrencyStyle = .won, withSpacing: Bool = true) -> String {
        let formatter: NumberFormatter = switch style {
        case .won: FormatterProvider.wonCurrency()
        case .dollar: FormatterProvider.dollarCurrency()
        }

        let formatted = formatter.string(from: NSNumber(value: self)) ?? "\(self)"
        return withSpacing ? "\(formatted) \(style.symbol)" : "\(formatted)\(style.symbol)"
    }
}
