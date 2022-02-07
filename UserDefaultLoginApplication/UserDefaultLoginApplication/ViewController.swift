//
//  ViewController.swift
//  UserDefaultLoginApplication
//
//  Created by Macbook Air on 7.02.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let variable = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let username = variable.string(forKey: "username")
        let password = variable.string(forKey: "password")
        
        if (username?.isEmpty == false) && (password?.isEmpty == false){
            performSegue(withIdentifier: "loginToHomepage", sender: nil)
        }
        
    }

    @IBAction func clickLoginButton(_ sender: Any) {
        if let username = userNameTextField.text, let password = passwordTextField.text{
            if username == "administrator" && password == "123321"{
                
                variable.set(username, forKey: "username")
                variable.set(password, forKey: "password")
                
                performSegue(withIdentifier: "loginToHomepage", sender: nil)
            }else{
                print("hata")
            }
        }
    }
    
    
}

