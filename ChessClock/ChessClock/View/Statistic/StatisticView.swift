import SwiftUI

struct StatisticView: View {
    @ObservedObject
    private var manager: StopwatchService

    @ObservedObject
    private var settingsManager: SettingsManager

    var body: some View {
        NavigationView {
            List {
                ForEach(manager.models) { model in
                    StatisticCellView(
                        model: model,
                        settingsManager: settingsManager
                    )
                }
            }
            .navigationTitle("Stats")
        }
    }

    init(manager: StopwatchService, settingsManager: SettingsManager) {
        self.manager = manager
        self.settingsManager = settingsManager
    }
}

struct StatisticView_Previews: PreviewProvider {
    static let manager: StopwatchService = {
        let manager = StopwatchService()

        manager.models.append(.init(intervals: [
            .init(timeType: .rest, minutes: 1),
            .init(timeType: .work, seconds: 20),
            .init(timeType: .rest, seconds: 38)
        ]))

        manager.models.append(.init(intervals: [
            .init(timeType: .rest, minutes: 11),
            .init(timeType: .work, seconds: 22),
            .init(timeType: .rest, seconds: 33)
        ]))

        return manager
    }()

    static var previews: some View {
        StatisticView(manager: manager,
                      settingsManager: .shared)
    }
}
