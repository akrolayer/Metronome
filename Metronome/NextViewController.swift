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
    
    @IBOutlet var label: UILabel!
    
    @IBOutlet var descLabel: UILabel!
    var timer:Timer!
    var Count:Int = 0
    var bpm:String = ""
    var interval:Decimal = 0.0
    let sixty:Decimal = 60
    var playcount = 4
    let judgeCount:Decimal = 6
    var audioPlayer = PlaySound()
    var pushTiming = 0.0
    var correctTiming:Decimal = 0.0
    var startTiming:CFAbsoluteTime = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopButton.isEnabled = false
        //label.text = bpm
        interval = sixty / Decimal.init(string: bpm)!
        descLabel.text = "\(judgeCount)回鳴ったタイミングでボタンを押してください。最初の4回は再生されます"
        print(interval)
    }

    @IBAction func start(_ sender: Any) {
        startButton.isEnabled = false
        stopButton.isEnabled = true
        startTimer()
        startTiming = CFAbsoluteTimeGetCurrent()
    }
    
    @IBAction func stop(_ sender: Any) {
        startButton.isEnabled = true
        stopButton.isEnabled = false
        
        timer.invalidate()
        correctTiming = interval * judgeCount
        let elapsed = CFAbsoluteTimeGetCurrent() - startTiming
        print(elapsed)
        let elapsedString = String(elapsed)
        let diff = Decimal(string:elapsedString)! - correctTiming
        label.text = "\(diff)秒ずれています"
    }
    func startTimer(){
        Count = 0
        let NSDecimalInterval = NSDecimalNumber(decimal: interval)
        let DoubleInterval = Double(truncating: NSDecimalInterval)
        timer = Timer.scheduledTimer(timeInterval: DoubleInterval as! Double, target: self, selector: #selector(self.Action), userInfo: nil, repeats: true)
    }
    @objc func Action(){
        //音無しにして、指定回数後再生するようにする
        if(Count < playcount){
            audioPlayer.playSound()
        }

        //if(Count == judgeCount - 1){
          //   correctTiming = CFAbsoluteTimeGetCurrent()
        //}
        label.text = String(Count)
        Count += 1

    }
}
