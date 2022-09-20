import SwiftUI

struct SettingsView: View {
    @ObservedObject
    private var settingsManager: SettingsManager

    var body: some View {
        NavigationView {
            List {
                ColorPicker("Rest clock color",
                            selection: $settingsManager.restColor)
                ColorPicker("Work clock color",
                            selection: $settingsManager.workColor)
            }
            .navigationTitle("Settings")
        }
    }

    init(settingsManager: SettingsManager) {
        self.settingsManager = settingsManager
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(settingsManager: .shared)
    }
}
