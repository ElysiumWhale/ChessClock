import SwiftUI

struct ClockView: View {
    @ObservedObject var manager: StopWatchManager = StopWatchManager()
    
    var body: some View {
        ZStack {
            VStack {
                WorkTimeView(manager: manager).ignoresSafeArea()
                    .gesture(TapGesture().onEnded { manager.switchTimer() })
                Spacer(minLength: 0)
                RestTimeView(manager: manager)
                    .gesture(TapGesture().onEnded { manager.switchTimer() })
            }
            if manager.mode == .stopped {
                TimerButton(text: "Start", action: manager.start, color: Color(.cyan))
            }
            if manager.mode == .running {
                TimerButton(text: "Stop", action: manager.stop, color: Color(.red))
            }
        }
    }
}

struct ClockView_Previews: PreviewProvider {
    static var previews: some View {
        ClockView()
    }
}

struct WorkTimeView: View {
    @ObservedObject var manager: StopWatchManager
    var color: Color = SettingsManager.shared.workColor
    
    var body: some View {
        ZStack {
            color
            VStack(alignment:.center) {
                Text(String(format: "%.1f", manager.workSeconds)).font(.largeTitle)
            }
        }
    }
}

struct RestTimeView: View {
    @ObservedObject var manager: StopWatchManager
    var color: Color = SettingsManager.shared.restColor
    
    var body: some View {
        ZStack {
            color
            VStack(alignment:.center) {
                Text(String(format: "%.1f", manager.restSeconds)).font(.largeTitle)
            }
        }
    }
}
