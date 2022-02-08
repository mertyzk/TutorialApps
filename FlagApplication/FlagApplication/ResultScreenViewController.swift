//
//  ResultScreenViewController.swift
//  FlagApplication
//
//  Created by Macbook Air on 8.02.2022.
//

import UIKit

class ResultScreenViewController: UIViewController {

    @IBOutlet weak var trueFalseResultsLabel: UILabel!
    @IBOutlet weak var successRateLabel: UILabel!
    
    var trueAnswer:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        
        if let t = trueAnswer{
            trueFalseResultsLabel.text = "\(t) TRUE \(5-t) FALSE"
            successRateLabel.text = "% \(t*100/5) SUCCESS RATE"
        }

    }
    
    @IBAction func tryAgainButton(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
}
