import SwiftUI

struct TimerButtonView<TStopwatch: IStopwatchService>: View {
    @ObservedObject
    var manager: TStopwatch

    var body: some View {
        let isRunning = manager.state == .running
        let isStopped = manager.state == .stopped
        HStack {
            TimerButton(
                text: isStopped ? "Start" : "Stop",
                action: isStopped ? manager.start : manager.stop,
                color: isStopped ? Color(.systemGreen) : Color(.systemRed)
            )
            if !isStopped {
                TimerButton(
                    text: isRunning ? "Pause" : "Resume",
                    action: isRunning ? manager.pause : manager.start,
                    color: isRunning ? Color(.systemYellow) : Color(.systemGreen)
                )
                .transition(.scale)
            }
        }
        .animation(.easeIn, value: [isStopped, isRunning])
    }
}

struct TimerButtonView_Previews: PreviewProvider {
    static var previews: some View {
        TimerButtonView(manager: StopwatchService())
    }
}
