//
//  UpdateContactViewController.swift
//  ContactsApp
//
//  Created by Macbook Air on 7.02.2022.
//

import UIKit

class UpdateContactViewController: UIViewController {

    
    @IBOutlet weak var contactNameTextField: UITextField!
    @IBOutlet weak var contactPhoneTextField: UITextField!
    
    var person:Kisiler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let p = person{
            contactNameTextField.text = p.kisi_ad
            contactPhoneTextField.text = p.kisi_tel
        }
    }
    
    @IBAction func updateButton(_ sender: Any) {
        
        if let p = person, let name = contactNameTextField.text, let tel = contactPhoneTextField.text{
            KisilerDao().update(kisi_id: p.kisi_id!, kisi_ad: name, kisi_tel: tel)
        }
    }
    
}
