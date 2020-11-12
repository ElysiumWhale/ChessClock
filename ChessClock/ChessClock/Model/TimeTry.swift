import Foundation

enum timeType {
    case work
    case rest
}

struct TimeTry {
    let dateTry: Date = Date()
    var intervals: [Interval] = [Interval]()
    
    struct Interval {
        let type: timeType
        let value: Double
    }
}
