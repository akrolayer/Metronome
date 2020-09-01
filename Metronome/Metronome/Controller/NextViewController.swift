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

    var pushTiming = 0.0
    var correctTiming:Decimal = 0.0
    var startTiming:CFAbsoluteTime = 0.0
    
    var audioPlayer = PlaySound()
    let calcBeat = CalcBeat()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopButton.isEnabled = false
        //label.text = bpm
        interval = sixty / Decimal.init(string: bpm)!
        descLabel.text = "\(judgeCount)回鳴ったタイミングで右のボタンを押してください。最初の4回は再生されます"
        resultLabel.text = "";

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
        if(Count < judgeCount - 1){
            return;
        }
        var elapsed = CFAbsoluteTimeGetCurrent() - startTiming//１回目にタップしてからタップするまでの時間
        let errorNumber = 0.3//誤差
        elapsed -= errorNumber
        let elapsedString = String(elapsed)
        let roundDoubleDiffPerBeat = calcBeat.GetRoundDoubleDiffPerBeat(interval: interval, judgeCount: judgeCount, elapsedString: elapsedString)
        resultLabel.text = "\(roundDoubleDiffPerBeat)拍ずれたよ！"
        
        let items = ["bpm\(bpm)で\(judgeCount)回、\(resultLabel.text!)"]
        let actibityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(actibityVC,animated: true,completion: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
           if stopButton.isEnabled == true{
               stop(stopButton as Any)
           }
       }
    func startTimer(){
        Count = 0
        let NSDecimalInterval = NSDecimalNumber(decimal: interval)
        let DoubleInterval = Double(truncating: NSDecimalInterval)
        startTiming = CFAbsoluteTimeGetCurrent()
        timer = Timer.scheduledTimer(timeInterval: DoubleInterval , target: self, selector: #selector(self.Action), userInfo: nil, repeats: true)
    }
    @objc func Action(){
        if Count < playcount{
            audioPlayer.playSound()
        }
        Count += 1
    }
}
