//
//  ForecastScreenViewController.swift
//  GuessTheNumber
//
//  Created by Macbook Air on 5.02.2022.
//

import UIKit

class ForecastScreenViewController: UIViewController {

    @IBOutlet weak var labelRightToTry: UILabel!
    @IBOutlet weak var labelHelp: UILabel!
    @IBOutlet weak var numberField: UITextField!
    
    var randomNumber:Int?
    var remainingNumber = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()

        randomNumber = Int.random(in: 0...100)
        print(randomNumber!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let incomingData = sender as? Bool{
            let goingVC = segue.destination as! ResultScreenViewController
            goingVC.result = incomingData
        }
    }
    
    @IBAction func runButton(_ sender: Any) {
        labelHelp.isHidden = false
        remainingNumber -= 1
        
        if let data = numberField.text{
            if let prediction = Int(data) {
                
                if remainingNumber > 0 {
                    if prediction == randomNumber! {
                        let result = true
                        performSegue(withIdentifier: "predictionToResult", sender: result)
  
                    }
                    
                    if prediction > randomNumber! {
                        labelHelp.text = "Reduce the number"
                        labelRightToTry.text = "Right to try: \(remainingNumber)"
                    }
                    
                    if prediction < randomNumber! {
                        labelHelp.text = "Increase the number"
                        labelRightToTry.text = "Right to try: \(remainingNumber)"
                    }
                }else if remainingNumber == 0 {
                    if prediction == randomNumber{
                        let result = true
                        performSegue(withIdentifier: "predictionToResult", sender: result)
                    }else{
                        let result = false
                        performSegue(withIdentifier: "predictionToResult", sender: result)
                    }
                    
                    
                    

                }
                numberField.text = ""
            }
        }
        
    }
    
}
