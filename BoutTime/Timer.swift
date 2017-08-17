//
//  Timer.swift
//  BoutTime
//
//  Created by James Mulholland on 17/08/2017.
//  Copyright © 2017 JamesMulholland. All rights reserved.
//

import Foundation


class TimerProvider {
    
    var timer = Timer()
    var timerLength = 60.0
    
    func updateTimer() -> String {
        // Updates the timer and returns a string of time remaining
        if timerLength < 0.01 {
            timer.invalidate()
        } else {
            timerLength -= 0.01
        }
        return String(format: "%.1f", timerLength)
    }
    
    func resetTimer() {
        timer = Timer()
        timerLength = 60.0
    }
}
