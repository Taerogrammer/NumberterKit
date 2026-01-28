//
//  ConcurrencyPerformanceTests.swift
//  NumberterKit
//
//  Created by 김태형 on 1/28/26.
//

import XCTest
@testable import NumberterKit

/// Swift Concurrency(actor)와 os_unfair_lock(SpinLock)의 성능을 비교하는 테스트입니다.
///
/// ## 테스트 시나리오
/// - 싱글 스레드 환경에서의 성능 비교
/// - 멀티 스레드 환경에서의 성능 비교
/// - 고부하 조건에서의 비교
///
/// ## 결론
/// - 싱글/멀티 스레드 모두 SpinLock과 Actor의 성능은 거의 동등
/// - Actor는 async/await API를 강제하므로, 동기 API가 필요한 라이브러리에서는 SpinLock이 더 적합
@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
final class ConcurrencyPerformanceTests: XCTestCase {

    private let testNumber = NSNumber(value: 1234.5678)
    private let iterations = 10_000
    private let threadCount = 10

    /// CPU 코어 수 (공정한 비교를 위해 사용)
    private var coreCount: Int {
        ProcessInfo.processInfo.activeProcessorCount
    }

    // MARK: - 싱글 스레드 성능 테스트

    /// SpinLock (os_unfair_lock) - 싱글 스레드
    func testSpinLock_SingleThread() {
        measure {
            for _ in 0..<iterations {
                _ = FormatterProvider.decimal(fractionDigits: 2).string(from: testNumber)
            }
        }
    }

    /// Actor (async/await) - 싱글 스레드
    func testActor_SingleThread() {
        measure {
            let expectation = expectation(description: "Actor formatting")
            let number = testNumber
            let count = iterations

            Task {
                for _ in 0..<count {
                    _ = await ActorFormatterProvider.shared.decimalString(from: number, fractionDigits: 2)
                }
                expectation.fulfill()
            }

            wait(for: [expectation], timeout: 60.0)
        }
    }

    // MARK: - 멀티 스레드 성능 테스트

    /// SpinLock (os_unfair_lock) - 멀티 스레드
    func testSpinLock_MultiThread() {
        let number = testNumber
        let iterationsPerThread = iterations / threadCount

        measure {
            DispatchQueue.concurrentPerform(iterations: threadCount) { _ in
                for _ in 0..<iterationsPerThread {
                    _ = FormatterProvider.decimal(fractionDigits: 2).string(from: number)
                }
            }
        }
    }

    /// Actor (TaskGroup) - 멀티 스레드
    func testActor_MultiThread() {
        let number = testNumber
        let threadCount = self.threadCount
        let iterationsPerThread = iterations / threadCount

        measure {
            let expectation = expectation(description: "Actor multi-thread")

            Task {
                await withTaskGroup(of: Void.self) { group in
                    for _ in 0..<threadCount {
                        group.addTask {
                            for _ in 0..<iterationsPerThread {
                                _ = await ActorFormatterProvider.shared.decimalString(from: number, fractionDigits: 2)
                            }
                        }
                    }
                }
                expectation.fulfill()
            }

            wait(for: [expectation], timeout: 60.0)
        }
    }

    // MARK: - 고부하 테스트 (100,000회)

    /// SpinLock - 고부하 싱글 스레드
    func testSpinLock_HighLoad() {
        let highIterations = 100_000

        measure {
            for _ in 0..<highIterations {
                _ = FormatterProvider.decimal(fractionDigits: 2).string(from: testNumber)
            }
        }
    }

    /// Actor - 고부하 싱글 스레드
    func testActor_HighLoad() {
        let highIterations = 100_000
        let number = testNumber

        measure {
            let expectation = expectation(description: "Actor high load")

            Task {
                for _ in 0..<highIterations {
                    _ = await ActorFormatterProvider.shared.decimalString(from: number, fractionDigits: 2)
                }
                expectation.fulfill()
            }

            wait(for: [expectation], timeout: 120.0)
        }
    }

    // MARK: - 높은 동시성 테스트 (50 스레드/태스크)

    /// SpinLock - 높은 동시성
    func testSpinLock_HighConcurrency() {
        let highThreadCount = 50
        let iterationsPerThread = 200
        let number = testNumber

        measure {
            DispatchQueue.concurrentPerform(iterations: highThreadCount) { _ in
                for _ in 0..<iterationsPerThread {
                    _ = FormatterProvider.decimal(fractionDigits: 2).string(from: number)
                }
            }
        }
    }

    /// Actor - 높은 동시성
    func testActor_HighConcurrency() {
        let highThreadCount = 50
        let iterationsPerThread = 200
        let number = testNumber

        measure {
            let expectation = expectation(description: "Actor high concurrency")

            Task {
                await withTaskGroup(of: Void.self) { group in
                    for _ in 0..<highThreadCount {
                        group.addTask {
                            for _ in 0..<iterationsPerThread {
                                _ = await ActorFormatterProvider.shared.decimalString(from: number, fractionDigits: 2)
                            }
                        }
                    }
                }
                expectation.fulfill()
            }

            wait(for: [expectation], timeout: 60.0)
        }
    }

    // MARK: - 공정한 비교 (CPU 코어 수 = 스레드 수)
    //
    // Actor는 내부적으로 Cooperative Thread Pool을 사용하며,
    // 스레드 수가 CPU 코어 수로 제한됩니다.
    // 공정한 비교를 위해 SpinLock도 동일한 스레드 수로 테스트합니다.

    /// SpinLock - CPU 코어 수만큼 스레드 사용
    func testSpinLock_FairComparison() {
        let number = testNumber
        let threadCount = coreCount
        let iterationsPerThread = iterations / threadCount

        measure {
            DispatchQueue.concurrentPerform(iterations: threadCount) { _ in
                for _ in 0..<iterationsPerThread {
                    _ = FormatterProvider.decimal(fractionDigits: 2).string(from: number)
                }
            }
        }
    }

    /// Actor - CPU 코어 수만큼 태스크 사용
    func testActor_FairComparison() {
        let number = testNumber
        let threadCount = coreCount
        let iterationsPerThread = iterations / threadCount

        measure {
            let expectation = expectation(description: "Actor fair comparison")

            Task {
                await withTaskGroup(of: Void.self) { group in
                    for _ in 0..<threadCount {
                        group.addTask {
                            for _ in 0..<iterationsPerThread {
                                _ = await ActorFormatterProvider.shared.decimalString(from: number, fractionDigits: 2)
                            }
                        }
                    }
                }
                expectation.fulfill()
            }

            wait(for: [expectation], timeout: 60.0)
        }
    }

    /// 매번 새 인스턴스 - CPU 코어 수만큼 스레드 사용
    func testNewInstance_FairComparison() {
        let number = testNumber
        let threadCount = coreCount
        let iterationsPerThread = iterations / threadCount

        measure {
            DispatchQueue.concurrentPerform(iterations: threadCount) { _ in
                for _ in 0..<iterationsPerThread {
                    let formatter = NumberFormatter()
                    formatter.numberStyle = .decimal
                    formatter.minimumFractionDigits = 2
                    formatter.maximumFractionDigits = 2
                    formatter.groupingSeparator = ","
                    formatter.locale = Locale(identifier: "ko_KR")
                    _ = formatter.string(from: number)
                }
            }
        }
    }

    // MARK: - 베이스라인 (매번 새 인스턴스 생성)

    /// 매번 새 NumberFormatter 생성 - 싱글 스레드
    func testNewInstance_SingleThread() {
        measure {
            for _ in 0..<iterations {
                let formatter = NumberFormatter()
                formatter.numberStyle = .decimal
                formatter.minimumFractionDigits = 2
                formatter.maximumFractionDigits = 2
                formatter.groupingSeparator = ","
                formatter.locale = Locale(identifier: "ko_KR")
                _ = formatter.string(from: testNumber)
            }
        }
    }

    /// 매번 새 NumberFormatter 생성 - 멀티 스레드
    func testNewInstance_MultiThread() {
        let number = testNumber
        let iterationsPerThread = iterations / threadCount

        measure {
            DispatchQueue.concurrentPerform(iterations: threadCount) { _ in
                for _ in 0..<iterationsPerThread {
                    let formatter = NumberFormatter()
                    formatter.numberStyle = .decimal
                    formatter.minimumFractionDigits = 2
                    formatter.maximumFractionDigits = 2
                    formatter.groupingSeparator = ","
                    formatter.locale = Locale(identifier: "ko_KR")
                    _ = formatter.string(from: number)
                }
            }
        }
    }
}
