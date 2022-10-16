import SwiftUI

struct ClockView: View {
    @ObservedObject
    private var manager: StopwatchService

    @ObservedObject
    private var settingsManager: SettingsManager

    var body: some View {
        ZStack {
            settingsManager.restColor
                .ignoresSafeArea(edges: .top)
            VStack {
                TimeView(counter: manager.countingModel.workTime)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .onTapGesture {
                        manager.switchTimer(to: .work)
                    }
                TimerButtonView(manager: manager)
                TimeView(counter: manager.countingModel.restTime)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .onTapGesture {
                        manager.switchTimer(to: .rest)
                    }
            }
        }
    }

    init(manager: StopwatchService, settingsManager: SettingsManager) {
        self.manager = manager
        self.settingsManager = settingsManager
    }
}

struct ClockView_Previews: PreviewProvider {
    static var previews: some View {
        ClockView(manager: .init(), settingsManager: .shared)
    }
}
