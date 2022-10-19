import SwiftUI

struct TimeView: View {
    @ObservedObject
    var counter: TimeCounter

    var body: some View {
        // TODO: Return hours and minutes labels
        HStack {
            // Text("\(counter.currentTime) :")
            //     .timeStyle()
            // Text("\(counter.currentTime) :")
            //     .timeStyle()
            Text("\(counter.currentTime)")
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
        font(.system(.largeTitle, design: .rounded)).fontWeight(.bold)
    }
}
