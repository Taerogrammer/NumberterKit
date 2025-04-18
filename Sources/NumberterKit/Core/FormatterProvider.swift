//
//  FormatterProvider.swift
//  NumberterKit
//
//  Created by 김태형 on 4/9/25.
//

import Foundation

public enum FormatterProvider {
    private static let formatter = NumberFormatter()
    private static let lock = SpinLock()

    /// 지정된 소수점 자리수를 가진 NumberFormatter를 반환합니다.
    public static func decimal(fractionDigits: Int) -> NumberFormatter {
        lock.performLocked {
            formatter.numberStyle = .decimal
            formatter.minimumFractionDigits = fractionDigits
            formatter.maximumFractionDigits = fractionDigits
            formatter.groupingSeparator = ","
            formatter.locale = Locale(identifier: "ko_KR")
            return formatter
        }
    }

    /// 쉼표만 포함, 소수점 없음
    public static let integerDecimal: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        formatter.groupingSeparator = ","
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }()

    /// 통화용 (₩)
    public static let wonCurrency: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        formatter.groupingSeparator = ","
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }()

    /// 통화용 ($)
    public static let dollarCurrency: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        formatter.groupingSeparator = ","
        formatter.locale = Locale(identifier: "en_US")
        return formatter
    }()

    /// 퍼센트용 (2자리 고정)
    public static let percent2Digits: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.groupingSeparator = ","
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }()
}
