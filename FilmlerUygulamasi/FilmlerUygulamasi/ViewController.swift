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
        
        let k1 = Kategoriler(kategori_id: 1, kategori_ad: "dram")
        let k2 = Kategoriler(kategori_id: 2, kategori_ad: "aksiyon")
        let k3 = Kategoriler(kategori_id: 3, kategori_ad: "aşk")
        kategoriList.append(k1)
        kategoriList.append(k2)
        kategoriList.append(k3)
        
        kategoriTableView.delegate = self
        kategoriTableView.dataSource = self
        
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoryCellTableViewCell
        let incomingData = kategoriList[indexPath.row]
        cell.categoryNameLabel.text = incomingData.kategori_ad
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let incomingData = kategoriList[indexPath.row]
        print("\(incomingData.kategori_ad!) seçildi")
        self.performSegue(withIdentifier: "toFilm", sender: indexPath.row)
    }
    
    
    
    
    
}
