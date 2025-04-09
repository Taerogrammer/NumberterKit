//
//  Decimal+Rounding.swift
//  NumberterKit
//
//  Created by 김태형 on 4/9/25.
//

import Foundation

// MARK: - Decimal 반올림 후 변환 확장

public extension Decimal {

    /// 지정된 반올림 조건으로 `Decimal`을 반올림합니다.
    ///
    /// - Parameters:
    ///   - scale: 소수점 자리 수 (기본값 0)
    ///   - mode: 반올림 모드 (기본값 .plain)
    /// - Returns: 반올림된 Decimal
    func rounded(scale: Int = 0, mode: NSDecimalNumber.RoundingMode = .plain) -> Decimal {
        var result = Decimal()
        var base = self
        NSDecimalRound(&result, &base, scale, mode)
        return result
    }

    /// 반올림된 값을 `Int`로 반환합니다.
    ///
    /// ```swift
    /// let value: Decimal = 1234.56
    /// let result = value.toRoundedInt()  // 1235
    /// ```
    func toRoundedInt(scale: Int = 0, mode: NSDecimalNumber.RoundingMode = .plain) -> Int {
        rounded(scale: scale, mode: mode).intValue
    }

    /// 반올림된 값을 `Int64`로 반환합니다.
    func toRoundedInt64(scale: Int = 0, mode: NSDecimalNumber.RoundingMode = .plain) -> Int64 {
        rounded(scale: scale, mode: mode).int64Value
    }

    /// 반올림된 값을 `Double`로 반환합니다.
    func toRoundedDouble(scale: Int = 0, mode: NSDecimalNumber.RoundingMode = .plain) -> Double {
        rounded(scale: scale, mode: mode).doubleValue
    }

    /// 반올림된 값을 `Float`로 반환합니다.
    func toRoundedFloat(scale: Int = 0, mode: NSDecimalNumber.RoundingMode = .plain) -> Float {
        rounded(scale: scale, mode: mode).floatValue
    }

    /// 반올림된 값을 `NSDecimalNumber`로 반환합니다.
    func toRoundedNSDecimalNumber(scale: Int = 0, mode: NSDecimalNumber.RoundingMode = .plain) -> NSDecimalNumber {
        NSDecimalNumber(decimal: rounded(scale: scale, mode: mode))
    }
}
