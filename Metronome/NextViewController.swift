//
//  NextViewController.swift
//  Metronome
//
//  Created by akrolayer on 2020/07/07.
//  Copyright © 2020 akrolayer. All rights reserved.
//

import UIKit

class NextViewController: UIViewController {

    @IBOutlet var startButton: UIButton!
    
    @IBOutlet var stopButton: UIButton!
    
    
    var timer:Timer!
    var Count:Int = 0
    var bpm:String = ""
    var interval:Double = 0.0
    var countdown:Double = 0.0
    var playcount = 4
    var notplaycount = 26
    var audioPlayer = PlaySound()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopButton.isEnabled = false
        //label.text = bpm
        interval = 60 / Double(bpm)!
        countdown = interval * 30.0
        
    }

    @IBAction func start(_ sender: Any) {
        startButton.isEnabled = false
        stopButton.isEnabled = true
        
        startTimer()
        
    }
    
    @IBAction func stop(_ sender: Any) {
        startButton.isEnabled = true
        stopButton.isEnabled = false
        
        timer.invalidate()
        Count = 0
        countdown = interval * 30.0
    }
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(self.Action), userInfo: nil, repeats: true)
    }
    @objc func Action(){
        //音無しにして、指定回数後再生するようにする
        if(Count <= playcount){
            audioPlayer.playSound()
        }
        if(Count == playcount + notplaycount + 1){
            audioPlayer.playSound()
            self.stop(stopButton as Any)
        }
        
        Count += 1
        //label.text = String(Count)
    }
}
