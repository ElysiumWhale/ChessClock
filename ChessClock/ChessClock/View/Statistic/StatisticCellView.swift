import SwiftUI

struct StatisticCellView: View {
    @ObservedObject
    var model: TimeCountingModel

    @ObservedObject
    var settingsManager: SettingsManager

    var body: some View {
        VStack(alignment: .leading) {
            Text(model.startDate.string(with: .display))
                .font(.headline)
            ForEach(model.intervals) { interval in
                HStack {
                    Text(interval.timeType.rawValue)
                        .fontWeight(.semibold)
                        .foregroundColor(
                            interval.timeType == .work
                                ? settingsManager.workColor
                                : settingsManager.restColor
                        )
                    Text("\(interval.hours):\(interval.minutes):\(interval.seconds)")
                }
            }
        }
    }
}
