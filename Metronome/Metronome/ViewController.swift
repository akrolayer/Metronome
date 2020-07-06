//
//  ViewController.swift
//  Metronome
//
//  Created by akrolayer on 2020/07/04.
//  Copyright © 2020 akrolayer. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet var pickerView: UIPickerView!
    
    
    var bpmArray:[Int] = ([Int])(60...660)
    
    let beatArray = ["4","8","12","16","24","32","48","64"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        
        // Do any additional setup after loading the view.
    }

    var audioPlayer = PlaySound()
    
    @IBAction func Button1(_ sender: Any) {
        let bpm = audioPlayer.calcQuarterNotes(BPM: String(bpmArray[pickerView.selectedRow(inComponent: 0)]),Notes: beatArray[pickerView.selectedRow(inComponent: 1)])

        audioPlayer.metronome(BPM: bpm)
    }
    
    //UIPickerViewの列の数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    //UIPickerViewの行数、リストの数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(component == 0){
            return bpmArray.count
        }
        else{
            return beatArray.count
        }
    }
    //表示するデータを決める
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(component == 0){
            return String(bpmArray[row])
        }
        else{
            return beatArray[row]
        }
    }
    
}

