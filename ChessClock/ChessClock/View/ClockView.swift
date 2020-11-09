import SwiftUI

struct ClockView: View {
    var manager: StopWatchManager = StopWatchManager()
    
    var body: some View {
        ZStack {
            VStack {
                WorkTimeView(manager: manager).ignoresSafeArea()
                Spacer(minLength: 0)
                RestTimeView(manager: manager)
            }
            TimerButton(text: "Start", action: manager.start)
        }
    }
}

struct ClockView_Previews: PreviewProvider {
    static var previews: some View {
        ClockView()
    }
}

struct WorkTimeView: View {
    //var time: String = "00:00:00"
    var manager: StopWatchManager
    
    var body: some View {
        ZStack {
            Color.purple
            VStack(alignment:.center) {
                Text(String(format: "%.1f", manager.secondsElapsed)).font(.largeTitle)
            }
        }
    }
}

struct RestTimeView: View {
    //var time: String = "00:00:00"
    var manager: StopWatchManager
    
    var body: some View {
        ZStack {
            Color.green
            VStack(alignment:.center) {
                Text(String(format: "%.1f", manager.secondsElapsed)).font(.largeTitle)
            }
        }
    }
}
