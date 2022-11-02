import SwiftUI

struct ClockView<TStopwatch: IStopwatchService, TSettings: ISettingsService>: View {
    @ObservedObject
    private var manager: TStopwatch

    @ObservedObject
    private var settingsService: TSettings

    var body: some View {
        ZStack {
            VStack(spacing: .zero) {
                settingsService.workColor
                    .ignoresSafeArea(edges: .top)
                settingsService.restColor
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

    init(
        manager: TStopwatch,
        settingsService: TSettings
    ) {
        self.manager = manager
        self.settingsService = settingsService
    }
}

struct ClockView_Previews: PreviewProvider {
    static var previews: some View {
        ClockView(
            manager: StopwatchService(),
            settingsService: SettingsService.shared
        )
    }
}
