import XCTest
@testable import ChessClock

final class TimeCountingModelTests: XCTestCase {

    func testEmptyCut() {
        let countingModel = TimeCountingModel()

        XCTAssertTrue(countingModel.intervals.isEmpty)
        countingModel.cutTimeStamp()
        XCTAssertTrue(countingModel.intervals.isEmpty)
    }

    func testNotEmptyCut() {
        let countingModel = TimeCountingModel()

        countingModel.workTime.currentTime = 10
        countingModel.cutTimeStamp()
        XCTAssertFalse(countingModel.intervals.isEmpty)
        XCTAssertEqual(countingModel.intervals.last?.seconds, 10)
        XCTAssertEqual(countingModel.intervals.last?.timeType, .work)
    }

    func testMultipleCuts() {
        let countingModel = TimeCountingModel()

        countingModel.workTime.currentTime = 10
        countingModel.cutTimeStamp()
        countingModel.restTime.currentTime = 20
        countingModel.cutTimeStamp()

        XCTAssertTrue(countingModel.intervals.count == 2)
        XCTAssertEqual(countingModel.intervals.last?.seconds, 20)
        XCTAssertEqual(countingModel.intervals.last?.timeType, .rest)
    }

    func testMultipleCutsWithEmpty() {
        let countingModel = TimeCountingModel()

        countingModel.workTime.currentTime = 10
        countingModel.cutTimeStamp()
        countingModel.cutTimeStamp()

        XCTAssertTrue(countingModel.intervals.count == 1)
        XCTAssertEqual(countingModel.intervals.last?.seconds, 10)
        XCTAssertEqual(countingModel.intervals.last?.timeType, .work)
    }
}
