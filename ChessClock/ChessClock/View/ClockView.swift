import SwiftUI

struct ClockView: View {
    @ObservedObject var manager: StopWatchManager = StopWatchManager()
    
    var body: some View {
        ZStack {
            VStack {
                WorkTimeView(timeStamp: manager.workTime)
                    .ignoresSafeArea()
                    .gesture(TapGesture().onEnded { manager.switchTimer(sender: .work) })
                Spacer(minLength: 0)
                RestTimeView(timeStamp: manager.restTime)
                    .gesture(TapGesture().onEnded { manager.switchTimer(sender: .rest) })
            }
            TimerButtonView(manager: manager)
        }
    }
}

struct ClockView_Previews: PreviewProvider {
    static var previews: some View {
        ClockView()
    }
}

struct TimerButtonView: View {
    @ObservedObject var manager: StopWatchManager
    
    var body: some View {
        switch manager.state {
            case .stopped:
                HStack {
                    TimerButton(text: "Start", action: manager.start, color: Color(.cyan))
                }
            case .running:
                HStack {
                    TimerButton(text: "Stop", action:   manager.stop, color: Color(.red))
                    TimerButton(text: "Pause", action:  manager.pause, color: Color(.green))
                }
            case .paused:
                HStack {
                    TimerButton(text: "Resume", action:     manager.start, color: Color(.systemPink))
                    TimerButton(text: "Stop", action:   manager.stop, color: Color(.red))
                }
        }
    }
}

struct WorkTimeView: View {
    @ObservedObject var timeStamp: TimeStamp
    var color: Color = SettingsManager.shared.workColor
    
    var body: some View {
        ZStack {
            color
            VStack(alignment:.center) {
                HStack {
                    Spacer()
                    Text(String("\(timeStamp.hours) :")).font(.largeTitle)
                    Text(String("\(timeStamp.minutes) :")).font(.largeTitle)
                    Text(String("\(timeStamp.seconds)")).font(.largeTitle)
                    Spacer()
                }
            }
        }
    }
}

struct RestTimeView: View {
    @ObservedObject var timeStamp: TimeStamp
    var color: Color = SettingsManager.shared.restColor
    
    var body: some View {
        ZStack {
            color
            VStack(alignment:.center) {
                HStack {
                    Spacer()
                    Text(String("\(timeStamp.hours) :")).font(.largeTitle)
                    Text(String("\(timeStamp.minutes) :")).font(.largeTitle)
                    Text(String("\(timeStamp.seconds)")).font(.largeTitle)
                    Spacer()
                }
            }
        }
    }
}
