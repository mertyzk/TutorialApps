//
//  ViewController.swift
//  FlagApplication
//
//  Created by Macbook Air on 8.02.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        dbCopy()
        // Do any additional setup after loading the view.
    }
    
    func dbCopy(){
            let bundlePath = Bundle.main.path(forResource: "bayrakquiz", ofType: ".sqlite")
            let targetPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let fileManager = FileManager.default
            let placeToCopy = URL(fileURLWithPath: targetPath).appendingPathComponent("bayrakquiz.sqlite")
            
            if fileManager.fileExists(atPath: placeToCopy.path){
                print("DB mevcut, kopyalama gereksiz.")
            }else{
                do {
                    try fileManager.copyItem(atPath: bundlePath!, toPath: placeToCopy.path)
                } catch{
                    print(error)
                }
            }
    }

}

