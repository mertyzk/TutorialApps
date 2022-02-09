//
//  ViewController.swift
//  FilmlerUygulamasi
//
//  Created by Macbook Air on 8.02.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var kategoriTableView: UITableView!
    
    var kategoriList = [Kategoriler]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dbCopy()
        
        kategoriTableView.delegate = self
        kategoriTableView.dataSource = self
        
        kategoriList = KategorilerDao().getByAll()
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let index = sender as? Int
        let goToVc = segue.destination as! FilmViewController
        goToVc.kategori = kategoriList[index!]
    }
    
    
    func dbCopy(){
            let bundlePath = Bundle.main.path(forResource: "filmler", ofType: ".sqlite")
            let targetPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let fileManager = FileManager.default
            let placeToCopy = URL(fileURLWithPath: targetPath).appendingPathComponent("filmler.sqlite")
            
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
        kategoriList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let incomingData = kategoriList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoryCellTableViewCell
        cell.categoryNameLabel.text = incomingData.kategori_ad
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toFilm", sender: indexPath.row)
    }
    
    
    
    
    
}
