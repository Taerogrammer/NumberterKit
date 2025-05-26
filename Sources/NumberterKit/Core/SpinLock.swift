//
//  File.swift
//  NumberterKit
//
//  Created by 김태형 on 4/18/25.
//

import os.lock

/// `os_unfair_lock`을 기반으로 한 경량 락 구현체입니다.
///
/// 이 락은 매우 빠른 성능을 제공하지만, **재진입(reentrant)** 을 허용하지 않기 때문에
/// 동일한 스레드에서 중첩으로 `lock()`을 호출하면 데드락이 발생할 수 있습니다.
///
/// 주로 **락 유지 시간이 짧고, 재귀 호출이 발생하지 않는 임계 구역**에 적합합니다.
/// 예: 배열에 하나 추가, 설정값 변경 등 단순한 동기화 작업.
///
/// `os_unfair_lock`은 Apple이 `OSSpinLock`의 priority inversion 문제를 해결하기 위해 도입한 락입니다.
///
/// ⚠️ 주의: 이 락은 **같은 스레드에서 중복 `lock()` 호출이 필요한 경우에는 사용하면 안 됩니다.**
public final class SpinLock {

    /// 내부적으로 사용하는 unfair lock 객체입니다.
    private var unfairLock = os_unfair_lock_s()

    /// 새로운 `SpinLock` 인스턴스를 생성합니다.
    public init() {}

    /// 락을 획득합니다.
    ///
    /// 락이 이미 다른 스레드에 의해 획득된 경우, 현재 스레드는 블로킹됩니다.
    public func lock() {
        os_unfair_lock_lock(&unfairLock)
    }

    /// 락을 해제합니다.
    ///
    /// 반드시 `lock()`을 먼저 호출한 이후에 호출되어야 합니다.
    public func unlock() {
        os_unfair_lock_unlock(&unfairLock)
    }

    /// 락을 획득한 뒤, 전달된 클로저를 실행하고 종료 후 락을 해제합니다.
    ///
    /// - Parameter block: 락 안에서 실행할 임계 구역 코드
    /// - Returns: 클로저의 반환값
    @discardableResult
    public func performLocked<T>(_ block: () throws -> T) rethrows -> T {
        lock()
        defer { unlock() }
        return try block()
    }
}
