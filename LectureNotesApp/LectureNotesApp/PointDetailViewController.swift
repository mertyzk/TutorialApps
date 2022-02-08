//
//  PointDetailViewController.swift
//  LectureNotesApp
//
//  Created by Macbook Air on 8.02.2022.
//

import UIKit

class PointDetailViewController: UIViewController {

    @IBOutlet weak var lessonNameTextField: UITextField!
    @IBOutlet weak var vizeTextField: UITextField!
    @IBOutlet weak var finalTextField: UITextField!
    
    var point:Notlar?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let p = point {
            lessonNameTextField.text = p.ders_adi
            vizeTextField.text = String(p.not1!)
            finalTextField.text = String(p.not2!)
        }
    }
    
    @IBAction func updateButton(_ sender: Any) {
        if let p = point, let name = lessonNameTextField.text ,let vize = vizeTextField.text ,let final = finalTextField.text {
            
            if let p1 = Int(vize) , let p2 = Int(final) {
                
                PointsDao().update(not_id: p.not_id!, ders_adi: name, not1: p1, not2: p2)
                
            }
        }
    }
    @IBAction func deleteButton(_ sender: Any) {
        if let p = point {
            PointsDao().delete(not_id: p.not_id!)
        }
    }
    

}
