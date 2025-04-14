//
//  File.swift
//  NumberterKit
//
//  Created by 김태형 on 4/14/25.
//

import Foundation

// MARK: - Double → 기본 타입 변환

public extension Double {

    /// `Double` → `Int`
    var intValue: Int {
        Int(self)
    }

    /// `Double` → `Int8`
    var int8Value: Int8 {
        Int8(self)
    }

    /// `Double` → `Int16`
    var int16Value: Int16 {
        Int16(self)
    }

    /// `Double` → `Int32`
    var int32Value: Int32 {
        Int32(self)
    }

    /// `Double` → `Int64`
    var int64Value: Int64 {
        Int64(self)
    }

    /// `Double` → `UInt`
    var uintValue: UInt {
        UInt(self)
    }

    /// `Double` → `Float`
    var floatValue: Float {
        Float(self)
    }

    /// `Double` → `Decimal`
    var decimalValue: Decimal {
        Decimal(self)
    }

    /// `Double` → `Bool`
    var boolValue: Bool {
        self != 0
    }

    /// `Double` → `String` (정밀한 숫자 표현 문자열)
    var stringValue: String {
        String(self)
    }

    /// `Double` → `NSNumber` (Foundation 호환)
    var nsNumber: NSNumber {
        NSNumber(value: self)
    }
}
