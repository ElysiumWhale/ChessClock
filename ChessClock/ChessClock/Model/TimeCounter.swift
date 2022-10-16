import Foundation
import SwiftUI

final class TimeCounter: ObservableObject {
    private var lastCutTime: UInt = 0

    @Published
    var currentTime: UInt = 0

    var difference: UInt {
        currentTime - lastCutTime
    }

    func cutStamp() {
        lastCutTime = lastCutTime < currentTime
            ? currentTime
            : 0
    }
}
