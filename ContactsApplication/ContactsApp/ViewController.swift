//
//  ViewController.swift
//  ContactsApp
//
//  Created by Macbook Air on 7.02.2022.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var contactsTableView: UITableView!
    
    var contactsList = [Kisiler]()
    
    var search = false
    var searchWord:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dbCopy()
       
        contactsTableView.delegate = self
        contactsTableView.dataSource = self
        
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if search {
            contactsList = KisilerDao().getBySearch(kisi_ad: searchWord!)
        }else{
            contactsList = KisilerDao().getByAll()
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
    
    func dbCopy(){
                let bundlePath = Bundle.main.path(forResource: "kisiler", ofType: ".sqlite")
                let targetPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
                let fileManager = FileManager.default
                let placeToCopy = URL(fileURLWithPath: targetPath).appendingPathComponent("kisiler.sqlite")
                
                if fileManager.fileExists(atPath: placeToCopy.path){
                    print("DB mevcut, kopyalama gereksiz.")
                }else{
                    do {
                        try fileManager.copyItem(atPath: bundlePath!, toPath: placeToCopy.path)
                    } catch{
                        print(error)
                    }
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
        
        cell.contactTextLabel.text = "\(person.kisi_ad!) - \(person.kisi_tel!)"

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDetail", sender: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {  (contextualAction, view, boolValue) in
            
            let person = self.contactsList[indexPath.row]
            KisilerDao().delete(kisi_id: person.kisi_id!)
            if self.search {
                self.contactsList = KisilerDao().getBySearch(kisi_ad: self.searchWord!)
            }else{
                self.contactsList = KisilerDao().getByAll()
            }
            self.contactsTableView.reloadData()
            
            

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
        }else{
            search = true
        }
    
        contactsList = KisilerDao().getBySearch(kisi_ad: searchWord!)
        contactsTableView.reloadData()
    }
}
