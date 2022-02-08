//
//  QuizScreenViewController.swift
//  FlagApplication
//
//  Created by Macbook Air on 8.02.2022.
//

import UIKit

class QuizScreenViewController: UIViewController {

    @IBOutlet weak var labelTrue: UILabel!
    @IBOutlet weak var labelFalse: UILabel!
    @IBOutlet weak var labelQuestion: UILabel!
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    
    var questions = [Bayraklar]()
    var wrongOption = [Bayraklar]()
    var trueQuestion = Bayraklar()
    var questionCounter = 0
    var trueAnswerCounter = 0
    var falseAnswerCounter = 0
    
    var options = [Bayraklar]()
    var optionsMixed = Set <Bayraklar>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        flagImageView.layer.borderWidth = 5
        flagImageView.layer.borderColor = UIColor.gray.cgColor

        questions = BayraklarDao().random5Question()
        installQuestion()
        
    }

    func installQuestion(){
        labelQuestion.text = "QUESTION \(questionCounter+1)"
        labelTrue.text = "TRUE: \(trueAnswerCounter)"
        labelFalse.text = "FALSE: \(falseAnswerCounter)"
        
        trueQuestion = questions[questionCounter]
        
        flagImageView.image = UIImage(named: trueQuestion.bayrak_resim!)
        
        wrongOption = BayraklarDao().random3FalseQuestion(bayrak_id: trueQuestion.bayrak_id!)
        
        optionsMixed.removeAll()
        
        optionsMixed.insert(trueQuestion)
        optionsMixed.insert(wrongOption[0])
        optionsMixed.insert(wrongOption[1])
        optionsMixed.insert(wrongOption[2])
        
        options.removeAll()
        
        for om in optionsMixed {
            options.append(om)
        }
        
        button1.setTitle(options[0].bayrak_ad, for: .normal)
        button2.setTitle(options[1].bayrak_ad, for: .normal)
        button3.setTitle(options[2].bayrak_ad, for: .normal)
        button4.setTitle(options[3].bayrak_ad, for: .normal)
        
    }
    
    func trueControl(button:UIButton){
        let buttonText = button.titleLabel?.text
        let trueAnswer = trueQuestion.bayrak_ad
        
        print("Button text: \(buttonText!)")
        print("True answer: \(trueAnswer!)")
        
        if trueAnswer == buttonText{
            trueAnswerCounter += 1
        }else{
            falseAnswerCounter += 1
        }
        
        labelTrue.text = "TRUE: \(trueAnswerCounter)"
        labelFalse.text = "FALSE: \(falseAnswerCounter)"
          
    }
    
    func questionCounterControl(){
        questionCounter += 1
        questionCounter < 5 ? installQuestion() : performSegue(withIdentifier: "toResultScreen", sender: nil)
    }
    
    @IBAction func clickButton1(_ sender: Any) {
        trueControl(button: button1)
        questionCounterControl()
    }
    
    @IBAction func clickButton2(_ sender: Any) {
        trueControl(button: button2)
        questionCounterControl()
    }
    
    @IBAction func clickButton3(_ sender: Any) {
        trueControl(button: button3)
        questionCounterControl()
    }
    
    @IBAction func clickButton4(_ sender: Any) {
        trueControl(button: button4)
        questionCounterControl()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let goToVc = segue.destination as! ResultScreenViewController
        goToVc.trueAnswer = trueAnswerCounter
    }
    
}
