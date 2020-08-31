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
    @IBOutlet var startButton: UIButton!
    @IBOutlet var stopButton: UIButton!
    @IBOutlet var beatButton: UIButton!
    
    var bpm:String = ""
    var interval:Decimal = 0.0
    
    var ringCount:Int = 0
    let playCount = 4
    let judgeCount = 12
    let sixty:Decimal = 60

    var pushTiming = 0.0
    var correctTiming:Decimal = 0.0
    var startTiming:CFAbsoluteTime = 0.0
    var tapCount: Int = 0
    var resultList:[Double] = []
    
    var timer:Timer!
    let audioPlayer = PlaySound()
    let calcBeat = CalcBeat()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.isEnabled = true
        stopButton.isEnabled = false
        
        //label.text = bpm
        interval = sixty / Decimal.init(string: bpm)!
        descLabel.text = "音が鳴るタイミングで右のボタンを\(judgeCount)回押してください。最初の４回は音が鳴ります"
        // Do any additional setup after loading the view.
    }

    @IBAction func start(_ sender: Any) {
        if tapCount == 0{
            stopButton.isEnabled = true
            startTimer()
//            let image = UIImage(systemName: "music.note")
//            startButton.setImage(image, for: UIControl.State.normal)
//            startButton.imageView?.contentMode = .scaleAspectFit
            tapCount += 1
            return;
        }
        //let roundDiffPerBeat = GetRoundDiffperBeat(startTiming: startTiming)
        var TapTiming = CFAbsoluteTimeGetCurrent() - startTiming
        let errorNumber = 0.3 //誤差
        TapTiming -= errorNumber
        let TapTimingString = String(TapTiming)
        let roundDiffPerBeat = calcBeat.GetEachRoundDiffperBeat(TapTimingString: TapTimingString, interval: interval, tapCount: tapCount)
        resultList.append(roundDiffPerBeat)
        
        if(tapCount == judgeCount){
            let image = UIImage(named: "1_start")
            startButton.setImage(image, for: UIControl.State.normal)
            //画面遷移する
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "result") as! ResultViewController

            vc.list = resultList
            vc.bpm = bpm
            //NavigationControllerを継承したViewControllerを遷移
            self.navigationController?.pushViewController(vc, animated: true)
            
            timer.invalidate()
            resultList.removeAll()
            tapCount = 0
        }
        tapCount += 1;
    }
    
    @IBAction func stop(_ sender: Any) {
        let image = UIImage(named: "1_start")
        startButton.setImage(image, for: UIControl.State.normal)
        stopButton.isEnabled = false
        
        timer.invalidate()
        resultList.removeAll()
        tapCount = 0
    }
    func startTimer(){
        ringCount = 0
        startTiming = CFAbsoluteTimeGetCurrent()
        let NSDecimalInterval = NSDecimalNumber(decimal: interval)
        let DoubleInterval = Double(truncating: NSDecimalInterval)
        timer = Timer.scheduledTimer(timeInterval: DoubleInterval , target: self, selector: #selector(self.Action), userInfo: nil, repeats: true)
    }
    @objc func Action(){
        if(ringCount < playCount){
            audioPlayer.playSound()
        }
        print(ringCount)
        ringCount += 1
    }
    override func viewWillDisappear(_ animated: Bool) {
        if stopButton.isEnabled == true{
            stop(stopButton as Any)
        }
    }
}
