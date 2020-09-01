//
//  calcBeat.swift
//  Metronome
//
//  Created by akrolayer on 2020/08/23.
//  Copyright © 2020 akrolayer. All rights reserved.
//

import Foundation

class CalcBeat{
    

    func GetRoundDoubleDiffPerBeat(interval: Decimal,judgeCount: Int, elapsedString: String) -> Double{
        let DecimalJudgeCount = Decimal(judgeCount)
        let correctTiming = interval * DecimalJudgeCount//正しいタップ時間
        
        let diff = Decimal(string:elapsedString)! - correctTiming
        let diffPerBeat = diff / interval   //1拍ごとのズレに変換
        
        let NSDecimalDiffPerBeat = NSDecimalNumber(decimal: diffPerBeat)
        let doubleDiffPerBeat = Double(truncating: NSDecimalDiffPerBeat)
        let roundDoubleDiffPerBeat = round(doubleDiffPerBeat * 10) / 10
        return roundDoubleDiffPerBeat
    }
    
    func GetEachRoundDiffperBeat(TapTimingString: String,interval: Decimal, tapCount: Int)->Double{
        
        let diff = Decimal(string:TapTimingString)! - interval * Decimal(tapCount)
        let diffPerBeat = diff / interval
        
        let NSDecimalDiffPerBeat = NSDecimalNumber(decimal: diffPerBeat)
        let doubleDiffPerBeat = Double(truncating: NSDecimalDiffPerBeat)
        let roundDoubleDiffPerBeat = round(doubleDiffPerBeat * 10) / 10
        
        return roundDoubleDiffPerBeat
    }
}
