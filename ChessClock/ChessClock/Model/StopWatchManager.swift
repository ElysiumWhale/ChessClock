import SwiftUI

enum stopWatchMode {
    case running
    case stopped
    case paused
}

class StopWatchManager : ObservableObject {
    
    @Published var restSeconds = 0.0
    @Published var workSeconds = 0.0
    @Published var mode: stopWatchMode = .stopped
    
    var timeTries: [TimeTry] = [TimeTry]()
    var currentTry: TimeTry?
    
    var workTimer = Timer()
    var restTImer = Timer()
    
    func start() {
        mode = .running
        workTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true)
        { timer in
            self.workSeconds += 0.1
        }
        //currentTry = TimeTry()
    }
    
    func stop() {
        workTimer.invalidate()
        currentTry?.intervals.append(.init(type: .work, value: workSeconds))
        mode = .stopped
    }
    
    func switchTimer() {
        //TODO
    }
}
