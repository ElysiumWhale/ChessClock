import SwiftUI

enum StopWatchState {
    case running
    case stopped
    case paused
}

enum TimerActive {
    case none
    case rest
    case work
}

class StopWatchManager : ObservableObject {
    
    @Published var restTime: TimeStamp = TimeStamp(timeType: .rest)
    @Published var workTime: TimeStamp = TimeStamp(timeType: .work)
    
    @Published var state: StopWatchState = .stopped
    @Published var timerActive: TimerActive = .none
    
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
                //currentTry = TimeTry()
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
        timerActive = .none
        
        workTimer.invalidate()
        restTimer.invalidate()
        
        //currentTry!.intervals.append(<#T##newElement: TimeStamp##TimeStamp#>)
        //timeTries.append(currentTry!)
        restTime = .init(timeType: .rest)
        workTime = .init(timeType: .work)
        currentTry = nil
    }
    
    func switchTimer(sender: TimerActive) {
        switch state {
            case .stopped: return
            case .running: guard !(sender == timerActive) else { return }
                           fallthrough
            case .paused:
                if sender == .rest {
                    if state == .paused { state = .running }
                    //TODO: intervals append
                    workTimer.invalidate()
                    restTimer = setupTimer(.rest)
                    timerActive = .rest
                } else if sender == .work {
                    if state == .paused { state = .running }
                    //TODO: intervals append
                    restTimer.invalidate()
                    workTimer = setupTimer(.work)
                    timerActive = .work
                }
        }
    }
    
    func setupTimer(_ timeType: timeType) -> Timer {
        switch timeType {
            case .rest:
                return Timer.scheduledTimer(withTimeInterval: 1, repeats: true)
                { [self] timer in
                    if restTime.seconds == 59 {
                        restTime.minutes += 1
                        restTime.seconds = 0
                    } else { restTime.seconds += 1 }
                }
            case .work:
                return Timer.scheduledTimer(withTimeInterval: 1, repeats: true)
                { [self] timer in
                    if workTime.seconds == 59 {
                        workTime.minutes += 1
                        workTime.seconds = 0
                    } else { workTime.seconds += 1 }
                }
        }
    }
}
