//
//  SolveViewController.swift
//  Tap Timer
//
//  Created by Jackson Weidmann on 8/14/18.
//  Copyright © 2018 Jackson Weidmann. All rights reserved.
//

import Foundation
import UIKit
class SolveViewController: UIViewController {
    @IBOutlet weak var timeDisplay: UILabel!
    @IBOutlet weak var penaltyLabel: UILabel!
    @IBOutlet weak var scrambleLabel: UILabel!
    @IBOutlet weak var scrambleType: UILabel!
    @IBOutlet weak var sessionName: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var solve:Solve!
    var session = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Entered Page: Solve")
        scrambleLabel.numberOfLines = 0
        scrambleLabel.lineBreakMode = .byWordWrapping
        timeDisplay.text = "\(solve.getTime())"
        penaltyLabel.text = "Penalty: \(solve.penalty=="" ? "None" : solve.penalty)"
        scrambleLabel.text = "Scramble: \(solve.scramble)"
        scrambleType.text = "Solve Type: \(solve.type)"
        sessionName.text = "Session: \(session)"
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd, yyyy HH:mm:ss"
        var dateDisplay:String!
        print(solve.solveDate.description.prefix(19))
        if let date = dateFormatterGet.date(from: String(solve.solveDate.description.prefix(19))){
            dateDisplay = dateFormatterPrint.string(from: date)
            print(dateDisplay)
        }
        else {
            print("There was an error decoding the string")
        }
        dateLabel.text = "Date: \(dateDisplay!)"
    }
}
