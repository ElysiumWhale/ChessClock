import SwiftUI
import SFSafeSymbols

struct ChessClockView: View {
    @State
    private var stopwatchManager = StopWatchManager()

    var body: some View {
        TabView {
            ClockView(manager: stopwatchManager)
             .tabItem {
                Image(systemSymbol: .deskclock)
                Text("Clock")
              }
            StatisticView()
              .tabItem {
                  Image(systemSymbol: .bolt)
                 Text("Stats")
               }
            SettingsView()
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
