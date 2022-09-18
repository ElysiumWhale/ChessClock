import Foundation
import SwiftUI

public class SettingsManager: ObservableObject {
    public static let shared = SettingsManager()

    private let defaults = UserDefaults.standard

    @Published var workColor: Color = Color(.systemPurple)
    @Published var restColor: Color = Color(.systemTeal)

    private init() { }
}
