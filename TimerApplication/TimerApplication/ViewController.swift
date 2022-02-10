//
//  ViewController.swift
//  TimerApplication
//
//  Created by Macbook Air on 10.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var time:Timer?
    var counter:Int = 1

    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func startButton(_ sender: Any) {
        
        time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countStart), userInfo: nil, repeats: true)
    }
    
    @objc func countStart(){
        
        textLabel.text = String(counter)
        counter += 1
        
        if counter > 5{
            time?.invalidate()
            textLabel.text = "Time is up"
            counter = 1
        }
        
    }
    
}

