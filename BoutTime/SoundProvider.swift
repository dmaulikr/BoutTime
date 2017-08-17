//
//  SoundProvider.swift
//  BoutTime
//
//  Created by James Mulholland on 17/08/2017.
//  Copyright © 2017 JamesMulholland. All rights reserved.
//

import Foundation
import AudioToolbox

class SoundProvider {
    var correctSound: SystemSoundID = 0
    var incorrectSound: SystemSoundID = 1
    
    init() {
        let pathToCorrectSoundFile = Bundle.main.path(forResource: "correctSound", ofType: "wav")
        let correctSoundURL = URL(fileURLWithPath: pathToCorrectSoundFile!)
        AudioServicesCreateSystemSoundID(correctSoundURL as CFURL, &correctSound)
        
        let pathToIncorrectSoundFile = Bundle.main.path(forResource: "incorrectSound", ofType: "wav")
        let incorrectSoundURL = URL(fileURLWithPath: pathToIncorrectSoundFile!)
        AudioServicesCreateSystemSoundID(incorrectSoundURL as CFURL, &incorrectSound)
    }
    
    func playCorrectSound() {
        AudioServicesPlaySystemSound(correctSound)
    }
    
    func playIncorrectSound() {
        AudioServicesPlaySystemSound(incorrectSound)
    }
}
