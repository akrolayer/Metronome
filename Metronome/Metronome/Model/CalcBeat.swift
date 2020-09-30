//
//  calcBeat.swift
//  Metronome
//
//  Created by akrolayer on 2020/08/23.
//  Copyright © 2020 akrolayer. All rights reserved.
//

import Foundation

class CalcBeat{
    let behaviors:NSDecimalNumberHandler = NSDecimalNumberHandler(
        roundingMode: NSDecimalNumber.RoundingMode.bankers,
    scale: 1,
    raiseOnExactness: false,
    raiseOnOverflow: false,
    raiseOnUnderflow: false,
    raiseOnDivideByZero: false)

    func GetRoundDoubleDiffPerBeat(interval: Decimal,judgeCount: Int, elapsedString: String) -> NSDecimalNumber{
        let DecimalJudgeCount = Decimal(judgeCount)
        let correctTiming = interval * DecimalJudgeCount//正しいタップ時間
        
        let diff = Decimal(string:elapsedString)! - correctTiming
        let diffPerBeat = diff / interval   //1拍ごとのズレに変換
        
        let NSDecimalDiffPerBeat = NSDecimalNumber(decimal: diffPerBeat)
        let RoundDiffPerBeat = NSDecimalDiffPerBeat.rounding(accordingToBehavior: behaviors)
        return RoundDiffPerBeat
    }
    
    func GetEachRoundDiffperBeat(TapTimingString: String,interval: Decimal, tapCount: Int)->NSDecimalNumber{
        
        let diff = Decimal(string:TapTimingString)! - interval * Decimal(tapCount)
        let diffPerBeat = diff / interval
        
        let NSDecimalDiffPerBeat = NSDecimalNumber(decimal: diffPerBeat)
        let RoundDiffPerBeat = NSDecimalDiffPerBeat.rounding(accordingToBehavior: behaviors)
        return RoundDiffPerBeat
        //return roundDoubleDiffPerBeat
    }
}
