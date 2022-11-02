import SwiftUI

@main
struct ChessClockApp: App {
    //@UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    private let mainDependency = ChessClockDependency(
        stopwatchService: .init(),
        settingsService: SettingsService.shared
    )

    var body: some Scene {
        WindowGroup {
            ChessClockView(dependency: mainDependency)
        }
    }
}
