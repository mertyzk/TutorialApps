//
//  ResultScreenViewController.swift
//  GuessTheNumber
//
//  Created by Macbook Air on 5.02.2022.
//

import UIKit

class ResultScreenViewController: UIViewController {

    @IBOutlet weak var imageViewResult: UIImageView!
    @IBOutlet weak var labelResult: UILabel!
    var result:Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.hidesBackButton = true
        self.navigationItem.title = "RESULT SCREEN"
        print(result!)
        
        if result! {
            labelResult.text = "YOU WİN!"
            imageViewResult.image = UIImage(named: "mutlu_resim")
        }else{
            labelResult.text = "YOU LOSE!"
            imageViewResult.image = UIImage(named: "uzgun_resim")
        }
    }
    
    @IBAction func buttonPlayAgain(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }

}
