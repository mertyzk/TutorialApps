//
//  ViewController.swift
//  UserDefaultBasicApplication
//
//  Created by Macbook Air on 7.02.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var counterStatusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let variable = UserDefaults.standard
        
        var counter = variable.integer(forKey: "counter")
        
        counter += 1
        
        variable.set(counter, forKey: "counter")
        
        counterStatusLabel.text = "Counter: \(counter)"
        
        
        
        
    }


}

