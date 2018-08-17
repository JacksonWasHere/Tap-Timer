//
//  ViewController.swift
//  Tap Timer
//
//  Created by Jackson Weidmann on 8/13/18.
//  Copyright © 2018 Jackson Weidmann. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class TimerViewController: UIViewController {

    @IBOutlet weak var scrambleLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    var timerHeightIndex:Int!
    
    var startPress = Timer()
    var solveTimer = Timer()
    
    var currentTime = 0
    var currentScramble = ""
    var currentSession:Session!
    
    var holding = false
    var canStartSolve = false
    var timingSolve = false
    
    //timer settings
    var tapWait = 0.5
    var type = "3x3"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Entered Page: Timer")
        for index in 0..<self.view.constraints.count {
            if self.view.constraints[index].identifier == "timerHeight" {
                timerHeightIndex = index
            }
        }
        // Do any additional setup after loading the view, typically from a nib.
        currentScramble = currentSession.generateScramble()
        scrambleLabel.text = currentScramble
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? MenuViewController else {
            fatalError("Menu VC Error")
        }
        destination.allSessions[destination.sessionIndex] = currentSession
    }
    
    @IBAction func tapHandler(_ sender: UIGestureRecognizer) {
        if timingSolve {
            if sender.state == .began {
                self.stopTimer()
            }
        } else {
            if sender.state == .began {
                
                print("Tap: touch down")
                timerLabel.textColor = UIColor.red
                holding = true
                startPress = Timer.scheduledTimer(timeInterval: tapWait, target: self, selector: #selector(changeTimeLabel), userInfo: nil, repeats: false)
                
            } else if sender.state == .ended {
                
                print("Tap: released")
                holding = false
                startPress.invalidate()
                timerLabel.textColor = .white
                
                if canStartSolve{
                    self.startTimer()
                }
            }
        }
    }
    
    @objc func changeTimeLabel() {
        if holding {
            print("Action: Solve Ready")
            timerLabel.textColor = .green
            canStartSolve = true
        }
    }
    
    @objc func updateTimer() {
        currentTime += 1
        timerLabel.text = currentSession.formatTime(time: currentTime)
        if (currentTime/360000)>0{
            timerLabel.font = UIFont(name: "Arial", size: 50)
        }
        else if (currentTime/6000%60) > 0 {
            timerLabel.font = UIFont(name: "Arial", size: 80)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startTimer() {
        print("Action: Starting solve")
        timingSolve = true
        self.view.constraints[timerHeightIndex].constant = self.view.frame.height/2-50
        scrambleLabel.isHidden = true
        timerLabel.font = UIFont(name: "Arial", size: 100)
        solveTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        print("Tap: stopped")
        
        //End the solve and remove timers
        timingSolve = false
        canStartSolve = false
        solveTimer.invalidate()
        
        //Add the solve
        currentSession.allSolves.append(Solve(newTime: currentTime, newType: type, newScramble: currentScramble, newPenalty: ""))
        currentSession.allSolves.last?.fTime = currentSession.formatTime(time: currentTime)
        
        //reset
        currentTime = 0
        timerLabel.font = UIFont(name: "Arial", size: 36)
        self.view.constraints[timerHeightIndex].constant = 370
        scrambleLabel.isHidden = false
        currentScramble = currentSession.generateScramble()
        scrambleLabel.text = currentScramble
        
        //save
    }
}

