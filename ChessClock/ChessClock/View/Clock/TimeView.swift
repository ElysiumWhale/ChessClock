import SwiftUI

struct TimeView: View {
    @ObservedObject
    var counter: TimeCounter

    var body: some View {
        HStack {
            Spacer()
            // TODO: Return hours and minutes labels
            // Text("\(timeStamp.hours) :")
            //     .timeStyle()
            // Text("\(timeStamp.minutes) :")
            //     .timeStyle()
            Text("\(counter.currentTime)")
                .timeStyle()
            Spacer()
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
        font(.system(.largeTitle, design: .rounded)).fontWeight(.bold)
    }
}
