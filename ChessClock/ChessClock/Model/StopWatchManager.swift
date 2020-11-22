import SwiftUI

enum stopWatchState {
    case running
    case stopped
    case paused
}

enum timerActive {
    case none
    case rest
    case work
}

class StopWatchManager : ObservableObject {
    
    @Published var restTime: TimeStamp = TimeStamp(timeType: .rest)
    @Published var workTime: TimeStamp = TimeStamp(timeType: .work)
    
    @Published var state: stopWatchState = .stopped
    @Published var timerActive: timerActive = .none
    
    var timeTries: [TimeTry] = [TimeTry]()
    var currentTry: TimeTry?
    
    var workTimer = Timer()
    var restTimer = Timer()
    
    func start() {
        state = .running
        switch timerActive {
            case .none:
                timerActive = .work
                workTimer = setupTimer(.work)
                currentTry = TimeTry()
            case .rest:
                restTimer = setupTimer(.rest)
            case .work:
                workTimer = setupTimer(.work)
        }
    }
    
    func pause() {
        state = .paused
        workTimer.invalidate()
        restTimer.invalidate()
    }
    
    func stop() {
        state = .stopped
        workTimer.invalidate()
        restTimer.invalidate()
        //currentTry!.intervals.append(<#T##newElement: TimeStamp##TimeStamp#>)
        timeTries.append(currentTry!)
        currentTry = nil
    }
    
    func switchTimer() {
        
    }
    
    func setupTimer(_ timeType: timeType) -> Timer {
        switch timeType {
            case .rest:
                return Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true)
                { [self] timer in
                    if restTime.seconds == 59.9 {
                        
                    } else { restTime.seconds += 0.1 }
                }
            case .work:
                return Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true)
                { [self] timer in
                    if workTime.seconds == 59.9 {
                        
                    } else { workTime.seconds += 0.1 }
                }
        }
    }
}
