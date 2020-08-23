//
//  calcBeat.swift
//  Metronome
//
//  Created by akrolayer on 2020/08/23.
//  Copyright © 2020 akrolayer. All rights reserved.
//

import Foundation

class CalcBeat{
    
    func CalcRoundDoubleDiffPerBeat(interval: Decimal,judgeCount: Int, startTiming: CFAbsoluteTime) -> Double{
        let DecimalJudgeCount = Decimal(judgeCount)
        let correctTiming = interval * DecimalJudgeCount
        let elapsed = CFAbsoluteTimeGetCurrent() - startTiming
        let elapsedString = String(elapsed)
        var diff = Decimal(string:elapsedString)! - correctTiming
        let errorNumber:Decimal = 0.2
        diff -= errorNumber
        
        let diffPerBeat = diff / interval
        let NSDecimaldiffPerBeat = NSDecimalNumber(decimal: diffPerBeat)
        let doubleDiffPerBeat = Double(truncating: NSDecimaldiffPerBeat)
        let roundDoubleDiffPerBeat = round(doubleDiffPerBeat * 10) / 10
        return roundDoubleDiffPerBeat
    }
    
    func GetRoundDiffperBeat(startTiming: CFAbsoluteTime,interval: Decimal, tapCount: Int)->Double{
        var TapTiming = CFAbsoluteTimeGetCurrent() - startTiming
        print("TapTiming=\(TapTiming)")
        let NSDecimalInterval = NSDecimalNumber(decimal: interval)
        let errorNumber = 0.2
        TapTiming -= errorNumber
        let doubleInterval = Double(truncating: NSDecimalInterval)
        let roundDoubleInterval = round(doubleInterval * 10) / 10
        print("doubleInterval=\(doubleInterval)")
        let diff = round(TapTiming * 10) / 10 - roundDoubleInterval * Double(tapCount)
        let diffPerBeat = diff / roundDoubleInterval

        let roundDiffPerBeat = round(diffPerBeat*10) / 10
        return roundDiffPerBeat
    }
}
