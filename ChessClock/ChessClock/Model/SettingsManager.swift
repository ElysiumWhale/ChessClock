import Foundation
import SwiftUI

public class SettingsManager : ObservableObject {
    @Published var workColor: Color = Color(.purple)
    @Published var restColor: Color = Color(.green)
    
    private init() {
        //TODO get settings from memory
    }
    
    public static var shared: SettingsManager = SettingsManager()
    
    func saveSettings() {
        
    }
    
    func restoreDefaults() {
        
    }
}
