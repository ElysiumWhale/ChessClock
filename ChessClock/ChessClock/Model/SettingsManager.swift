import Foundation
import SwiftUI

extension Text {
    func timeStyle() -> Text {
        return self.font(.system(.largeTitle, design: .rounded))
            .fontWeight(.bold)
    }
}

public class SettingsManager : ObservableObject {
    @Published var workColor: Color = Color(.systemPurple)
    @Published var restColor: Color = Color(.systemTeal)
    
    private init() {
        //TODO get settings from memory
    }
    
    public static var shared: SettingsManager = SettingsManager()
    
    func saveSettings() {
        
    }
    
    func restoreDefaults() {
        
    }
}
