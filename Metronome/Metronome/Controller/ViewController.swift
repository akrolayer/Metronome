//
//  ViewController.swift
//  Metronome
//
//  Created by akrolayer on 2020/07/04.
//  Copyright © 2020 akrolayer. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet var BPMTextField: UITextField!
    @IBOutlet var beatTextField: UITextField!
    @IBOutlet var BPMLabel: UILabel!
    
    @IBOutlet var PlayButton: UIButton!
    @IBOutlet var SilentKeepButton: UIButton!
    @IBOutlet var ConstantKeepButton: UIButton!
    
    var PlayOrStop: Bool = true
    
    var bpmArray:[Int] = ([Int])(60...660)
    
    let beatArray = ["4","8","12","16","24","32","48","64"]
    
    var pickerView = UIPickerView()
    
    var timer:Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let bpmString = String(UserDefaults.standard.string(forKey: "BPM") ?? "60")
        let beatString = String(UserDefaults.standard.string(forKey: "beat") ?? "4")
        pickerView.delegate = self
        pickerView.dataSource = self
        //pickerView.selectRow(60, inComponent: 0, animated: false)
        pickerView.selectRow(Int(bpmString)! - 60, inComponent: 0, animated: false)
        pickerView.selectRow(Int(beatString)! / 4 - 1, inComponent: 1, animated: false)
        pickerView.accessibilityIdentifier = "picker"
        pickerView.isAccessibilityElement = true

        let toolbar = UIToolbar(frame:CGRect(x: 0, y: UIScreen.main.bounds.size.height, width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width / 4))
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.done))
        doneItem.accessibilityIdentifier = "done"
        toolbar.setItems([doneItem], animated: true)
        self.BPMTextField.inputView = pickerView
        self.BPMTextField.inputAccessoryView = toolbar
        
        self.beatTextField.inputView = pickerView
        self.beatTextField.inputAccessoryView = toolbar
        
        //BPMTextField.text = "120"
        //beatTextField.text = "4"
        BPMTextField.text = bpmString
        beatTextField.text = beatString
        BPMLabel.text = BPMTextField.text
        // Do any additional setup after loading the view.
    }

    var audioPlayer = PlaySound()
    
    @IBAction func Button1(_ sender: Any) {
        if PlayOrStop{
            let bpm = calcBPM()
            SilentKeepButton.isEnabled = false
            ConstantKeepButton.isEnabled = false
            PlayOrStop = !PlayOrStop
            PlayButton.setTitle("停止", for: UIControl.State.normal)
            timer = Timer.scheduledTimer(timeInterval: 60 / Double(bpm)! , target: self, selector: #selector(self.Action), userInfo: nil, repeats: true)
        }
        else{
            timer.invalidate()
            SilentKeepButton.isEnabled = true
            ConstantKeepButton.isEnabled = true
            PlayButton.setTitle("再生", for: UIControl.State.normal)
            PlayOrStop = !PlayOrStop
        }
        
    }
    @objc func Action(){
        audioPlayer.playSound()
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
    //列を選択した後の処理
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    func calcBPM()->String{
        audioPlayer.calcQuarterNotes(BPM: String(bpmArray[pickerView.selectedRow(inComponent: 0)]),Notes: beatArray[pickerView.selectedRow(inComponent: 1)])
    }
    @objc func done() {
        BPMTextField.endEditing(true)
        beatTextField.endEditing(true)

        BPMTextField.text = String(bpmArray[pickerView.selectedRow(inComponent: 0)])
        beatTextField.text = String(beatArray[pickerView.selectedRow(inComponent: 1)])
        UserDefaults.standard.set(BPMTextField.text,forKey: "BPM")
        UserDefaults.standard.set(beatTextField.text,forKey: "beat")
        BPMLabel.text! = calcBPM()
    }
}

