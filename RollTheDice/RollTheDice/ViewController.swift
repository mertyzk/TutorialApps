//
//  ViewController.swift
//  RollTheDice
//
//  Created by Macbook Air on 9.03.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var gamer1ScoreLabel: UILabel!
    @IBOutlet weak var gamer2ScoreLabel: UILabel!
    @IBOutlet weak var pointGame1Label: UILabel!
    @IBOutlet weak var pointGame2Label: UILabel!
    @IBOutlet weak var imgGamer1Status: UIImageView!
    @IBOutlet weak var imgGamer2Status: UIImageView!
    @IBOutlet weak var imgDice1: UIImageView!
    @IBOutlet weak var imgDice2: UIImageView!
    @IBOutlet weak var setResultLabel: UILabel!
    
    var gamerPoints = (firstGamerPoint : 0 , secondGamerPoint : 0)
    var gamerScores = (firstGamerScore : 0 , secondGamerScore : 0)
    var gamerTurn : Int = 1
    var maxSet : Int = 5
    var currentSet : Int = 1
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let backGround = UIImage(named: "arkaPlan"){
            self.view.backgroundColor = UIColor(patternImage: backGround)
        }
        
    }
    
    


}

extension ViewController{
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        
        if currentSet > maxSet{
            return
        }
        createDiceValue()

    }
    
    func createDiceValue(){
        let dice1 = arc4random_uniform(6) + 1
        let dice2 = arc4random_uniform(6) + 1
        
        imgDice1.image = UIImage(named: String(dice1))
        imgDice2.image = UIImage(named: String(dice2))
        
        setResult(dice1: Int(dice1), dice2: Int(dice2))
        
        if currentSet > maxSet {
            
            if gamerScores.firstGamerScore > gamerScores.secondGamerScore {
                setResultLabel.text = "1ST WON!!"
            }else{
                setResultLabel.text = "2ND WON!"
            }
            
        }

    }
    
    func setResult(dice1 : Int, dice2: Int){
        
        if gamerTurn == 1{
            gamerPoints.firstGamerPoint = dice1 + dice2
            pointGame1Label.text = String(gamerPoints.firstGamerPoint)
            imgGamer1Status.image = UIImage(named: "bekle")
            imgGamer2Status.image = UIImage(named: "onay")
            setResultLabel.text = "2ND GAMER"
            gamerTurn = 2
            pointGame2Label.text = "0"
        }else{
            gamerPoints.secondGamerPoint = dice1 + dice2
            pointGame2Label.text = String(gamerPoints.secondGamerPoint)
            imgGamer2Status.image = UIImage(named: "bekle")
            imgGamer1Status.image = UIImage(named: "onay")
            setResultLabel.text = "1ST GAMER"
            gamerTurn = 1
            
        }
        
        if gamerPoints.firstGamerPoint > gamerPoints.secondGamerPoint{
            
            gamerScores.firstGamerScore += 1
            setResultLabel.text = "\(currentSet). SET WINNER: 1ST PLAYER"
            currentSet += 1
            gamer1ScoreLabel.text = String(gamerScores.firstGamerScore)
            
        }else if gamerPoints.firstGamerPoint < gamerPoints.secondGamerPoint{
            
            gamerScores.secondGamerScore += 1
            setResultLabel.text = "\(currentSet). SET WINNER: 2ND PLAYER"
            currentSet += 1
            gamer2ScoreLabel.text = String(gamerScores.secondGamerScore)
            
        }else{
            
            setResultLabel.text = "\(currentSet).SET WINNER: DRAW"
            
            
        }
        
        gamerPoints.firstGamerPoint = 0
        gamerPoints.secondGamerPoint = 0
        
    }
    
    
}
