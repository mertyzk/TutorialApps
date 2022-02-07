//
//  UpdateContactViewController.swift
//  ContactsApp
//
//  Created by Macbook Air on 7.02.2022.
//

import UIKit

class UpdateContactViewController: UIViewController {

    let context = appDelegate.persistentContainer.viewContext
    
    @IBOutlet weak var contactNameTextField: UITextField!
    @IBOutlet weak var contactPhoneTextField: UITextField!
    
    var person:Contacts?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let p = person {
            contactNameTextField.text = p.contact_ad
            contactPhoneTextField.text = p.contact_tel
        }
    }
    
    @IBAction func updateButton(_ sender: Any) {
        if let p = person ,let name = contactNameTextField.text, let tel = contactPhoneTextField.text{
            
            p.contact_ad = name
            p.contact_tel = tel
            
            appDelegate.saveContext()
        }
    }
    
}
