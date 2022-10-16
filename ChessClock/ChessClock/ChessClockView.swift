import SwiftUI
import SFSafeSymbols

struct ChessClockView: View {
    @State
    private var stopwatchManager = StopwatchService()

    @State
    private var settingsManager: SettingsManager = .shared

    var body: some View {
        TabView {
            ClockView(manager: stopwatchManager,
                      settingsManager: settingsManager)
                .tabItem {
                    Image(systemSymbol: .clock)
                    Text("Clock")
                }
            StatisticView(manager: stopwatchManager,
                          settingsManager: settingsManager)
                .tabItem {
                    Image(systemSymbol: .bolt)
                    Text("Stats")
                }
            SettingsView(settingsManager: settingsManager)
                .tabItem {
                    Image(systemSymbol: .gear)
                    Text("Settings")
                }
        }
        .accentColor(.accentColor)
    }
}

struct ChessClockView_Previews: PreviewProvider {
    static var previews: some View {
        ChessClockView()
    }
}
