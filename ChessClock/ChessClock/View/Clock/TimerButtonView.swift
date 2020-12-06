import SwiftUI

struct TimerButtonView: View {
    @ObservedObject var manager: StopWatchManager
    
    var body: some View {
        switch manager.state {
            case .stopped:
                HStack {
                    TimerButton(text: "Start", action: manager.start, color: Color(.systemGreen))
                }
            case .running:
                HStack {
                    TimerButton(text: "Stop", action:   manager.stop, color: Color(.systemRed))
                    TimerButton(text: "Pause", action:  manager.pause, color: Color(.systemYellow))
                }
            case .paused:
                HStack {
                    TimerButton(text: "Stop", action:   manager.stop, color: Color(.systemRed))
                    TimerButton(text: "Resume", action:     manager.start, color: Color(.systemGreen))
                }
        }
    }
}

struct TimerButtonView_Previews: PreviewProvider {
    static var previews: some View {
        TimerButtonView(manager: StopWatchManager())
    }
}
