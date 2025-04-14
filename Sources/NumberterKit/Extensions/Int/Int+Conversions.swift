//
//  File.swift
//  NumberterKit
//
//  Created by 김태형 on 4/14/25.
//

import Foundation

// MARK: - Int → 기본 타입 변환

public extension Int {

    /// `Int` → `Int8`
    var int8Value: Int8 {
        Int8(self)
    }

    /// `Int` → `Int16`
    var int16Value: Int16 {
        Int16(self)
    }

    /// `Int` → `Int32`
    var int32Value: Int32 {
        Int32(self)
    }

    /// `Int` → `Int64`
    var int64Value: Int64 {
        Int64(self)
    }

    /// `Int` → `UInt`
    var uintValue: UInt {
        UInt(self)
    }

    /// `Int` → `Float`
    var floatValue: Float {
        Float(self)
    }

    /// `Int` → `Double`
    var doubleValue: Double {
        Double(self)
    }

    /// `Int` → `Decimal`
    var decimalValue: Decimal {
        Decimal(self)
    }

    /// `Int` → `Bool`
    var boolValue: Bool {
        self != 0
    }

    /// `Int` → `String`
    var stringValue: String {
        String(self)
    }

    /// `Int` → `NSNumber` (Foundation 호환)
    var nsNumber: NSNumber {
        NSNumber(value: self)
    }
}
