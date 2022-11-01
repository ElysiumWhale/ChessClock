import Foundation

enum TimeType: String {
    case work
    case rest
}

struct TimeStamp: Identifiable {
    let id: UUID
    let timeType: TimeType

    let seconds: UInt
    let minutes: UInt
    let hours: UInt

    var formattedTime: String {
        [
            hours.withSymbolOrNil("h"),
            minutes.withSymbolOrNil("m"),
            seconds.withSymbolOrNil("s")
        ]
        .compactMap { $0 }
        .joined(separator: " ")
    }

    init(id: UUID = UUID(),
         timeType: TimeType,
         hours: UInt = 0,
         minutes: UInt = 0,
         seconds: UInt = 0) {

        self.id = id
        self.timeType = timeType
        self.seconds = seconds
        self.minutes = minutes
        self.hours = hours
    }

    init(id: UUID = UUID(),
         timeType: TimeType,
         onlySeconds: UInt = 0) {

        self.id = id
        self.timeType = timeType
        let (hours, minutes, seconds) = onlySeconds.separateToComponents()
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
    }
}

extension UInt {
    func separateToComponents() -> (hour: UInt, minute: UInt, second: UInt) {
        switch self {
        case 0...59:
            return (0, 0, self)
        case 60...3599:
            let seconds = self % 60
            let minutes = (self - seconds)/60

            return (0, minutes, seconds)
        default:
            let seconds = self % 60
            let allMinutes = (self - seconds)/60
            let restMinutes = allMinutes % 60
            let allHours = (allMinutes - restMinutes)/60

            return (allHours, restMinutes, seconds)
        }
    }

    func withSymbolOrNil(_ symbol: String) -> String? {
        self > 0 ? "\(self)" + symbol : nil
    }
}
