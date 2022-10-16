import SwiftUI

enum StopWatchState {
    case running
    case stopped
    case paused
}

enum TimerType {
    case none
    case rest
    case work
}

final class StopWatchManager: ObservableObject {
    private var clockTimer: Timer?

    @Published
    var state: StopWatchState = .stopped
    @Published
    var timerActive: TimerType = .none
    @Published
    var countingModel = TimeCountingModel()
    @Published
    var models = [TimeCountingModel]()

    func start() {
        state = .running
        switch timerActive {
        case .none:
            countingModel.startDate = Date()
            configureTimer(for: .work)
        case .rest:
            configureTimer(for: .rest)
        case .work:
            configureTimer(for: .work)
        }
    }

    func pause() {
        state = .paused
        clockTimer?.invalidate()
    }

    func stop() {
        state = .stopped
        timerActive = .none
        clockTimer?.invalidate()
        countingModel.cutTimeStamp()
        models.append(countingModel)
        countingModel = .init()
    }

    func switchTimer(to timer: TimerType) {
        guard state != .stopped, timer != timerActive else {
            return
        }

        switch timer {
        case .none:
            return
        case .rest:
            clockTimer?.invalidate()
            countingModel.cutTimeStamp()
            configureTimer(for: .rest)
            timerActive = .rest
        case .work:
            clockTimer?.invalidate()
            countingModel.cutTimeStamp()
            configureTimer(for: .work)
            timerActive = .work
        }
    }

    private func configureTimer(for type: TimerType) {
        guard type != .none else {
            return
        }

        let counter: TimeCounter?
        switch type {
        case .work:
            counter = countingModel.workTime
        case .rest:
            counter = countingModel.restTime
        default:
            return
        }

        clockTimer = .scheduledTimer(
            withTimeInterval: 1, repeats: true
        ) { [weak counter] _ in
            counter?.currentTime += 1
        }
    }
}
