//
//  ViewController.swift
//  ContactsApp
//
//  Created by Macbook Air on 7.02.2022.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate

class ViewController: UIViewController {
    
    let context = appDelegate.persistentContainer.viewContext

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var contactsTableView: UITableView!
    
    var contactsList = [Contacts]()
    
    var search = false
    var searchWord:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        contactsTableView.delegate = self
        contactsTableView.dataSource = self
        
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if search{
            getBySearch(contact_ad: searchWord!)
        }else{
            getByAll()
        }
        contactsTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let index = sender as? Int
        
        
        if segue.identifier == "toDetail"{
            let goingVC = segue.destination as! DetailContactViewController
            goingVC.person = contactsList[index!]
        }
        
        if segue.identifier == "toUpdate"{
            let goingVC = segue.destination as! UpdateContactViewController
            goingVC.person = contactsList[index!]
        }
    }
    
    func getByAll() {
        do {
            contactsList = try context.fetch(Contacts.fetchRequest())
        } catch {
            print("Error!")
        }
    }
    
    func getBySearch(contact_ad:String) {
        
        let fetchRequest:NSFetchRequest<Contacts> = Contacts.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "contact_ad CONTAINS %@", contact_ad)
        
        do {
            contactsList = try context.fetch(fetchRequest)
        } catch {
            print("Error!")
        }
    }


}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let person = contactsList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "kisiHucre", for: indexPath) as! ContactTableViewCell
        
        cell.contactTextLabel.text = "\(person.contact_ad!) - \(person.contact_tel!)"

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDetail", sender: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {  (contextualAction, view, boolValue) in
            
            let person = self.contactsList[indexPath.row]
            self.context.delete(person)
            appDelegate.saveContext()
            
            if self.search{
                self.getBySearch(contact_ad: self.searchWord!)
            }else{
                self.getByAll()
            }
        }
        
        let updateAction = UIContextualAction(style: .normal, title: "Update") {  (contextualAction, view, boolValue) in
            
             print("Update clicked  \(self.contactsList[indexPath.row])")
             
             self.performSegue(withIdentifier: "toUpdate", sender: indexPath.row)
        }

        return UISwipeActionsConfiguration(actions: [deleteAction,updateAction])
    }
}

extension ViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Search result : \(searchText)")
        
        searchWord = searchText
        
        if searchText == ""{
            search = false
            getByAll()
        }else{
            search = true
            getBySearch(contact_ad: searchWord!)
        }
        contactsTableView.reloadData()
    }
}
