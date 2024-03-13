import SwiftUI

struct TimeView: View {
    @ObservedObject
    var counter: TimeCounter

    var body: some View {
        HStack {
            if counter.hours > 0 {
                Text("\(counter.hours)h")
                    .timeStyle()
            }
            if counter.hours > 0 || counter.minutes > 0 {
                Text("\(counter.minutes)m")
                    .timeStyle()
            }
            Text("\(counter.seconds)s")
                .timeStyle()
        }
        .foregroundColor(.white)
        .padding(10)
        .background(
            .secondary,
            in: RoundedRectangle(cornerRadius: 15)
        )
        .animation(.bouncy, value: counter.currentTime)
    }
}

struct TimeView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 50) {
            TimeView(counter: .withTime(5555))
            TimeView(counter: .withTime(555))
            TimeView(counter: .withTime(55))
        }
    }
}

extension Text {
    func timeStyle() -> some View {
        font(.system(.largeTitle, design: .rounded))
            .fontWeight(.bold)
            .monospacedDigit()
    }
}
