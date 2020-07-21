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
    
    @IBOutlet var BPMLabel: UILabel!
    
    @IBOutlet var PlayButton: UIButton!
    
    var bpmArray:[Int] = ([Int])(60...660)
    
    let beatArray = ["4","8","12","16","24","32","48","64"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.selectRow(0, inComponent: 0, animated: false)
        BPMLabel.text = String(bpmArray[pickerView.selectedRow(inComponent: 0)])
        
        // Do any additional setup after loading the view.
    }

    var audioPlayer = PlaySound()
    
    @IBAction func Button1(_ sender: Any) {
        let bpm = calcBPM()
        PlayButton.isEnabled = false
        audioPlayer.metronome(BPM: bpm)
        PlayButton.isEnabled = true
    }
    

    @IBAction func NextViewButton(_ sender: Any) {
        let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "SirentKeep") as! NextViewController
        
        //ViewController2のtextにtextFieldのテキストを代入
        vc2.bpm = calcBPM()
        
        //NavigationControllerを継承したViewControllerを遷移
        self.navigationController?.pushViewController(vc2, animated: true)
    }
    @IBAction func KeepViewButton(_ sender: Any) {
        let vc3 = self.storyboard?.instantiateViewController(withIdentifier: "TempoKeep") as! NextViewController2
        
        //ViewController2のtextにtextFieldのテキストを代入
        vc3.bpm = calcBPM()
        
        //NavigationControllerを継承したViewControllerを遷移
        self.navigationController?.pushViewController(vc3, animated: true)
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
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        BPMLabel.text! = calcBPM()
    }
    func calcBPM()->String{
        audioPlayer.calcQuarterNotes(BPM: String(bpmArray[pickerView.selectedRow(inComponent: 0)]),Notes: beatArray[pickerView.selectedRow(inComponent: 1)])
    }
}

