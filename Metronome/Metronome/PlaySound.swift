//
//  PlaySound.swift
//  Metronome
//
//  Created by akrolayer on 2020/07/04.
//  Copyright © 2020 akrolayer. All rights reserved.
//

import AVFoundation
import Combine

class PlaySound{
    func playSound(){
        // dtmf-8.caf    TouchTone
        var soundIdRing:SystemSoundID = 1208
         
        if let soundUrl = CFBundleCopyResourceURL(CFBundleGetMainBundle(), nil, nil, nil){
            AudioServicesCreateSystemSoundID(soundUrl, &soundIdRing)
            AudioServicesPlaySystemSound(soundIdRing)
        }
    }
    
    @discardableResult
    func metronome(BPM: String) -> Bool{
        guard let bpm = Double(BPM)
            else { return false }
        var i = 0
        
        while(i < 12){
            playSound()
            Thread.sleep(forTimeInterval: 60 / bpm)
            i += 1
        }
        return true
    }
    func calcQuarterNotes(BPM: String, Notes: String)-> String{
        guard var bpm = Int(BPM) else { return "false" }
        guard var notes = Int(Notes) else { return "false" }
        if notes % 12 == 0{
            notes = notes / 3 * 4
            bpm = bpm / 4 * 3
            while(notes > 4){
                notes /= 2
                bpm *= 2
            }
            return String(bpm)
        }else{
            while(notes > 4){
                notes /= 2
                bpm *= 2
            }
            return String(bpm)
        }
    }
}

