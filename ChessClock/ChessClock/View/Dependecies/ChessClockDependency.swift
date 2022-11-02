import Foundation

protocol IChessClockDependency: ObservableObject {
    associatedtype TStopwatch: IStopwatchService
    associatedtype TSettings: ISettingsService

    var stopwatchService: TStopwatch { get }
    var settingsService: TSettings { get }
}

final class ChessClockDependency: IChessClockDependency {
    @Published
    var stopwatchService: StopwatchService

    @Published
    var settingsService: SettingsService

    init(stopwatchService: StopwatchService, settingsService: SettingsService) {
        self.stopwatchService = stopwatchService
        self.settingsService = settingsService
    }
}
