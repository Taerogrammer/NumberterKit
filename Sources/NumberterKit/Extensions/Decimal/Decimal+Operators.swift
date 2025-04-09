//
//  Decimal+Operators.swift
//  NumberterKit
//
//  Created by 김태형 on 4/9/25.
//

import Foundation

// MARK: - Decimal 산술 연산자 정의
public extension Decimal {

    /// Decimal 덧셈 연산자
    ///
    /// ```swift
    /// let a: Decimal = 10.5
    /// let b: Decimal = 5.25
    /// let result = a + b  // 15.75
    /// ```
    static func + (lhs: Decimal, rhs: Decimal) -> Decimal {
        var result = Decimal()
        var lhs = lhs
        var rhs = rhs
        NSDecimalAdd(&result, &lhs, &rhs, .plain)
        return result
    }

    /// Decimal 뺄셈 연산자
    ///
    /// ```swift
    /// let result = Decimal(10) - Decimal(3)  // 7
    /// ```
    static func - (lhs: Decimal, rhs: Decimal) -> Decimal {
        var result = Decimal()
        var lhs = lhs
        var rhs = rhs
        NSDecimalSubtract(&result, &lhs, &rhs, .plain)
        return result
    }

    /// Decimal 곱셈 연산자
    ///
    /// ```swift
    /// let result = Decimal(2.5) * Decimal(4)  // 10.0
    /// ```
    static func * (lhs: Decimal, rhs: Decimal) -> Decimal {
        var result = Decimal()
        var lhs = lhs
        var rhs = rhs
        NSDecimalMultiply(&result, &lhs, &rhs, .plain)
        return result
    }

    /// Decimal 나눗셈 연산자
    ///
    /// ```swift
    /// let result = Decimal(10) / Decimal(4)  // 2.5
    /// ```
    static func / (lhs: Decimal, rhs: Decimal) -> Decimal {
        var result = Decimal()
        var lhs = lhs
        var rhs = rhs
        NSDecimalDivide(&result, &lhs, &rhs, .plain)
        return result
    }

    /// Decimal 덧셈 복합 할당 연산자
    static func += (lhs: inout Decimal, rhs: Decimal) {
        lhs = lhs + rhs
    }

    /// Decimal 뺄셈 복합 할당 연산자
    static func -= (lhs: inout Decimal, rhs: Decimal) {
        lhs = lhs - rhs
    }

    /// Decimal 곱셈 복합 할당 연산자
    static func *= (lhs: inout Decimal, rhs: Decimal) {
        lhs = lhs * rhs
    }

    /// Decimal 나눗셈 복합 할당 연산자
    static func /= (lhs: inout Decimal, rhs: Decimal) {
        lhs = lhs / rhs
    }
}
