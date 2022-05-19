//
//  ViewController.swift
//  War
//
//  Created by Alejandro on 6/2/15.
//  Copyright (c) 2015 Alejandro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var firstCardImageView: UIImageView!
    @IBOutlet weak var secondCardImageView: UIImageView!
    @IBOutlet weak var playRoundButton: UIButton!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var playerScore: UILabel!
    @IBOutlet weak var enemyScore: UILabel!

    var cardNamesArray:[String] = ["Card1", "Card2", "Card3", "Card4", "Card5", "Card6", "Card7", "Card8", "Card9", "Card10", "Card11", "Card12", "Card13"]
    
    var playerScoreTotal = 0
    var enemyScoreTotal = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func playRoundTapped(sender: UIButton) {

        var firstRandomNumber:Int = Int(arc4random_uniform(13))
        var secondRandomNumber:Int = Int(arc4random_uniform(13))
        var firstCardString:String = self.cardNamesArray[firstRandomNumber]
        var secondCardString:String = self.cardNamesArray[secondRandomNumber]
       
        self.firstCardImageView.image = UIImage(named: firstCardString)
        self.secondCardImageView.image = UIImage(named: secondCardString)
        
        
        
        // Determine the higher card
        if firstRandomNumber > secondRandomNumber {
            
            // TODO: first card is larger
            playerScoreTotal += 1
            self.playerScore.text = String(playerScoreTotal)
            
        }
        else if firstRandomNumber == secondRandomNumber {
            // TODO: numbers are equal
        }
        else {
            // TODO: second card is larger
            
            enemyScoreTotal += 1
            self.enemyScore.text = String(enemyScoreTotal)

        }
        
        
        
        
    }
}