import SwiftUI

@main
struct ChessClockApp: App {
    @Environment(\.scenePhase) private var scenePhase

    private let mainDependency = ChessClockDependency(
        stopwatchService: StopwatchService(),
        settingsService: SettingsService()
    )

    var body: some Scene {
        WindowGroup {
            ChessClockView(dependency: mainDependency)
        }
        .onChange(of: scenePhase) { newScenePhase in
            switch newScenePhase {
            case .active:
                mainDependency.stopwatchService.revive()
            case .background:
                mainDependency.stopwatchService.suspend()
            case .inactive:
                break
            @unknown default:
                break
            }
        }
    }
}
