//
//  File.swift
//  NumberterKit
//
//  Created by 김태형 on 4/14/25.
//

import Foundation

// MARK: - Double 반올림 후 변환 확장

public extension Double {

    /// 지정된 반올림 조건으로 `Double`을 반올림합니다.
    ///
    /// - Parameters:
    ///   - scale: 소수점 자리 수 (기본값 0)
    ///   - mode: 반올림 모드 (기본값 .plain)
    /// - Returns: 반올림된 Double
    func rounded(
        scale: Int = 0,
        mode: NSDecimalNumber.RoundingMode = .plain
    ) -> Double {
        let decimalValue = NSDecimalNumber(value: self)
        let behavior = NSDecimalNumberHandler(
            roundingMode: mode,
            scale: Int16(scale),
            raiseOnExactness: false,
            raiseOnOverflow: false,
            raiseOnUnderflow: false,
            raiseOnDivideByZero: false
        )
        return decimalValue.rounding(accordingToBehavior: behavior).doubleValue
    }

    /// 반올림된 값을 `Int`로 반환합니다.
    ///
    /// ```swift
    /// let value: Double = 1234.56
    /// let result = value.toRoundedInt()  // 1235
    /// ```
    func toRoundedInt(scale: Int = 0, mode: NSDecimalNumber.RoundingMode = .plain) -> Int {
        rounded(scale: scale, mode: mode).intValue
    }

    /// 반올림된 값을 `Int64`로 반환합니다.
    func toRoundedInt64(scale: Int = 0, mode: NSDecimalNumber.RoundingMode = .plain) -> Int64 {
        Int64(rounded(scale: scale, mode: mode))
    }

    /// 반올림된 값을 `Float`로 반환합니다.
    func toRoundedFloat(scale: Int = 0, mode: NSDecimalNumber.RoundingMode = .plain) -> Float {
        Float(rounded(scale: scale, mode: mode))
    }

    /// 반올림된 값을 `Decimal`로 반환합니다.
    func toRoundedDecimal(scale: Int = 0, mode: NSDecimalNumber.RoundingMode = .plain) -> Decimal {
        Decimal(rounded(scale: scale, mode: mode))
    }

    /// 반올림된 값을 `NSDecimalNumber`로 반환합니다.
    func toRoundedNSDecimalNumber(scale: Int = 0, mode: NSDecimalNumber.RoundingMode = .plain) -> NSDecimalNumber {
        NSDecimalNumber(value: rounded(scale: scale, mode: mode))
    }
}
