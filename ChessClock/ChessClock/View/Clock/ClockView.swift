import SwiftUI

struct ClockView: View {
    @ObservedObject
    private var settingsManager: SettingsManager = .shared

    @ObservedObject
    var manager: StopWatchManager

    var body: some View {
        ZStack {
            settingsManager.restColor
                .ignoresSafeArea(edges: .top)
            VStack {
                TimeView(timeStamp: manager.workTime)
                    .gesture(TapGesture().onEnded {
                        manager.switchTimer(sender: .work)
                    })
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                TimerButtonView(manager: manager)
                TimeView(timeStamp: manager.restTime)
                    .gesture(TapGesture().onEnded {
                        manager.switchTimer(sender: .rest)
                    })
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}

struct ClockView_Previews: PreviewProvider {
    static var previews: some View {
        ClockView(manager: .init())
    }
}
