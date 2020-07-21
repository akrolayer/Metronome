//
//  NextViewController2.swift
//  Metronome
//
//  Created by akrolayer on 2020/07/18.
//  Copyright © 2020 akrolayer. All rights reserved.
//

import UIKit

class NextViewController2: UIViewController {
    
    @IBOutlet var descLabel: UILabel!
    @IBOutlet var label: UILabel!
    @IBOutlet var startButton: UIButton!
    @IBOutlet var stopButton: UIButton!
    @IBOutlet var beatButton: UIButton!
    
    var timer:Timer!
    var Count:Int = 0
    var bpm:String = ""
    var interval:Decimal = 0.0
    let sixty:Decimal = 60
    var playcount = 4
    let judgeCount = 12
    var audioPlayer = PlaySound()
    var pushTiming = 0.0
    var correctTiming:Decimal = 0.0
    var startTiming:CFAbsoluteTime = 0.0
    var tapCount: Int = 0
    var list:[Double] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopButton.isEnabled = false
        //label.text = bpm
        interval = sixty / Decimal.init(string: bpm)!
        descLabel.text = "音が鳴るタイミングで右のボタンを\(judgeCount)回押してください。最初の４回は音が鳴ります"
        label.text = ""
        print("interval = \(interval)")
        // Do any additional setup after loading the view.
    }

    @IBAction func start(_ sender: Any) {
        if tapCount == 0{
            //startButton.isEnabled = false
            stopButton.isEnabled = true
            startTimer()
            startTiming = CFAbsoluteTimeGetCurrent()
        }
        let TapTiming = CFAbsoluteTimeGetCurrent() - startTiming
        let NSDecimalInterval = NSDecimalNumber(decimal: interval)
        let doubleInterval = Double(truncating: NSDecimalInterval)
        let roundDoubleInterval = round(doubleInterval * 1000) / 1000
        let diff = round(TapTiming * 1000) / 1000 - roundDoubleInterval * Double(tapCount)
        let diffPerBeat = diff / roundDoubleInterval

        let roundDiffPerBeat = round(diffPerBeat*1000) / 1000
        list.append(roundDiffPerBeat)
        
        if(tapCount == judgeCount){
            self.stop(stopButton as Any)
            //画面遷移する
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "result") as! ResultViewController

            vc.list = list
            //NavigationControllerを継承したViewControllerを遷移
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        tapCount += 1;
    }
    @IBAction func stop(_ sender: Any) {
        startButton.isEnabled = true
        stopButton.isEnabled = false
        
        timer.invalidate()
        list.removeAll()
        tapCount = 0
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
        print(Count)
        Count += 1
    }
}
