//
//  PointAddViewController.swift
//  LectureNotesApp
//
//  Created by Macbook Air on 8.02.2022.
//

import UIKit

class PointAddViewController: UIViewController {

    @IBOutlet weak var lessonNameTextField: UITextField!
    @IBOutlet weak var vizeTextField: UITextField!
    @IBOutlet weak var finalTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
   
    
    @IBAction func addButtonClick(_ sender: Any) {
        if let name = lessonNameTextField.text, let vize = vizeTextField.text, let final = finalTextField.text{
            
            if let p1 = Int(vize), let p2 = Int(final){
                PointsDao().add(ders_adi: name, not1: p1, not2: p2)
            }
        }
    }
    
}
