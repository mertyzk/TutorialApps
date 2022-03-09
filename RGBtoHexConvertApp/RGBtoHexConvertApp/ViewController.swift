//
//  ViewController.swift
//  RGBtoHexConvertApp
//
//  Created by Macbook Air on 7.03.2022.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var blueTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var convertButtonOutlet: UIButton!
    @IBOutlet weak var selectedColorLabel: UILabel!
    @IBOutlet weak var segmentOutlet: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        convertButtonOutlet.reloadInputViews()
    }
    
    
    @IBAction func segmentAction(_ sender: Any) {
        resultLabel.text?.removeAll()
        redTextField.text?.removeAll()
        greenTextField.text?.removeAll()
        blueTextField.text?.removeAll()
        selectedColorLabel.backgroundColor = UIColor.white
        
        if segmentOutlet.selectedSegmentIndex == 0{
            convertButtonOutlet.setTitle("RGB -> HEX", for: UIControl.State.normal)
        }else{
            convertButtonOutlet.setTitle("HEX -> RGB", for: UIControl.State.normal)
        }
    }

    
    @IBAction func convertButtonClicked(_ sender: Any) {
       
        if segmentOutlet.selectedSegmentIndex == 0 {
            convertRgbToHex()
        }else{
            convertHexToRgb()
        }
        
    }

}

extension ViewController{
    
    func convertRgbToHex(){
        /*if let redValue = UInt8(redTextField.text!){
            if let greenValue = UInt8(greenTextField.text!){
                if let blueValue = UInt8(blueTextField.text!){
                    // değerler düzgün girildi
                    
                    let redHex = String(format: "%2X", redValue)
                    let greenHex = String(format: "%2X", greenValue)
                    let blueHex = String(format: "%2X", blueValue)
                    
                    resultLabel.text = "HEX COLOR: #\(redHex)\(greenHex)\(blueHex)"
                    selectedColorLabel.backgroundColor = UIColor(red: CGFloat(redValue)/255, green: CGFloat(greenValue)/255, blue: CGFloat(blueValue)/255, alpha: 1)
                }
            }
        }*/
        
        // REFACTOR
        
        guard let redValue = UInt8(redTextField.text!) else{
            return
        }
        guard let greenValue = UInt8(greenTextField.text!) else{
            return
        }
        guard let blueValue = UInt8(blueTextField.text!) else{
            return
        }
        
        let redHex = String(format: "%2X", redValue)
        let greenHex = String(format: "%2X", greenValue)
        let blueHex = String(format: "%2X", blueValue)
        
        resultLabel.text = "HEX COLOR: #\(redHex)\(greenHex)\(blueHex)"
        selectedColorLabel.backgroundColor = UIColor(red: CGFloat(redValue)/255, green: CGFloat(greenValue)/255, blue: CGFloat(blueValue)/255, alpha: 1)
        
        
        
        
    }
    
    func convertHexToRgb(){
        /*if let redValue = UInt8(redTextField.text!, radix: 16){
            if let greenValue = UInt8(greenTextField.text!, radix: 16){
                if let blueValue = UInt8(blueTextField.text!, radix: 16){
                    resultLabel.text = "RGB COLOR: \(redValue)\(greenValue)\(blueValue)"
                    selectedColorLabel.backgroundColor = UIColor(red: CGFloat(redValue)/255, green: CGFloat(greenValue)/255, blue: CGFloat(blueValue)/255, alpha: 1)
                }
            }
        }*/
        
        // REFACTOR
        
        guard let redValue = UInt8(redTextField.text!) else{
            return
        }
        guard let greenValue = UInt8(greenTextField.text!) else{
            return
        }
        guard let blueValue = UInt8(blueTextField.text!) else{
            return
        }
        
        resultLabel.text = "RGB COLOR: \(redValue)\(greenValue)\(blueValue)"
        selectedColorLabel.backgroundColor = UIColor(red: CGFloat(redValue)/255, green: CGFloat(greenValue)/255, blue: CGFloat(blueValue)/255, alpha: 1)
        
    }
    
}

