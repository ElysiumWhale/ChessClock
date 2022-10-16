import SwiftUI

struct TimerButtonView: View {
    @ObservedObject var manager: StopWatchManager

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
            }
        }
        .animation(.easeIn, value: !isStopped)
    }
}

struct TimerButtonView_Previews: PreviewProvider {
    static var previews: some View {
        TimerButtonView(manager: StopWatchManager())
    }
}
