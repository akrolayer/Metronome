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

    var timer:Timer!
    var Count:Int = 0
    var bpm:String = ""
    var interval:Decimal = 0.0
    let sixty:Decimal = 60
    var playcount = 4
    let judgeCount:Decimal = 12
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
        label.text = ""
        print("interval = \(interval)")
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
