//
//  ViewController.swift
//  CatchTheKenny
//
//  Created by Macbook Air on 15.02.2022.
//

import UIKit

class ViewController: UIViewController {

    var score:Int = 0
    var timer:Timer?
    var counter = 10
    var kennyArray = [UIImageView]()
    var hideTimer:Timer?
    var highSco = 0
    
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScore: UILabel!
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil{
            highSco = 0
            highScore.text = "High score: \(highSco)"
        }
        
        if let newScore = storedHighScore as? Int{
            highSco = newScore
            highScore.text = "High score: \(highSco)"
        }
        
        scoreLabel.text = "Score: \(score)"
        
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        
        let recorganizer1 = UITapGestureRecognizer(target: self, action: #selector(incereaseScore))
        let recorganizer2 = UITapGestureRecognizer(target: self, action: #selector(incereaseScore))
        let recorganizer3 = UITapGestureRecognizer(target: self, action: #selector(incereaseScore))
        let recorganizer4 = UITapGestureRecognizer(target: self, action: #selector(incereaseScore))
        let recorganizer5 = UITapGestureRecognizer(target: self, action: #selector(incereaseScore))
        let recorganizer6 = UITapGestureRecognizer(target: self, action: #selector(incereaseScore))
        let recorganizer7 = UITapGestureRecognizer(target: self, action: #selector(incereaseScore))
        let recorganizer8 = UITapGestureRecognizer(target: self, action: #selector(incereaseScore))
        let recorganizer9 = UITapGestureRecognizer(target: self, action: #selector(incereaseScore))
        
        kenny1.addGestureRecognizer(recorganizer1)
        kenny2.addGestureRecognizer(recorganizer2)
        kenny3.addGestureRecognizer(recorganizer3)
        kenny4.addGestureRecognizer(recorganizer4)
        kenny5.addGestureRecognizer(recorganizer5)
        kenny6.addGestureRecognizer(recorganizer6)
        kenny7.addGestureRecognizer(recorganizer7)
        kenny8.addGestureRecognizer(recorganizer8)
        kenny9.addGestureRecognizer(recorganizer9)
        
        kennyArray = [kenny1, kenny2, kenny3, kenny4, kenny5, kenny6, kenny7, kenny8, kenny9]
        
        timeLabel.text = "Time: \(counter)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
        
        hideKenny()
        
        
        
        
        
    }
    
    @objc func incereaseScore(){
        
        score += 1
        scoreLabel.text = "Score: \(score)"
        
        
        
        
    }
    
    @objc func countDown(){
        counter -= 1
        timeLabel.text = String(counter)
        if counter == 0 {
            timer?.invalidate()
            hideTimer?.invalidate()
            
            for kenny in kennyArray {
                kenny.isHidden = true
            }
            
            if self.score > self.highSco{
                self.highSco = score
                highScore.text = "Highscore: \(self.highSco)"
                UserDefaults.standard.set(self.highSco, forKey: "highscore")
            }
            
            
            let alert = UIAlertController(title: "Time is up", message: "Try again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)
                
                
            }
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func hideKenny(){
        
        for kenny in kennyArray {
            kenny.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(kennyArray.count - 1)))
        kennyArray[random].isHidden = false
        
    }


}

