import SwiftUI

struct SettingsView<TSettings: ISettingsService>: View {
    @ObservedObject
    private var settingsService: TSettings

    var body: some View {
        NavigationView {
            List {
                ColorPicker("Rest clock color",
                            selection: $settingsService.restColor)
                ColorPicker("Work clock color",
                            selection: $settingsService.workColor)
            }
            .navigationTitle("Settings")
        }
    }

    init(settingsService: TSettings) {
        self.settingsService = settingsService
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(settingsService: SettingsService.shared)
    }
}
