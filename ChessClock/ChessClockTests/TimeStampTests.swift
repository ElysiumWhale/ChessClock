import XCTest
@testable import ChessClock

final class TimeStampTests: XCTestCase {

    func testTimeStampInit() {
        let timeStamp = TimeStamp(
            timeType: .work,
            hours: 1,
            minutes: 10,
            seconds: 30
        )

        XCTAssertEqual(timeStamp.hours, 1)
        XCTAssertEqual(timeStamp.minutes, 10)
        XCTAssertEqual(timeStamp.seconds, 30)
    }

    func testTimeStampInitWithSeparation() {
        let timeStamp = TimeStamp(timeType: .work, onlySeconds: 50)
        XCTAssertEqual(timeStamp.hours, 0)
        XCTAssertEqual(timeStamp.minutes, 0)
        XCTAssertEqual(timeStamp.seconds, 50)

        let timeStamp1 = TimeStamp(timeType: .work, onlySeconds: 120)
        XCTAssertEqual(timeStamp1.hours, 0)
        XCTAssertEqual(timeStamp1.minutes, 2)
        XCTAssertEqual(timeStamp1.seconds, 0)

        let timeStamp2 = TimeStamp(timeType: .work, onlySeconds: 130)
        XCTAssertEqual(timeStamp2.hours, 0)
        XCTAssertEqual(timeStamp2.minutes, 2)
        XCTAssertEqual(timeStamp2.seconds, 10)

        let timeStamp3 = TimeStamp(timeType: .work, onlySeconds: 3666)
        XCTAssertEqual(timeStamp3.hours, 1)
        XCTAssertEqual(timeStamp3.minutes, 1)
        XCTAssertEqual(timeStamp3.seconds, 6)

        let timeStamp4 = TimeStamp(timeType: .work, onlySeconds: 7204)
        XCTAssertEqual(timeStamp4.hours, 2)
        XCTAssertEqual(timeStamp4.minutes, 0)
        XCTAssertEqual(timeStamp4.seconds, 4)
    }
}
