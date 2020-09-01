//
//  ResultViewController.swift
//  Metronome
//
//  Created by akrolayer on 2020/07/21.
//  Copyright © 2020 akrolayer. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet var resultLabel: UILabel!
    var list:[Double]  = []
    var playCount = 1
    var bpm:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        for result1 in list{
            print("list = \(result1)\n")
        }
        for result in list{
            print(result)
            resultLabel.text?.append("\(playCount)回目：\(result)拍ずれています \n")
            playCount += 1
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func shareButton(_ sender: Any) {
        let items = ["\(bpm)で\(list.count)回、最終的に\(list[list.count - 1])拍ずれたよ！"]
        let actibityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(actibityVC,animated: true,completion: nil)
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
