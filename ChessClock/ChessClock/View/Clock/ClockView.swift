import SwiftUI

struct ClockView: View {
    @ObservedObject
    private var manager: StopwatchService

    @ObservedObject
    private var settingsManager: SettingsService

    var body: some View {
        ZStack {
            VStack(spacing: .zero) {
                settingsManager.restColor
                    .ignoresSafeArea(edges: .top)
                settingsManager.workColor
            }
            VStack {
                TimeView(counter: manager.countingModel.workTime)
                    .scaleEffect(
                        manager.timerActive == .work ? 1.3 : 1,
                        anchor: .center
                    )
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .contentShape(Rectangle())
                    .animation(.easeInOut, value: manager.timerActive == .work)
                    .onTapGesture {
                        manager.switchTimer(to: .work)
                    }
                TimerButtonView(manager: manager)
                TimeView(counter: manager.countingModel.restTime)
                    .scaleEffect(
                        manager.timerActive == .rest ? 1.3 : 1,
                        anchor: .center
                    )
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .contentShape(Rectangle())
                    .animation(.easeInOut, value: manager.timerActive == .rest)
                    .onTapGesture {
                        manager.switchTimer(to: .rest)
                    }
            }
        }
    }

    init(manager: StopwatchService, settingsManager: SettingsService) {
        self.manager = manager
        self.settingsManager = settingsManager
    }
}

struct ClockView_Previews: PreviewProvider {
    static var previews: some View {
        ClockView(manager: .init(), settingsManager: .shared)
    }
}
