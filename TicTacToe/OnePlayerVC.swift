//
//  OnePlayerVC.swift
//  TicTacToe
//
//  Created by TAEWON KONG on 9/12/19.
//  Copyright © 2019 TAEWON KONG. All rights reserved.
//

import UIKit

class OnePlayerVC: UIViewController {
    
    var player: Int = 1
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    
    @IBOutlet var resetBtn : UIButton!
    @IBOutlet var userMessage : UILabel!
    
    var plays = [Int:Int]()
    
    var done = false
    
    var aiDeciding = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        userMessage.isHidden = true
        resetBtn.isHidden = true
    }
    
    @IBAction func UIButtonClicked(sender: UIButton) {
        if (plays[sender.tag] == nil) && !aiDeciding && !done {
            plays[sender.tag] = player
            sender.setTitle("✗", for: .normal)
        }
        checkForWin()
        if done {
            return
        }
        aiTurn()
    }
    
    @IBAction func resetBtnClicked(sender : UIButton) {
        reset()
    }
    
    func checkForWin() {
        //first row across
        let whoWon = ["I": 0, "you": 1]
        for (key,value) in whoWon {
            if ((plays[7] == value && plays[8] == value && plays[9] == value) || //across the bottom
                (plays[4] == value && plays[5] == value && plays[6] == value) || //across the middle
                (plays[1] == value && plays[2] == value && plays[3] == value) || //across the top
                (plays[7] == value && plays[4] == value && plays[1] == value) || //down the left side
                (plays[8] == value && plays[5] == value && plays[2] == value) || //down the middle
                (plays[9] == value && plays[6] == value && plays[3] == value) || //down the right side
                (plays[7] == value && plays[5] == value && plays[3] == value) || //diagonal
                (plays[9] == value && plays[5] == value && plays[1] == value)) {  //diagonal
                userMessage.isHidden = false
                userMessage.text = "Looks like \(key) won!"
                resetBtn.isHidden = false;
                done = true;
            }
        }
    }
    
    func reset() {
        done = false
        resetBtn.isHidden = true
        userMessage.isHidden = true
        plays = [:]
    }
    
    func checkBottom(value:Int) -> [String] {
        return ["bottom", checkFor(player: value, inList: [7, 8 ,9])]
    }
    
    func checkMiddleAcross(value:Int) -> [String] {
        return ["middleHorz", checkFor(player: value, inList: [4, 5, 6])]
    }
    
    func checkTop(value:Int) -> [String] {
        return ["top", checkFor(player: value, inList: [1, 2, 3])]
    }
    
    func checkLeft(value:Int) -> [String] {
        return ["left", checkFor(player: value, inList: [1, 4, 7])]
    }
    
    func checkMiddleDown(value:Int) -> [String] {
        return ["middleVert", checkFor(player: value, inList: [2, 5, 8])]
    }
    
    func checkRight(value:Int) ->  [String]{
        return ["right", checkFor(player: value, inList: [3, 6, 9])]
    }
    
    func checkDiagLeftRight(value:Int) ->  [String]{
        return ["diagRightLeft", checkFor(player: value, inList: [3, 5, 7])]
    }
    
    func checkDiagRightLeft(value:Int) ->  [String]{
        return ["diagLeftRight", checkFor(player: value, inList: [1, 5, 9])]
    }
    
    func checkFor(player: Int, inList: [Int]) -> String {
        var conclusion = ""
        for cell in inList {
            if plays[cell] == player {
                conclusion += "1"
            }else{
                conclusion += "0"
            }
        }
        return conclusion
    }
    
    func checkThis(_ value: Int) -> [String]{
        return ["right","0"]
    }
    
    func rowCheck(player: Int) -> [String]?{
        let acceptableFinds = ["011","110","101"]
        let findFuncs = [checkTop, checkBottom, checkLeft, checkRight, checkMiddleAcross, checkMiddleDown, checkDiagLeftRight, checkDiagLeftRight]
        for algorithm in findFuncs {
            var algorithmResults = algorithm(player)
            
            if acceptableFinds.contains(algorithmResults[1]) {
                return algorithmResults
            }
        }
        return nil
    }
    
    func isOccupied(_ spot: Int) -> Bool {
//        print("occupied \(spot)")
        if plays[spot] != nil {
            return true
        }
        return false
    }
    
    func whereToPlay(location: String, pattern: String) -> Int {
        let leftPattern = "011"
        let rightPattern = "110"
        let _ = "101"
        switch location {
        case "top":
            if pattern == leftPattern {
                return 1
            }else if pattern == rightPattern{
                return 3
            }else{
                return 2
            }
        case "bottom":
            if pattern == leftPattern {
                return 7
            }else if pattern == rightPattern{
                return 9
            }else{
                return 8
            }
        case "left":
            if pattern == leftPattern {
                return 1
            }else if pattern == rightPattern{
                return 7
            }else{
                return 4
            }
        case "right":
            if pattern == leftPattern {
                return 3
            }else if pattern == rightPattern{
                return 9
            }else{
                return 6
            }
        case "middleVert":
            if pattern == leftPattern {
                return 2
            }else if pattern == rightPattern{
                return 8
            }else{
                return 5
            }
        case "middleHorz":
            if pattern == leftPattern {
                return 4
            }else if pattern == rightPattern{
                return 6
            }else{
                return 5
            }
        case "diagLeftRight":
            if pattern == leftPattern {
                return 1
            }else if pattern == rightPattern{
                return 9
            }else{
                return 5
            }
        case "diagRightLeft":
            if pattern == leftPattern {
                return 3
            }else if pattern == rightPattern{
                return 7
            }else{
                return 5
            }
        default:
            return 4
        }
    }
    
    func firstAvailable(isCorner: Bool) -> Int? {
        let spots = isCorner ? [1, 3, 7, 9] : [2, 4, 6, 8]
        for spot in spots {
            print("checking \(spot)")
            if !isOccupied(spot) {
                print("not occupied \(spot)")
                return spot
            }
        }
        return nil
    }
    
    func aiTurn() {

//        aiDeciding = true
        //We (the computer) have two in a row
        if let result = rowCheck(player: 0) {
            print("computer has two in a row")
            let whereToPlayResult = whereToPlay(location: result[0], pattern: result[1])
            
            if !isOccupied(whereToPlayResult) {
                let button = view.viewWithTag(whereToPlayResult) as! UIButton
                button.setTitle("○", for: .normal)
//                aiDeciding = false
                checkForWin()
                return
            }
        }
        //They (the player) have two in a row
        if let result = rowCheck(player: 1) {
            let whereToPlayResult = whereToPlay(location: result[0], pattern: result[1])
            if !isOccupied(whereToPlayResult) {
                let button = view.viewWithTag(whereToPlayResult) as! UIButton
                button.setTitle("○", for: .normal)
//                aiDeciding = false
                checkForWin()
                return
            }
        }
        //Is center available?
        if !isOccupied(5) {
            let button = view.viewWithTag(5) as! UIButton
            button.setTitle("○", for: .normal)
//            aiDeciding = false
            checkForWin()
            return
        }
        
        if let cornerAvailable = firstAvailable(isCorner: true){
            let button = view.viewWithTag(cornerAvailable) as! UIButton
            button.setTitle("○", for: .normal)
//            aiDeciding = false
            checkForWin()
            return
        }
        if let sideAvailable = firstAvailable(isCorner: false){
            let button = view.viewWithTag(sideAvailable) as! UIButton
            button.setTitle("○", for: .normal)
            aiDeciding = false
            checkForWin()
            return
        }
        
        userMessage.isHidden = false
        resetBtn.isHidden = false
        userMessage.text = "Looks like it was a tie!"

        //do we have two in a row
        
        //        1) Win: Ifs you have two in a row, play the third to get three in a row.
        //
        //        2) Block: If the opponent has two in a row, play the third to block them.
        //
        //        3) Fork: Create an opportunity where you can win in two ways.
        //
        //        4) Block Opponent's Fork:
        //
        //        Option 1: Create two in a row to force the opponent into defending, as long as it doesn't result in them creating a fork or winning. For example, if "X" has a corner, "O" has the center, and "X" has the opposite corner as well, "O" must not play a corner in order to win. (Playing a corner in this scenario creates a fork for "X" to win.)
        //
        //        Option 2: If there is a configuration where the opponent can fork, block that fork.
        //
        //        5) Center: Play the center.
        //
        //        6) Opposite Corner: If the opponent is in the corner, play the opposite corner.
        //
        //        7) Empty Corner: Play an empty corner.
        //
        //        8) Empty Side: Play an empty side.
        
//        aiDeciding = false
    }
}
