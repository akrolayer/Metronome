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
    
    var count = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        stopButton.isEnabled = false
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

    @IBAction func start(_ sender: Any) {
        startButton.isEnabled = false
        stopButton.isEnabled = true
        
        
    }
    
    @IBAction func stop(_ sender: Any) {
        startButton.isEnabled = true
        stopButton.isEnabled = false
    }
}
