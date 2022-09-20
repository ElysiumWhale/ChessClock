import SwiftUI
import SFSafeSymbols

struct ChessClockView: View {
    @State
    private var stopwatchManager = StopWatchManager()

    @State
    private var settingsManager: SettingsManager = .shared

    var body: some View {
        TabView {
            StatisticView()
              .tabItem {
                  Image(systemSymbol: .bolt)
                 Text("Stats")
               }
            ClockView(manager: stopwatchManager,
                      settingsManager: settingsManager)
                .tabItem {
                    Image(systemSymbol: .clock)
                    Text("Clock")
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
