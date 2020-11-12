import SwiftUI

struct TimerButton: View {
    var text: String = "Start"
    var action: () -> Void = { }
    var color: Color = Color(.lightGray)
    
    var body: some View {
        Button(action: action, label: {
            Text(text)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .multilineTextAlignment(.center)
        })
        .buttonStyle(NeumorphicButtonStyle(bgColor: color))
        .padding([.leading, .trailing], 10)
        .frame(minWidth: 150, maxWidth: 250)
    }
}

struct TimerButton_Previews: PreviewProvider {
    static var previews: some View {
        TimerButton(text: "Start")
    }
}

struct NeumorphicButtonStyle: ButtonStyle {
    var bgColor: Color

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(20)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .shadow(color: .white, radius: configuration.isPressed ? 7: 10, x: configuration.isPressed ? -5: -15, y: configuration.isPressed ? -5: -15)
                        .shadow(color: .black, radius: configuration.isPressed ? 7: 10, x: configuration.isPressed ? 5: 15, y: configuration.isPressed ? 5: 15)
                        .blendMode(.overlay)
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(bgColor)
                }
        )
            .scaleEffect(configuration.isPressed ? 0.95: 1)
            .foregroundColor(.primary)
            .animation(.spring())
    }
}
