import Foundation

enum TimeType: String {
    case work
    case rest
}

struct TimeTry {
    let startDate: Date = Date()
    var intervals: [TimeStamp] = [TimeStamp]()
    var endDate: Date?
}

class TimeStamp: ObservableObject, Identifiable {
    let id: UUID

    var type: TimeType
    @Published var seconds = 0
    @Published var minutes = 0
    @Published var hours = 0

    init(id: UUID = UUID(),
         timeType: TimeType,
         hours: Int = 0,
         minutes: Int = 0,
         seconds: Int = 0) {

        self.id = id
        self.seconds = seconds
        self.minutes = minutes
        self.hours = hours
        type = timeType
    }
}
