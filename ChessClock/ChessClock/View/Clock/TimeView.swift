import SwiftUI

struct TimeView: View {
    @ObservedObject
    var counter: TimeCounter

    var body: some View {
        HStack {
            Text("\(counter.hours) :")
                .timeStyle()
            Text("\(counter.minutes) :")
                .timeStyle()
            Text("\(counter.seconds)")
                .timeStyle()
        }
    }
}

struct TimeView_Previews: PreviewProvider {
    static var previews: some View {
        TimeView(counter: .init())
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
