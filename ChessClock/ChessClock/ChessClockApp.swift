import SwiftUI

@main
struct ChessClockApp: App {
    //@UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    private let mainDependency = ChessClockDependency(
        stopwatchService: StopwatchService(),
        settingsService: SettingsService()
    )

    var body: some Scene {
        WindowGroup {
            ChessClockView(dependency: mainDependency)
        }
    }
}
