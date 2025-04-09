//
//  Decimal+Conversions.swift
//  NumberterKit
//
//  Created by 김태형 on 4/8/25.
//

import Foundation

// MARK: - Decimal → 기본 타입 변환

public extension Decimal {

    /// `Decimal` → `Int`
    var intValue: Int {
        NSDecimalNumber(decimal: self).intValue
    }

    /// `Decimal` → `Int8`
    var int8Value: Int8 {
        NSDecimalNumber(decimal: self).int8Value
    }

    /// `Decimal` → `Int16`
    var int16Value: Int16 {
        NSDecimalNumber(decimal: self).int16Value
    }

    /// `Decimal` → `Int32`
    var int32Value: Int32 {
        NSDecimalNumber(decimal: self).int32Value
    }

    /// `Decimal` → `Int64`
    var int64Value: Int64 {
        NSDecimalNumber(decimal: self).int64Value
    }

    /// `Decimal` → `UInt`
    var uintValue: UInt {
        NSDecimalNumber(decimal: self).uintValue
    }

    /// `Decimal` → `Float`
    var floatValue: Float {
        NSDecimalNumber(decimal: self).floatValue
    }

    /// `Decimal` → `Double`
    var doubleValue: Double {
        NSDecimalNumber(decimal: self).doubleValue
    }

    /// `Decimal` → `Bool`
    var boolValue: Bool {
        NSDecimalNumber(decimal: self).boolValue
    }

    /// `Decimal` → `String` (정밀한 숫자 표현 문자열)
    var stringValue: String {
        NSDecimalNumber(decimal: self).stringValue
    }

    /// `Decimal` → `NSDecimalNumber` (Foundation 호환)
    var nsDecimalNumber: NSDecimalNumber {
        NSDecimalNumber(decimal: self)
    }
}
