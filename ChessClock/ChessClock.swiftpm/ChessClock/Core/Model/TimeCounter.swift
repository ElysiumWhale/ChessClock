import SwiftUI

final class TimeCounter: ObservableObject {
    private var lastCutTime: UInt = 0

    @Published
    var currentTime: UInt = 0 {
        didSet {
            let (hours, minutes, seconds) = currentTime.separateToComponents()
            self.seconds = seconds
            self.minutes = minutes
            self.hours = hours
        }
    }

    @Published
    private(set) var seconds: UInt = 0
    @Published
    private(set) var minutes: UInt = 0
    @Published
    private(set) var hours: UInt = 0

    var difference: UInt {
        currentTime - lastCutTime
    }

    func cutStamp() {
        lastCutTime = lastCutTime < currentTime
            ? currentTime
            : 0
    }
}

extension TimeCounter {
    static func withTime(_ time: UInt) -> TimeCounter {
        let counter = TimeCounter()
        counter.currentTime = time
        return counter
    }
}
