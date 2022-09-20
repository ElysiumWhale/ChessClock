import Foundation

enum timeType {
    case work
    case rest
}

struct TimeTry {
    let startDate: Date = Date()
    var intervals: [TimeStamp] = [TimeStamp]()
    var endDate: Date?
}

class TimeStamp : ObservableObject {
    var type: timeType
    @Published var seconds = 0
    @Published var minutes = 0
    @Published var hours = 0

    init(timeType: timeType) {
        type = timeType
    }
}
