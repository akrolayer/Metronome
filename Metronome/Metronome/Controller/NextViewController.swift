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
    
    @IBOutlet var resultLabel: UILabel!
    
    @IBOutlet var descLabel: UILabel!
    var timer:Timer!
    var Count:Int = 0
    var bpm:String = ""
    var interval:Decimal = 0.0
    let sixty:Decimal = 60
    var playcount = 4
    let judgeCount:Int = 12
    let DecimalJudgeCount:Decimal = 12
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
        resultLabel.text = "";
        print("interval = \(interval)")
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
        if(Count < judgeCount - 1){
            return;
        }
        correctTiming = interval * DecimalJudgeCount
        let elapsed = CFAbsoluteTimeGetCurrent() - startTiming
        let elapsedString = String(elapsed)
        let diff = Decimal(string:elapsedString)! - correctTiming
        
        let diffPerBeat = diff / interval
        let NSDecimaldiffPerBeat = NSDecimalNumber(decimal: diffPerBeat)
        let doubleDiffPerBeat = Double(truncating: NSDecimaldiffPerBeat)
        let roundDoubleDiffPerBeat = round(doubleDiffPerBeat*1000) / 1000
        resultLabel.text = "\(roundDoubleDiffPerBeat)拍ずれたよ！"
        
        let items = ["\(bpm)で\(judgeCount)回、\(roundDoubleDiffPerBeat)拍ずれたよ！"]
        let actibityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(actibityVC,animated: true,completion: nil)
    }
    func startTimer(){
        Count = 0
        let NSDecimalInterval = NSDecimalNumber(decimal: interval)
        let DoubleInterval = Double(truncating: NSDecimalInterval)
        timer = Timer.scheduledTimer(timeInterval: DoubleInterval , target: self, selector: #selector(self.Action), userInfo: nil, repeats: true)
    }
    @objc func Action(){
        if(Count < playcount){
            audioPlayer.playSound()
        }
        Count += 1
    }
    func CalcRoundDoubleDiffPerBeat(){
        let elapsed = CFAbsoluteTimeGetCurrent() - startTiming
        let elapsedString = String(elapsed)
        let diff = Decimal(string:elapsedString)! - correctTiming
        
        let diffPerBeat = diff / interval
        let NSDecimaldiffPerBeat = NSDecimalNumber(decimal: diffPerBeat)
        let doubleDiffPerBeat = Double(truncating: NSDecimaldiffPerBeat)
        let roundDoubleDiffPerBeat = round(doubleDiffPerBeat*1000) / 1000
    }
}
