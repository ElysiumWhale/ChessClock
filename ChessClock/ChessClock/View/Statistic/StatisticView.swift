import SwiftUI

struct StatisticView: View {
    @ObservedObject
    private var manager: StopWatchManager

    @ObservedObject
    private var settingsManager: SettingsManager

    var body: some View {
        NavigationView {
            List {
                ForEach(manager.timeTries) { timeTry in
                    VStack(alignment: .leading) {
                        Text(timeTry.startDate.string(with: .display))
                            .font(.headline)
                        ForEach(timeTry.intervals) { interval in
                            HStack {
                                Text(interval.type.rawValue)
                                    .fontWeight(.semibold)
                                    .foregroundColor(interval.type == .work
                                                     ? settingsManager.workColor
                                                     : settingsManager.restColor)
                                Text("\(interval.hours):\(interval.minutes):\(interval.seconds)")
                            }
                        }
                    }
                }
            }
            .navigationTitle("Stats")
        }
    }

    init(manager: StopWatchManager, settingsManager: SettingsManager) {
        self.manager = manager
        self.settingsManager = settingsManager
    }
}

struct StatisticView_Previews: PreviewProvider {
    static let manager: StopWatchManager = {
        let manager = StopWatchManager()
        manager.timeTries.append(contentsOf: [
            TimeTry(id: .init(), intervals: [
                .init(timeType: .rest, minutes: 1),
                .init(timeType: .work, seconds: 20),
                .init(timeType: .rest, seconds: 38)
            ]),
            TimeTry(id: .init(), intervals: [
                .init(timeType: .rest, minutes: 11),
                .init(timeType: .work, seconds: 22),
                .init(timeType: .rest, seconds: 33)
            ])
        ])
        return manager
    }()

    static var previews: some View {
        StatisticView(manager: manager,
                      settingsManager: .shared)
    }
}
