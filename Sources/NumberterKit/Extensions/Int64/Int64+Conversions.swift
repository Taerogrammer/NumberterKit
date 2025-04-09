//
//  Int64+Conversions.swift
//  NumberterKit
//
//  Created by 김태형 on 4/9/25.
//

import Foundation

// MARK: - Int64 → 기본 타입 및 Decimal 변환

public extension Int64 {

    /// `Int64` → `Decimal`
    var decimalValue: Decimal {
        Decimal(self)
    }

    /// `Int64` → `Double`
    var doubleValue: Double {
        Double(self)
    }

    /// `Int64` → `Float`
    var floatValue: Float {
        Float(self)
    }

    /// `Int64` → `Int`
    var intValue: Int {
        Int(self)
    }

    /// `Int64` → `Int8`
    var int8Value: Int8 {
        Int8(self)
    }

    /// `Int64` → `Int16`
    var int16Value: Int16 {
        Int16(self)
    }

    /// `Int64` → `Int32`
    var int32Value: Int32 {
        Int32(self)
    }

    /// `Int64` → `UInt`
    var uintValue: UInt {
        UInt(self)
    }

    /// `Int64` → `Bool`
    var boolValue: Bool {
        self != 0
    }

    /// `Int64` → `String`
    var stringValue: String {
        String(self)
    }

    /// `Int64` → `NSNumber`
    var number: NSNumber {
        NSNumber(value: self)
    }
}
