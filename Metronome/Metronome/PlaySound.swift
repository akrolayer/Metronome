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
        var sound = AVAudioPlayer()
        if let path = Bundle.main.path(forResource: "2_cymbal", ofType: "mp3"){
            do{
                sound = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                print("Playing sound")
                sound.play()
            }catch{
                print("Could not file path")
            }
        }
    }
    func playSound2(){
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
        
        while(i < 8){
            playSound2()
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

