//
//  SessionTableViewController.swift
//  Tap Timer
//
//  Created by Jackson Weidmann on 8/15/18.
//  Copyright © 2018 Jackson Weidmann. All rights reserved.
//

import UIKit

class SolveTableViewController: UITableViewController {

    var currentSession:Session!
    override func viewDidLoad() {
        super.viewDidLoad()
//        loadData()
        print("Entered Page: Solve List")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return currentSession.allSolves.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SolveTableViewCell", for: indexPath) as? SolveCell else {
            fatalError("Bad cell")
        }
        // Configure the cell...
        let currentSolve = currentSession.allSolves[indexPath.row]
        cell.timeLabel.text = currentSession.formatTime(time: currentSolve.sTime)
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        guard let d = segue.destination as? SolveViewController else {
            fatalError("Wrong VC")
        }
        guard let selectedCell = sender as? SolveCell else {
            fatalError("Unexpected Sender")
        }
        guard let indexPath = tableView.indexPath(for: selectedCell) else {
            fatalError("Invalid cell selection")
        }
        d.session = "\(currentSession.title)"
        d.solve = currentSession.allSolves[indexPath.row]
    }
    private func loadSampleSolves() {
//        let solve1 = Solve(newTime: 100, newType: "3", newScramble: "R U R' U'", newPenalty: "")
//        solves += [solve1]
    }
    private func loadData(){
        currentSession = Session(newTitle: "Big")
        currentSession.allSolves.append(Solve(newTime: 2197, newType: "3x3", newScramble: "D' L2 R2 F2 U' R2 B2 F2 U L2 D' B' F L' U2 F2 D' R' B U' L", newPenalty: ""))
        currentSession.allSolves.last?.fTime = currentSession.formatTime(time: currentSession.allSolves.last!.sTime)
    }
}
