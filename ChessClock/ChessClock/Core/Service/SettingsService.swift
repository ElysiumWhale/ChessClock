import SwiftUI

protocol ISettingsService: ObservableObject {
    var workColor: Color { get set }
    var restColor: Color { get set }
}

final class SettingsService: ObservableObject, ISettingsService {
    public static let shared = SettingsService()

    private let defaults: UserDefaults

    @Published
    var workColor: Color = Color(.systemPurple)
    @Published
    var restColor: Color = Color(.systemTeal)

    private init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }
}
