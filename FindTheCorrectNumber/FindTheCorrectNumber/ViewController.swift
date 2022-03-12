//
//  ViewController.swift
//  FindTheCorrectNumber
//
//  Created by Macbook Air on 12.03.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var generatedNumberTextField: UITextField!
    @IBOutlet weak var successImageView: UIImageView!
    @IBOutlet weak var saveOutlet: UIButton!
    @IBOutlet weak var guessNumberTextField: UITextField!
    @IBOutlet weak var statusImageview: UIImageView!
    @IBOutlet weak var tryButtonOutlet: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var imageViewStar1: UIImageView!
    @IBOutlet weak var imageViewStar2: UIImageView!
    @IBOutlet weak var imageViewStar3: UIImageView!
    @IBOutlet weak var imageViewStar4: UIImageView!
    @IBOutlet weak var imageViewStar5: UIImageView!
    
    var stars : [UIImageView] = [UIImageView]()
    let maxTry : Int = 5
    var tryCount : Int = 0
    var generatedNumber : Int = -1
    var success : Bool = false
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stars = [imageViewStar1,imageViewStar2,imageViewStar3,imageViewStar4,imageViewStar5]
        successImageView.isHidden = true
        statusImageview.isHidden = true
        resultLabel.isHidden = true
        tryButtonOutlet.isEnabled = false
        generatedNumberTextField.isSecureTextEntry = true
    }
    
    @IBAction func saveButton(_ sender: Any) {
        
        if generatedNumberTextField.text?.isEmpty != true {
            if let number = Int(generatedNumberTextField.text!){
                successImageView.isHidden = false
                generatedNumber = number
                tryButtonOutlet.isEnabled = true
                generatedNumberTextField.isEnabled = false
                saveOutlet.isEnabled = false
            }
        }else{
            successImageView.isHidden = false
            successImageView.image = UIImage(named: "error")
            alertFunc(title: "ERROR", message: "Enter a number!")
            
        }
    }
    
    
    @IBAction func tryButton(_ sender: Any) {
        
        if success == true || tryCount > maxTry {
            return
        }
        
        if guessNumberTextField.text?.isEmpty != true {
            if let incomingNumber = Int(guessNumberTextField.text!){
                tryCount += 1
                stars[tryCount-1].image = UIImage(named: "star")
                
                if incomingNumber > generatedNumber{
                    statusImageview.isHidden = false
                    statusImageview.image = UIImage(named: "download")
                    guessNumberTextField.backgroundColor = UIColor.red
                }else if incomingNumber < generatedNumber{
                    statusImageview.isHidden = false
                    statusImageview.image = UIImage(named: "upload")
                }else{
                    statusImageview.isHidden = false
                    statusImageview.image = UIImage(named: "correctHand")
                    saveOutlet.isEnabled = true
                    resultLabel.isHidden = false
                    resultLabel.textColor = UIColor.red
                    resultLabel.text = "CONGRATULATIONS"
                    guessNumberTextField.backgroundColor = UIColor.green
                    generatedNumberTextField.isSecureTextEntry = false
                    success = true
                    return
                }
            }
        }else{
            statusImageview.isHidden = false
            statusImageview.image = UIImage(named: "error")
            alertFunc(title: "ERROR", message: "Enter a number!")
        }
        
        if tryCount == maxTry{
            statusImageview.isHidden = false
            statusImageview.image = UIImage(named: "error")
            resultLabel.isHidden = false
            resultLabel.textColor = UIColor.red
            resultLabel.text = "YOU LOSE"
            generatedNumberTextField.isSecureTextEntry = false
            return
        }
    }
}

extension ViewController{
    func alertFunc(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true,completion: nil)
    }
}
