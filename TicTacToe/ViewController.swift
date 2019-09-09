//
//  ViewController.swift
//  TicTacToe
//
//  Created by TAEWON KONG on 9/5/19.
//  Copyright © 2019 TAEWON KONG. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var winnerLabel: UILabel!
    
    @IBOutlet weak var playAgain: UIButton!
    
    var activePlayer: Int = 1
    
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    let winningCombinations: [[Int]] = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    var gameIsActive: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        winnerLabel.isHidden = true
        playAgain.isHidden = true
    }

    @IBAction func playerPressedAButton(_ sender: UIButton) {
        
        if !gameIsActive {
            return
        }
        
        if gameState[sender.tag - 1] == 0 {
            
            gameState[sender.tag - 1] = activePlayer
            
            if activePlayer == 1 {
                sender.setImage(UIImage(named: "circle_black"), for: .normal)
                activePlayer = 2
            } else {
                sender.setImage(UIImage(named: "x_black"), for: .normal)
                activePlayer = 1
            }
        }
        
        for combination in winningCombinations {
            if gameState[combination[0]] != 0 && gameState[combination[0]] == gameState[combination[1]] && gameState[combination[1]] == gameState[combination[2]] {

                if gameState[combination[0]] == 1 {
                    print("player1 has won.")
                    winnerLabel.text = "Player1 has won."
                    winnerLabel.isHidden = false
                    playAgain.isHidden = false
                } else {
                    print("player2 has won")
                    winnerLabel.text = "Player2 has won."
                    winnerLabel.isHidden = false
                    playAgain.isHidden = false
                }
                winnerLabel.isHidden = false
                playAgain.isHidden = false
                gameIsActive = false
                return
            }
        }
        
        gameIsActive = false
        
        for i in gameState {
            if i == 0 {
                gameIsActive = true
                break
            }
        }
        if gameIsActive == false {
            winnerLabel.text = "It was a draw"
            winnerLabel.isHidden = false
            playAgain.isHidden = false
        }
    }
    
    @IBAction func playAgainButton(_ sender: UIButton) {
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        gameIsActive = true
        activePlayer = 1
        
        playAgain.isHidden = true
        winnerLabel.isHidden = true
        
        for i in 1...9 {
            let button = view.viewWithTag(i) as! UIButton
            button.setImage(nil, for: .normal)
        }
    }
}
