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

    func start()
    func stop()
    func pause()
    func switchTimer(to timer: TimerType)
}

protocol IStopwatchDelegate: AnyObject {
    func didFinishCountingModel(_ model: TimeCountingModel)
}

final class StopwatchService: ObservableObject, IStopwatchService {
    private var clockTimer: Timer?
    private var suspendDate: Date?

    @Published
    private(set) var countingModel = TimeCountingModel()

    weak var delegate: IStopwatchDelegate?

    @Published
    var state: StopWatchState = .stopped
    @Published
    var timerActive: TimerType = .none

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
            delegate?.didFinishCountingModel(countingModel)
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

// MARK: - Background work
extension StopwatchService {
    func suspend() {
        pause()
        suspendDate = Date()
    }

    func revive() {
        guard let suspendDate, timerActive != .none else {
            return
        }

        self.suspendDate = nil
        let elapsedTime = Date().timeIntervalSince(suspendDate)
        start()
        switch timerActive {
        case .rest:
            countingModel.restTime.currentTime += UInt(elapsedTime)
        case .work:
            countingModel.workTime.currentTime += UInt(elapsedTime)
        case .none:
            break
        }
    }
}
