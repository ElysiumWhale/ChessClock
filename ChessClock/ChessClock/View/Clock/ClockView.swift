import SwiftUI

struct ClockView: View {
    @ObservedObject var manager: StopWatchManager = StopWatchManager()
    
    var body: some View {
        ZStack {
            VStack {
                TimeView(timeStamp: manager.workTime)
                    .ignoresSafeArea()
                    .gesture(TapGesture().onEnded { manager.switchTimer(sender: .work) })
                Spacer(minLength: 0)
                TimeView(timeStamp: manager.restTime)
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

struct TimeView: View {
    @ObservedObject var timeStamp: TimeStamp
    var color: Color = SettingsManager.shared.workColor
    
    var body: some View {
        ZStack {
            color
            VStack(alignment:.center) {
                HStack {
                    Spacer()
                    Text("\(timeStamp.hours) :")
                        .timeStyle()
                    Text("\(timeStamp.minutes) :")
                        .timeStyle()
                    Text("\(timeStamp.seconds)")
                        .timeStyle()
                    Spacer()
                }
            }
        }
    }
}
