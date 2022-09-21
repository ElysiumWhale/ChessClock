import SwiftUI

struct ClockView: View {
    @ObservedObject
    private var manager: StopWatchManager

    @ObservedObject
    private var settingsManager: SettingsManager

    var body: some View {
        ZStack {
            settingsManager.restColor
                .ignoresSafeArea(edges: .top)
            VStack {
                TimeView(timeStamp: manager.workTime)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .onTapGesture {
                        manager.switchTimer(sender: .work)
                    }
                TimerButtonView(manager: manager)
                TimeView(timeStamp: manager.restTime)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .onTapGesture {
                        manager.switchTimer(sender: .rest)
                    }
            }
        }
    }

    init(manager: StopWatchManager, settingsManager: SettingsManager) {
        self.manager = manager
        self.settingsManager = settingsManager
    }
}

struct ClockView_Previews: PreviewProvider {
    static var previews: some View {
        ClockView(manager: .init(), settingsManager: .shared)
    }
}
