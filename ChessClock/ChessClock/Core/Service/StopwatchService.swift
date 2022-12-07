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


struct Try: Codable {
    let id: UUID
    let intervals: [TimeStamp]
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

    // TODO: - Separate data source
    func remove(at offsets: IndexSet) 
}

final class StopwatchService: ObservableObject, IStopwatchService {
    enum ModelsKeys: String {
        case savedModels
    }

    private let storage: any IStorage<ModelsKeys>

    private var clockTimer: Timer?
    private var suspendDate: Date?

    @Published
    private(set) var countingModel = TimeCountingModel()

    @Published
    var state: StopWatchState = .stopped
    @Published
    var timerActive: TimerType = .none
    @Published
    var models: [TimeCountingModel]

    init(storage: any IStorage<ModelsKeys> = DefaultsStorage<ModelsKeys>()) {
        self.storage = storage
        let tries: [Try]? = storage.retrieve(key: .savedModels)
        models = tries?.map {
            TimeCountingModel(id: $0.id, intervals: $0.intervals)
        } ?? []
    }

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
            storage.save(
                models.map {
                    Try(id: $0.id, intervals: $0.intervals)
                },
                key: .savedModels
            )
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

    func remove(at offsets: IndexSet) {
        models.remove(atOffsets: offsets)
        let tries = [Try]()
        storage.save(tries, key: .savedModels)
        storage.save(
            models.map {
                Try(id: $0.id, intervals: $0.intervals)
            },
            key: .savedModels
        )
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
