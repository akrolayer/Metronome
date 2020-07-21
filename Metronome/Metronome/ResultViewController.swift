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
    var count = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        for result in list{
            print(result)
            resultLabel.text?.append("\(count)回目：\(result)拍ずれています \n")
            count += 1
        }
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
