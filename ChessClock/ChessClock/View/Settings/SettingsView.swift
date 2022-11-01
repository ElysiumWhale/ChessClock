import SwiftUI

struct SettingsView: View {
    @ObservedObject
    private var settingsManager: SettingsService

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

    init(settingsManager: SettingsService) {
        self.settingsManager = settingsManager
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(settingsManager: .shared)
    }
}
