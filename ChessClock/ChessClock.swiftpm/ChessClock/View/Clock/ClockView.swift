import SwiftUI

struct ClockView<TStopwatch: IStopwatchService, TSettings: ISettingsService>: View {
    @ObservedObject
    private var manager: TStopwatch

    @ObservedObject
    private var settingsService: TSettings

    var body: some View {
        VStack(spacing: .zero) {
            settingsService.workColor
                .ignoresSafeArea(edges: .top)
                .onTapGesture {
                    manager.switchTimer(to: .work)
                }
            settingsService.restColor
                .onTapGesture {
                    manager.switchTimer(to: .rest)
                }
        }
        .overlay {
            VStack {
                TimeView(counter: manager.countingModel.workTime)
                    .frame(maxHeight: .infinity)
                    .allowsHitTesting(false)
                    .scaleEffect(
                        manager.timerActive == .work ? 1.3 : 1,
                        anchor: .center
                    )
                    .animation(.bouncy, value: manager.timerActive == .work)
                TimerButtonView(manager: manager)
                TimeView(counter: manager.countingModel.restTime)
                    .frame(maxHeight: .infinity)
                    .allowsHitTesting(false)
                    .scaleEffect(
                        manager.timerActive == .rest ? 1.3 : 1,
                        anchor: .center
                    )
                    .animation(.bouncy, value: manager.timerActive == .rest)
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
            settingsService: SettingsService()
        )
    }
}
