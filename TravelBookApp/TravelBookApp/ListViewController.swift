//
//  ListViewController.swift
//  TravelBookApp
//
//  Created by Macbook Air on 17.02.2022.
//

import UIKit
import CoreData

class ListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var titleArray = [String]()
    var idArray = [UUID]()
    
    var choosenTitle = ""
    var choosenId : UUID?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toViewController"{
            let goToVc = segue.destination as! ViewController
            goToVc.selectedTitle = choosenTitle
            goToVc.selectedTitleID = choosenId
        }
    }
    

}

extension ListViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellName", for: indexPath)
        cell.textLabel?.text = titleArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        choosenTitle = titleArray[indexPath.row]
        choosenId = idArray[indexPath.row]
        self.performSegue(withIdentifier: "toViewController", sender: indexPath.row)
    }
    
    func getData(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Places")
        request.returnsObjectsAsFaults = false
        do{
        let results = try context.fetch(request)
            
            if results.count > 0 {
                
                self.titleArray.removeAll(keepingCapacity: false)
                self.idArray.removeAll(keepingCapacity: false)
                
                for result in results as! [NSManagedObject]{
                    
                    if let title = result.value(forKey: "title") as? String{
                        self.titleArray.append(title)
                    }
                    
                    if let id = result.value(forKey: "id") as? UUID{
                        self.idArray.append(id)
                    }
                    
                    tableView.reloadData()
                }
                
            }
            
        } catch{
            print(error.localizedDescription)
        }
        
    }
    
    @objc func addButtonClicked(){
        choosenTitle = ""
        self.performSegue(withIdentifier: "toViewController", sender: nil)
    }
}
