//
//  ViewController.swift
//  ContactsApp
//
//  Created by Macbook Air on 7.02.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var contactsTableView: UITableView!
    
    var list = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        list = ["Ali","Veli","Selin","Kerem","Hasan","Serhat","Yağmur","Kübra","Akın","Orkun","Fatma"]
        
        contactsTableView.delegate = self
        contactsTableView.dataSource = self
        
        searchBar.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail"{
            
        }
        
        if segue.identifier == "toUpdate"{
            
        }
    }


}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "kisiHucre", for: indexPath) as! ContactTableViewCell
        
        cell.contactTextLabel.text = list[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDetail", sender: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {  (contextualAction, view, boolValue) in
            
             print("Delete cliked \(self.list[indexPath.row])")
        }
        
        let updateAction = UIContextualAction(style: .normal, title: "Update") {  (contextualAction, view, boolValue) in
            
             print("Update clicked  \(self.list[indexPath.row])")
             
             self.performSegue(withIdentifier: "toUpdate", sender: indexPath.row)
        }

        return UISwipeActionsConfiguration(actions: [deleteAction,updateAction])
    }
}

extension ViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Search result : \(searchText)")
    }
}
