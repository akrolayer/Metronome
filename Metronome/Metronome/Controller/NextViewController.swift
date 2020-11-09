//
//  NextViewController.swift
//  Metronome
//
//  Created by akrolayer on 2020/07/07.
//  Copyright © 2020 akrolayer. All rights reserved.
//

import UIKit
import Firebase

class NextViewController: UIViewController {

    @IBOutlet var startButton: UIButton!
    
    @IBOutlet var stopButton: UIButton!
    
    @IBOutlet var resultLabel: UILabel!
    
    @IBOutlet var descLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
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
    
    var bestScore = ""
    
    var audioPlayer = PlaySound()
    let calcBeat = CalcBeat()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopButton.isEnabled = false
        //label.text = bpm
        interval = sixty / Decimal.init(string: bpm)!
        descLabel.text = "\(judgeCount)回鳴ったタイミングで右のボタンを押してください。最初の4回は再生されます"
        resultLabel.text = "";
        let db = Firestore.firestore()
        let docRef = db.collection("result2").document("one")

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
                //var scoreDic: [String: Double] = dataDescription
                let from = dataDescription.index(dataDescription.startIndex, offsetBy:10)
                let to = dataDescription.index(dataDescription.startIndex, offsetBy:11)
                let newString = String(dataDescription[from..<to])
                print(newString)
                self.bestScore = newString
                self.scoreLabel.text! = "ベストスコア：\(self.bestScore)"
            } else {
                print("Document does not exist")
                self.scoreLabel.text! = "ベストスコア：なし"
            }
        }
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
        let errorNumber = 0.2//誤差
        elapsed -= errorNumber
        let elapsedString = String(elapsed)
        let roundDiffPerBeat = calcBeat.GetRoundDoubleDiffPerBeat(interval: interval, judgeCount: judgeCount, elapsedString: elapsedString)
        resultLabel.text = "\(roundDiffPerBeat)拍ずれたよ！"
        if(roundDiffPerBeat.compare(0) == ComparisonResult.orderedDescending){
            roundDiffPerBeat.multiplying(by: -1)
        }
        let result = NSDecimalNumber(string: bestScore).compare(roundDiffPerBeat)
        if (result == ComparisonResult.orderedDescending) {
            let db = Firestore.firestore()
            let docData: [String: Any] = [
                "score": roundDiffPerBeat
                ]
            
            db.collection("result2").document("one").setData(docData) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
            self.scoreLabel.text = "ベストスコア：\(self.bestScore)"
        }
        
        
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
