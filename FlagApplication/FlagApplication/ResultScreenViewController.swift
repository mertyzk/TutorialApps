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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func tryAgainButton(_ sender: Any) {
        
        navigationController?.popToRootViewController(animated: true)
    }
    
}
