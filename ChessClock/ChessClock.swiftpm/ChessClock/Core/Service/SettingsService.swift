import SwiftUI

protocol ISettingsService: ObservableObject {
    var workColor: Color { get set }
    var restColor: Color { get set }
}

final class SettingsService: ObservableObject, ISettingsService {

    enum SettingKeys: String {
        case workColor = "Settings.WorkColor"
        case restColor = "Settings.RestColor"
    }

    private let settingsStorage: any IStorage<SettingKeys>

    @Published
    var workColor: Color {
        didSet {
            settingsStorage.save(workColor, key: .workColor)
        }
    }

    @Published
    var restColor: Color {
        didSet {
            settingsStorage.save(restColor, key: .restColor)
        }
    }

    init(settingsStorage: any IStorage<SettingKeys> = DefaultsStorage<SettingKeys>()) {
        self.settingsStorage = settingsStorage

        workColor = settingsStorage.retrieve(
            key: .workColor
        ) ?? Color(.systemPurple)
        restColor = settingsStorage.retrieve(
            key: .restColor
        ) ?? Color(.systemTeal)
    }
}
