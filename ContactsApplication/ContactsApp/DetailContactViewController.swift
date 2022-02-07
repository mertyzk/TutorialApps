//
//  DetailContactViewController.swift
//  ContactsApp
//
//  Created by Macbook Air on 7.02.2022.
//

import UIKit

class DetailContactViewController: UIViewController {

    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var contactPhonoLabel: UILabel!
    
    var person:Contacts?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let p = person {
            contactNameLabel.text = p.contact_ad
            contactPhonoLabel.text = p.contact_tel
        }
    }


}
