//
//  ActorFormatterProvider.swift
//  NumberterKit
//
//  Created by 김태형 on 1/28/26.
//

import Foundation

/// Swift Concurrency(actor)를 사용한 NumberFormatter 제공자입니다.
///
/// `FormatterProvider`의 SpinLock 방식과 성능 비교를 위해 구현되었습니다.
/// actor는 내부적으로 serial executor를 사용하여 동시 접근을 직렬화합니다.
///
/// - Note: 비동기(async/await) API를 사용해야 하므로,
///   동기 API가 필요한 경우 `FormatterProvider`를 사용하세요.
@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public actor ActorFormatterProvider {

    /// 공유 인스턴스
    public static let shared = ActorFormatterProvider()

    private let formatter = NumberFormatter()

    private init() {}

    // MARK: - Decimal Formatting

    /// 지정된 소수점 자리수로 포맷된 문자열을 반환합니다.
    public func decimalString(from number: NSNumber, fractionDigits: Int) -> String {
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = fractionDigits
        formatter.maximumFractionDigits = fractionDigits
        formatter.groupingSeparator = ","
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: number) ?? number.description
    }

    /// 정수 포맷 문자열을 반환합니다.
    public func integerDecimalString(from number: NSNumber) -> String {
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        formatter.groupingSeparator = ","
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: number) ?? number.description
    }

    // MARK: - Currency Formatting

    /// 원화 통화 포맷 문자열을 반환합니다.
    public func wonCurrencyString(from number: NSNumber, withSpacing: Bool = true) -> String {
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        formatter.groupingSeparator = ","
        formatter.locale = Locale(identifier: "ko_KR")
        let formatted = formatter.string(from: number) ?? number.description
        return withSpacing ? "\(formatted) ₩" : "\(formatted)₩"
    }

    /// 달러 통화 포맷 문자열을 반환합니다.
    public func dollarCurrencyString(from number: NSNumber, withSpacing: Bool = true) -> String {
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        formatter.groupingSeparator = ","
        formatter.locale = Locale(identifier: "en_US")
        let formatted = formatter.string(from: number) ?? number.description
        return withSpacing ? "\(formatted) $" : "\(formatted)$"
    }

    // MARK: - Percent Formatting

    /// 퍼센트 포맷 문자열을 반환합니다 (2자리 고정).
    public func percentString(from number: NSNumber, withSpacing: Bool = false) -> String {
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.groupingSeparator = ","
        formatter.locale = Locale(identifier: "ko_KR")
        let formatted = formatter.string(from: number) ?? number.description
        return withSpacing ? "\(formatted) %" : "\(formatted)%"
    }
}
