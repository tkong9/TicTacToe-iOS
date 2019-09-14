//
//  IntroVC.swift
//  TicTacToe
//
//  Created by TAEWON KONG on 9/13/19.
//  Copyright © 2019 TAEWON KONG. All rights reserved.
//

import UIKit

class IntroVC: UIViewController {
    
    @IBOutlet weak var player1Button: UIButton!
    @IBOutlet weak var player2Button: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.navigationBar.isHidden = true
        
//        player1Button.backgroundColor = .clear
//        player1Button.layer.cornerRadius = 5
//        player1Button.layer.borderWidth = 1
//        player1Button.layer.borderColor = UIColor.black.cgColor
//        
//        player2Button.backgroundColor = .clear
//        player2Button.layer.cornerRadius = 5
//        player2Button.layer.borderWidth = 1
//        player2Button.layer.borderColor = UIColor.black.cgColor
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
