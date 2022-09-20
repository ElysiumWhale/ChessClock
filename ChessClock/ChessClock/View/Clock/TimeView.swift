import SwiftUI

struct TimeView: View {
    @ObservedObject var timeStamp: TimeStamp

    var body: some View {
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

struct TimeView_Previews: PreviewProvider {
    static var previews: some View {
        TimeView(timeStamp: .init(timeType: .work))
    }
}

extension Text {
    func timeStyle() -> Text {
        font(.system(.largeTitle, design: .rounded)).fontWeight(.bold)
    }
}
