//
//  Session.swift
//  Tap Timer
//
//  Created by Jackson Weidmann on 8/14/18.
//  Copyright © 2018 Jackson Weidmann. All rights reserved.
//

import Foundation
class Session {
    var title = "Default Title"
    var allSolves = [Solve]()
    
    var currentTime = 0
    var currentScramble = ""
    
    init(newTitle:String) {
        self.title = newTitle
    }
    
    func generateScramble() -> String {
        let moves = ["U","R","F","D","L","B"]
        let movesSuffix = ["'","2",""]
        var scrambleOut = [String]()
        for var i in 0..<23 {
            let nextMove = moves[Int(arc4random_uniform(6))] + movesSuffix[Int(arc4random_uniform(3))]
            var canAdd = true
            if nextMove.first == scrambleOut.last?.first{
                i -= 1
                canAdd = false
            }
            if scrambleOut.count>=2 {
                var twoAgo = scrambleOut[scrambleOut.count-2].first
                var current = nextMove.first
                var index = (moves.index(of: String(current!))! + 3)%6
                if twoAgo == current && scrambleOut.last?.first == Character(moves[index]){
                    i -= 1
                    canAdd = false
                }
            }
            if canAdd {
                scrambleOut.append(nextMove)
            }
        }
        var output = ""
        for item in scrambleOut {
            output+=item+" "
        }
        return output
    }
    
    func formatTime(time:Int) -> String{
        let milliseconds = time%100
        let seconds = (time/100)%60
        let minutes = time/6000%60
        let hours = time/360000
        
        let millisecondsF = milliseconds<10 ? "0\(milliseconds)" : "\(milliseconds)"
        let secondsF = (minutes>0 || hours>0) && seconds<10 ? "0\(seconds)":"\(seconds)"
        let minutesF = minutes>0 || hours>0 ? "\(minutes):" : ""
        let hoursMinsBuffer = hours > 0 && minutes<10 ? "0" : ""
        let hoursF = hours>0 ? "\(hours):" : ""
        
        return hoursF+hoursMinsBuffer+minutesF+secondsF+"."+millisecondsF
    }
}
