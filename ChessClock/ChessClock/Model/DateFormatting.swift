import Foundation

extension Date {
    func string(with formatter: DateFormatter) -> String {
        formatter.string(from: self)
    }
}

extension DateFormatter {
    static let display: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = .autoupdatingCurrent
        formatter.dateFormat = "dd.MM.yyyy HH:MM"
        return formatter
    }()
}
