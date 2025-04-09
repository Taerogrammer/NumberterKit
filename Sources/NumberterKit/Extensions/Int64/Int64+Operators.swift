//
//  Int64+Operators.swift
//  NumberterKit
//
//  Created by 김태형 on 4/9/25.
//

import Foundation

// MARK: - Int64 산술 연산자 정의

public extension Int64 {

    /// Int64 덧셈 연산자
    ///
    /// ```swift
    /// let result = 10 + 5  // 15
    /// ```
    static func + (lhs: Int64, rhs: Int64) -> Int64 {
        lhs.addingReportingOverflow(rhs).partialValue
    }

    /// Int64 뺄셈 연산자
    ///
    /// ```swift
    /// let result = 10 - 3  // 7
    /// ```
    static func - (lhs: Int64, rhs: Int64) -> Int64 {
        lhs.subtractingReportingOverflow(rhs).partialValue
    }

    /// Int64 곱셈 연산자
    ///
    /// ```swift
    /// let result = 2 * 4  // 8
    /// ```
    static func * (lhs: Int64, rhs: Int64) -> Int64 {
        lhs.multipliedReportingOverflow(by: rhs).partialValue
    }

    /// Int64 나눗셈 연산자
    ///
    /// ```swift
    /// let result = 10 / 2  // 5
    /// ```
    static func / (lhs: Int64, rhs: Int64) -> Int64 {
        lhs / rhs
    }

    /// 덧셈 복합 할당 연산자
    static func += (lhs: inout Int64, rhs: Int64) {
        lhs = lhs + rhs
    }

    /// 뺄셈 복합 할당 연산자
    static func -= (lhs: inout Int64, rhs: Int64) {
        lhs = lhs - rhs
    }

    /// 곱셈 복합 할당 연산자
    static func *= (lhs: inout Int64, rhs: Int64) {
        lhs = lhs * rhs
    }

    /// 나눗셈 복합 할당 연산자
    static func /= (lhs: inout Int64, rhs: Int64) {
        lhs = lhs / rhs
    }
}
