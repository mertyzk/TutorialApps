//
//  ViewController.swift
//  ArtBookCoreData
//
//  Created by Macbook Air on 16.02.2022.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let context = appDelegate.persistentContainer.viewContext
    
    var painterList = [Paintings]() // (Burada image listelemeyeceğimiz için tüm datayı getirmenin bir manası yok. tamamını getirmek istersek bunu kullanırız.

    /*var nameArray = [String]()
    var idArray = [UUID]()
    var selectedPaint = ""
    var selectedPaintingId : UUID?*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        
        //getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dataRead()
        tableView.reloadData()
        //NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name(rawValue: "newData"), object: nil)
    }
                 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
        let index = sender as? Int // Tıkladığımız satırın index bilgisi int olarak geliyor. veri gönderilecek controllerlara nesneleri ata.
        if segue.identifier == "toDetailsVC"{
            let gidilecekVC = segue.destination as! DetailsViewController
            gidilecekVC.painter = painterList[index!] // kisiler listesinin secilen elemanının bilgilerini karsi tarafa gonderdik.
        }
        
        /* if segue.identifier == "toDetailsVC"{
            let goToVc = segue.destination as! DetailsViewController
            goToVc.chosenPainting = selectedPaint
            goToVc.chosenPaintingId = selectedPaintingId
        }*/
    }
    
    /*@objc func addButtonClicked(){
        //selectedPaint = ""
        performSegue(withIdentifier: "toDetailsVC", sender: indexpa)
    }*/
    
   /* @objc func getData() {
        
        //nameArray.removeAll(keepingCapacity: false)
        //idArray.removeAll(keepingCapacity: false)
        
        /*let appDelegate = UIApplication.shared.delegate as! AppDelegate // AppDelegate'e ulaştık.
        let context = appDelegate.persistentContainer.viewContext*/
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings") // fetch (tut getir) -- sonuçlarını alacağımız bir istek
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            print("get all do içine girdi")
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    print("get all do içindeki fora girdi")
                                if let name = result.value(forKey: "name") as? String {
                                    self.nameArray.append(name)
                                }
                                
                                if let id = result.value(forKey: "id") as? UUID {
                                    self.idArray.append(id)
                                }
                                
                                self.tableView.reloadData()
                                
                            }
            }
            

        } catch {
            print("error")
        }
    }*/
    
    func dataRead() {
            do {
                painterList = try context.fetch(Paintings.fetchRequest())
            } catch {
                print("Data reading ERROR!")
            }
    } //bu metod tüm datayı getirir
    

}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return painterList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let incomingData = painterList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellName", for: indexPath)
        cell.textLabel?.text = incomingData.name

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //selectedPaint = nameArray[indexPath.row]
        //selectedPaintingId = idArray[indexPath.row]
        self.performSegue(withIdentifier: "toDetailsVC", sender: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            
            let silAction = UIContextualAction(style: .destructive, title: "Sil") {  (contextualAction, view, boolValue) in
                
                // silme kodları
                
                let kisi = self.painterList[indexPath.row] // seçilen satırdaki veriyi aldık. silmek istediğimiz kişiyi aldık.
                self.context.delete(kisi)
                appDelegate.saveContext()
                // ilk sildiğimiz anda arayüz güncellenmedi bunun için
                self.dataRead()
                self.tableView.reloadData()
                // artık silme işlemi olduktan sonra veriler yeniden çekilecek ve arayüz güncellenecek
            }
            return UISwipeActionsConfiguration(actions: [silAction])
        }
    
    /*func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            /*let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext*/
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
            let idString = idArray[indexPath.row].uuidString
                        
                        fetchRequest.predicate = NSPredicate(format: "id = %@", idString)
                        
                        fetchRequest.returnsObjectsAsFaults = false
                        
            do {
            let results = try context.fetch(fetchRequest)
                if results.count > 0 {
                    
                    for result in results as! [NSManagedObject] {
                        
                        if let id = result.value(forKey: "id") as? UUID {
                            
                            if id == idArray[indexPath.row] {
                                context.delete(result)
                                nameArray.remove(at: indexPath.row)
                                idArray.remove(at: indexPath.row)
                                self.tableView.reloadData()
                                
                                do {
                                    try context.save()
                                    
                                } catch {
                                    print("error")
                                }
                                
                                break
                                
                            }
                            
                        }
                        
                        
                    }
                    
                    
                }
            } catch {
                print("error")
            }
                        
                        
                        
                        
                    }
                }*/
    
    
}
