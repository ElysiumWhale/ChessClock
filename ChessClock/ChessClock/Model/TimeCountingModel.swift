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
        switch intervals.last?.timeType {
        case .work:
            guard restTime.difference > 0 else {
                return
            }

            intervals.append(
                .init(timeType: .rest,
                      onlySeconds: restTime.difference)
            )
            restTime.cutStamp()
        case .rest, .none:
            guard workTime.difference > 0 else {
                return
            }

            intervals.append(
                .init(timeType: .work,
                      onlySeconds: workTime.difference)
            )
            workTime.cutStamp()
        }
    }
}
