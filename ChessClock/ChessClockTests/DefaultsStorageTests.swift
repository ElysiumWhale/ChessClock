import XCTest
@testable import ChessClock

final class DefaultsStorageTests: XCTestCase {

    enum TestKeys: String, CodingKey {
        case test
    }

    private let testContainer = DefaultsContainer(name: "ChessClock.Test")

    func testDefaultsStorageSaveRetrieveClear() {
        let expectation = 100
        let testStorage = DefaultsStorage<TestKeys>(
            container: testContainer
        )

        testStorage.save(_ value: expectation, key: .test)
        let retrieved: Int? = testStorage.retrieve(key: .test)
        XCTAssertEqual(retrieved, expectation)
        testStorage.clearAll()
        let nilRetrieved: Int? = testStorage.retrieve(key: .test)
        XCTAssertNil(nilRetrieved)
    }
}
