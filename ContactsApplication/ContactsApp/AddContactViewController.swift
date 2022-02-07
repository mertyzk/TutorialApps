//
//  AddContactViewController.swift
//  ContactsApp
//
//  Created by Macbook Air on 7.02.2022.
//

import UIKit

class AddContactViewController: UIViewController {

    let context = appDelegate.persistentContainer.viewContext
    
    @IBOutlet weak var contactNameTextField: UITextField!
    @IBOutlet weak var contactPhoneTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func addButton(_ sender: Any) {
        if let name = contactNameTextField.text, let tel = contactPhoneTextField.text{
            let person = Contacts(context: context)
            person.contact_ad = name
            person.contact_tel = tel
            appDelegate.saveContext()
        }
    }
    
}
