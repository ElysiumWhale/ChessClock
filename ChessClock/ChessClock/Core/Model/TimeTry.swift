import Foundation

struct TimeTry: Codable, Identifiable {
    let id: UUID
    let startDate: Date
    let intervals: [TimeStamp]
}
