//
//  ViewController.swift
//  ArtBookCoreData
//
//  Created by Macbook Air on 16.02.2022.
//

import UIKit
import CoreData

//let appDelegate = UIApplication.shared.delegate as! AppDelegate

var appDelegate = UIApplication.shared.delegate as! AppDelegate // AppDelegate'e ulaştık.
var context = appDelegate.persistentContainer.viewContext
var fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings") // fetch (tut getir) -- sonuçlarını alacağımız bir istek


class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    // var painterList = [Paintings]() (Burada image listelemeyeceğimiz için tüm datayı getirmenin bir manası yok. tamamını getirmek istersek bunu kullanırız.

    //let context = appDelegate.persistentContainer.viewContext
    
    var nameArray = [String]()
    var idArray = [UUID]()
    var selectedPaint = ""
    var selectedPaintingId : UUID?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
        tableView.reloadData()
        //NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name(rawValue: "newData"), object: nil)
    }
                                                                                          
    @objc func addButtonClicked(){
        selectedPaint = ""
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    @objc func getData() {
        
        nameArray.removeAll(keepingCapacity: false)
        idArray.removeAll(keepingCapacity: false)
        
        /*let appDelegate = UIApplication.shared.delegate as! AppDelegate // AppDelegate'e ulaştık.
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings") // fetch (tut getir) -- sonuçlarını alacağımız bir istek
        fetchRequest.returnsObjectsAsFaults = false*/
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(fetchRequest) // geri bir dizi döndürecek.
            
            for result in results as! [NSManagedObject] { // aslında bir any dizisi result. tek bir result'a odaklanabilmek için NSManagedObject'e cast ettik.
                if let name = result.value(forKey: "name") as? String{
                    self.nameArray.append(name)
                }
                
                if let id = result.value(forKey: "id") as? UUID {
                    self.idArray.append(id)
                }
                self.tableView.reloadData()
            }
            
        } catch {
            print("Data reading ERROR!")
        }
    }
    
    /*func dataRead() {
            do {
                painterList = try context.fetch(Paintings.fetchRequest())
            } catch {
                print("Data reading ERROR!")
            }
    }*/ //bu metod tüm datayı getirir
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC"{
            let goToVc = segue.destination as! DetailsViewController
            goToVc.chosenPainting = selectedPaint
            goToVc.chosenPaintingId = selectedPaintingId
        }
    }
}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellName", for: indexPath)
        let incomingData = nameArray[indexPath.row]
        cell.textLabel?.text = incomingData

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPaint = nameArray[indexPath.row]
        selectedPaintingId = idArray[indexPath.row]
        self.performSegue(withIdentifier: "toDetailsVC", sender: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            /*let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")*/
            let idString = idArray[indexPath.row].uuidString
            fetchRequest.predicate = NSPredicate(format: "id = %@", idString)
            fetchRequest.returnsObjectsAsFaults = false
            do {
                let results = try context.fetch(fetchRequest)
                if results.count > 0 {
                    for result in results as! [NSManagedObject]{
                        if let id = result.value(forKey: "id") as? UUID{
                            if id == idArray[indexPath.row]{
                                context.delete(result)
                                nameArray.remove(at: indexPath.row)
                                idArray.remove(at: indexPath.row)
                                self.tableView.reloadData()
                                do{
                                    try context.save()
                                } catch{
                                    print(error.localizedDescription)
                                }
                                break // id kullanamazsak for loop'tan çıkmak için break kullanırız.
                            }
                        }
                    }
                }
            } catch  {
                print(error.localizedDescription)
            }
            
        }
    }
    
    
}
