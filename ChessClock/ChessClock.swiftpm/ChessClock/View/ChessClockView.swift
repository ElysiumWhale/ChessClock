import SwiftUI

struct ChessClockView<Dependency: IChessClockDependency>: View {
    @ObservedObject
    private var dependency: Dependency

    var body: some View {
        TabView {
            ClockView(
                manager: dependency.stopwatchService,
                settingsService: dependency.settingsService
            )
            .tabItem {
                Image(systemName: "clock")
                Text("Clock")
            }

            StatisticView(
                dataSource: dependency.dataSource,
                settingsService: dependency.settingsService
            )
            .tabItem {
                Image(systemName: "bolt")
                Text("Stats")
            }

            SettingsView(
                settingsService: dependency.settingsService
            )
            .tabItem {
                Image(systemName: "gear")
                Text("Settings")
            }
        }
        .tint(.indigo)
    }

    init(dependency: Dependency) {
        self.dependency = dependency
    }
}

struct ChessClockView_Previews: PreviewProvider {
    static var previews: some View {
        ChessClockView(dependency: ChessClockDependency.makeDefault())
    }
}
