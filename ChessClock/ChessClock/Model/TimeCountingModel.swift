import Foundation

final class TimeCountingModel: Identifiable, ObservableObject {
    let id: UUID

    var startDate = Date()

    @Published
    private(set) var intervals = [TimeStamp]()

    @Published
    var workTime = TimeCounter()
    @Published
    var restTime = TimeCounter()

    init(id: UUID = UUID(), intervals: [TimeStamp] = [TimeStamp]()) {
        self.id = id
        self.intervals = intervals
    }

    func cutTimeStamp() {
        let (counter, type) = counter(for: intervals.last)

        guard counter.difference > 0 else {
            return
        }

        intervals.append(
            .init(timeType: type,
                  onlySeconds: counter.difference)
        )
        counter.cutStamp()
    }

    private func counter(
        for interval: TimeStamp?
    ) -> (counter: TimeCounter, type: TimeType) {

        switch interval?.timeType {
        case .work:
            return (restTime, .rest)
        case .rest, .none:
            return (workTime, .work)
        }
    }
}
