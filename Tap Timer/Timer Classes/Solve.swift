//
//  Solve.swift
//  Tap Timer
//
//  Created by Jackson Weidmann on 8/14/18.
//  Copyright © 2018 Jackson Weidmann. All rights reserved.
//

import Foundation
import UIKit
class Solve {
    var sTime = 0
    var fTime = ""
    var type = "Nil Solve"
    var penalty = ""
    var scramble = ""
    var solveDate:Date
    init(newTime:Int,newType:String,newScramble:String,newPenalty:String) {
        self.solveDate = Date()
        self.sTime = newTime
        self.type = newType
        self.scramble = newScramble
        self.penalty = newPenalty
        if self.penalty == "+2" {
            self.sTime += 2
        }
    }
    func getTime() -> String{
        return self.penalty=="DNF" ? "DNF" : self.penalty=="+2" ? "\(self.fTime)+" : String(self.fTime)
    }
}
