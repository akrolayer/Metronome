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
    
    
    var count = 0
    var timer:Timer!
    var TimerDisplayed:Double = 0.0
    var bpm:String = ""
    
    
    let interval = 0.1
    override func viewDidLoad() {
        super.viewDidLoad()
        stopButton.isEnabled = false
        label.text = bpm
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func start(_ sender: Any) {
        startButton.isEnabled = false
        stopButton.isEnabled = true
        
        startTimer()
    }
    
    @IBAction func stop(_ sender: Any) {
        startButton.isEnabled = true
        stopButton.isEnabled = false
        
        timer.invalidate()
    }
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(self.Action), userInfo: nil, repeats: true)
    }
    @objc func Action(){
        TimerDisplayed += interval
        label.text = String(TimerDisplayed)
        let now = Date()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "ss:S"
        print(formatter.string(from: now))
    }
}
