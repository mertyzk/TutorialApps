//
//  HomepageViewController.swift
//  UserDefaultLoginApplication
//
//  Created by Macbook Air on 7.02.2022.
//

import UIKit

class HomepageViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    
    let ud = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = true
        
        if let username = ud.string(forKey: "username"){
            resultLabel.text = username
        }
        
    }
    

    @IBAction func logoutBarButton(_ sender: Any) {
        
        ud.removeObject(forKey: "username")
        ud.removeObject(forKey: "password")
        
        exit(-1)
        
    }
    

}
