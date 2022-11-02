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

protocol IStopwatchService: ObservableObject {
    var countingModel: TimeCountingModel { get }
    var timerActive: TimerType { get }
    var state: StopWatchState { get }
    var models: [TimeCountingModel] { get }

    func start()
    func stop()
    func pause()
    func switchTimer(to timer: TimerType)
}

final class StopwatchService: ObservableObject, IStopwatchService {
    private var clockTimer: Timer?

    @Published
    private(set) var countingModel = TimeCountingModel()

    @Published
    var state: StopWatchState = .stopped
    @Published
    var timerActive: TimerType = .none
    @Published
    var models = [TimeCountingModel]()

    func start() {
        state = .running
        switch timerActive {
        case .none:
            countingModel.startDate = Date()
            configureTimer(for: .work)
            timerActive = .work
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
        if hasStarted {
            countingModel.cutTimeStamp()
            models.append(countingModel)
        }
        countingModel = .init()
    }

    func switchTimer(to timer: TimerType) {
        guard state == .running,
              timer != timerActive,
              timer != .none,
              hasStarted else {
            return
        }

        clockTimer?.invalidate()
        countingModel.cutTimeStamp()
        configureTimer(for: timer)
        timerActive = timer
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

private extension StopwatchService {
    var hasStarted: Bool {
        countingModel.workTime.currentTime > 0
        || countingModel.restTime.currentTime > 0
    }
}
