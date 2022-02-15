//
//  ViewController.swift
//  BasicCalculator
//
//  Created by Macbook Air on 14.02.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var firstNumberTextField: UITextField!
    @IBOutlet weak var secondNumberTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func sumButton(_ sender: Any) {
        if let n1 = Int(firstNumberTextField.text!), let n2 = Int(secondNumberTextField.text!){
            resultLabel.text = String(n1 + n2)
        }
    }
    
    @IBAction func diffButton(_ sender: Any) {
        if let n1 = Int(firstNumberTextField.text!), let n2 = Int(secondNumberTextField.text!){
            resultLabel.text = String(n1 - n2)
        }
    }
    
    @IBAction func multipButton(_ sender: Any) {
        if let n1 = Int(firstNumberTextField.text!), let n2 = Int(secondNumberTextField.text!){
            resultLabel.text = String(n1 * n2)
        }
    }
    
    @IBAction func divideButton(_ sender: Any) {
        if let n1 = Int(firstNumberTextField.text!), let n2 = Int(secondNumberTextField.text!){
            resultLabel.text = String(n1 / n2)
        }
    }
    
}

