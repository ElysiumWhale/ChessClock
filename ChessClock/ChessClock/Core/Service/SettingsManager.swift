import SwiftUI

final class SettingsManager: ObservableObject {
    public static let shared = SettingsManager()

    private let defaults: UserDefaults

    @Published
    var workColor: Color = Color(.systemPurple)
    @Published
    var restColor: Color = Color(.systemTeal)

    private init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }
}
