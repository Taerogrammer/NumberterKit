//
//  Int64+Formatting.swift
//  NumberterKit
//
//  Created by 김태형 on 4/9/25.
//

import Foundation

// MARK: - Int64 포맷 관련 확장

public extension Int64 {

    /// 쉼표 포함된 숫자 포맷 문자열입니다.
    ///
    /// 내부적으로 `FormatterProvider.integerDecimal`을 사용합니다.
    ///
    /// ```swift
    /// Int64(123456).formatted  // "123,456"
    /// ```
    var formatted: String {
        FormatterProvider.integerDecimal().string(from: NSNumber(value: self)) ?? "\(self)"
    }

    /// 퍼센트 포맷 문자열을 반환합니다.
    ///
    /// - Parameter withSpacing: `%` 기호 앞에 공백을 넣을지 여부 (기본값: `false`)
    ///
    /// ```swift
    /// Int64(12).percentString(withSpacing: true)  // "1,200.00 %"
    /// Int64(12).percentString(withSpacing: false) // "1,200.00%"
    /// ```
    func percentString(withSpacing: Bool = false) -> String {
        let decimalValue = Decimal(self) * 100
        let formatted = FormatterProvider.percent2Digits().string(from: NSDecimalNumber(decimal: decimalValue)) ?? "\(self)"
        return withSpacing ? "\(formatted) %" : "\(formatted)%"
    }

    /// 지정된 통화 스타일로 포맷된 문자열을 반환합니다.
    ///
    /// - Parameters:
    ///   - style: 통화 스타일 (.won, .dollar). 기본값은 `.won`
    ///   - withSpacing: 통화 기호 앞에 공백을 추가할지 여부. 기본값은 `true`
    ///
    /// ```swift
    /// Int64(123456).currencyString(.won)                     // "123,456 ₩"
    /// Int64(123456).currencyString(.won, withSpacing: false) // "123,456₩"
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
