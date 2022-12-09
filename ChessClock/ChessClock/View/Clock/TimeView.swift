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
        .background {
            Color(.black)
                .opacity(0.4)
                .cornerRadius(15)
                .padding(-10)
        }
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
    func timeStyle() -> Text {
        if #available(iOS 15.0, *) {
            return font(.system(.largeTitle, design: .rounded))
                .fontWeight(.bold)
                .monospacedDigit()
        } else {
            return font(.system(.largeTitle, design: .rounded))
                .fontWeight(.bold)
        }
    }
}
