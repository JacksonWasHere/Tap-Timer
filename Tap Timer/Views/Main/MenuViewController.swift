//
//  MenuViewController.swift
//  Tap Timer
//
//  Created by Jackson Weidmann on 8/14/18.
//  Copyright © 2018 Jackson Weidmann. All rights reserved.
//

import UIKit
import Foundation
class MenuViewController: UIViewController {
    var allSessions = [Session]()
    var sessionIndex = 0
    override func viewDidLoad() {
        // Do any additional setup after loading the view, typically from a nib.
        super.viewDidLoad()
        
        if allSessions.count == 0 {
            allSessions.append(Session(newTitle: "Default"))
        }
        
        print("Entered Page: Menu")
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        if let timer = destination as? TimerViewController {
            timer.currentSession = self.allSessions[sessionIndex]
        } else if let solves = destination as? SolveTableViewController{
            solves.currentSession = self.allSessions[sessionIndex]
        } else if let sessions = destination as? SessionsTableViewController {
            sessions.selectedSession = self.sessionIndex
        }
    }
}
