import SwiftUI

struct SettingsView: View {
    @ObservedObject
    private var settingsManager: SettingsManager = .shared

    var body: some View {
        HStack {
            Spacer(minLength: 16)
            VStack {
                ColorPicker("Choose rest clock color",
                            selection: $settingsManager.restColor)
                ColorPicker("Choose work clock color",
                            selection: $settingsManager.workColor)
            }
            Spacer(minLength: 16)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
