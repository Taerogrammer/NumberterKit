//
//  CurrencyStyle.swift
//  NumberterKit
//
//  Created by 김태형 on 4/9/25.
//

import Foundation

// MARK: - Currency 스타일

/// 사용할 통화 스타일
public enum CurrencyStyle {
    case won
    case dollar

    var symbol: String {
        switch self {
        case .won: return "₩"
        case .dollar: return "$"
        }
    }

    var localeIdentifier: String {
        switch self {
        case .won: return "ko_KR"
        case .dollar: return "en_US"
        }
    }
}
