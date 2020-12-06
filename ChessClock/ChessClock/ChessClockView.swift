import SwiftUI

struct ChessClockView: View {
    var body: some View {
        TabView {
            ClockView()
             .tabItem {
                Image(systemName: "deskclock")
                Text("Clock")
              }
            StatisticView()
              .tabItem {
                 Image(systemName: "bolt")
                 Text("Stats")
               }
            MapView()
            .tabItem {
                Image(systemName: "map")
                Text("Map")
            }
            SettingsView()
            .tabItem {
                Image(systemName: "gear")
                Text("Settings")
            }
        }
        .accentColor(.black)
    }
}

struct ChessClockView_Previews: PreviewProvider {
    static var previews: some View {
        ChessClockView()
    }
}
