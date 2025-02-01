import Foundation

protocol IChessClockDependency: ObservableObject {
    associatedtype TStopwatch: IStopwatchService
    associatedtype TSettings: ISettingsService
    associatedtype TDataSource: IDataSource

    var stopwatchService: TStopwatch { get }
    var settingsService: TSettings { get }
    var dataSource: TDataSource { get }
}

final class ChessClockDependency: IChessClockDependency {
    @Published
    var stopwatchService: StopwatchService

    @Published
    var settingsService: SettingsService

    @Published
    var dataSource: DataSource

    init(
        stopwatchService: StopwatchService,
        settingsService: SettingsService,
        dataStore: DataSource
    ) {
        self.stopwatchService = stopwatchService
        self.settingsService = settingsService
        self.dataSource = dataStore
    }
}

// MARK: - Default
extension ChessClockDependency {
    static func makeDefault() -> ChessClockDependency {
        let dataSource = DataSource()
        let stopwatchService = StopwatchService()
        stopwatchService.delegate = dataSource

        return ChessClockDependency(
            stopwatchService: stopwatchService,
            settingsService: SettingsService(),
            dataStore: dataSource
        )
    }
}
