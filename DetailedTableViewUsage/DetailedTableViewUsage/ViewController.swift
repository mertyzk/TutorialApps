//
//  ViewController.swift
//  DetailedTableViewUsage
//
//  Created by Macbook Air on 6.02.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var yemeklerTableView: UITableView!
    
    var yemekler = [Yemekler]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        yemeklerTableView.dataSource = self
        yemeklerTableView.delegate = self
        
        let y1 = Yemekler(yemekId: 1, yemekAdi: "Ayran", yemekResimAdi: "ayran", yemekFiyat: 3.0)
        let y2 = Yemekler(yemekId: 2, yemekAdi: "Baklava", yemekResimAdi: "baklava", yemekFiyat: 20.0)
        let y3 = Yemekler(yemekId: 3, yemekAdi: "Fanta", yemekResimAdi: "fanta", yemekFiyat: 5.0)
        let y4 = Yemekler(yemekId: 4, yemekAdi: "Izgara Somon", yemekResimAdi: "izgarasomon", yemekFiyat: 25.0)
        let y5 = Yemekler(yemekId: 5, yemekAdi: "Izgara Tavuk", yemekResimAdi: "izgaratavuk", yemekFiyat: 15.0)
        let y6 = Yemekler(yemekId: 6, yemekAdi: "Kadayıf", yemekResimAdi: "kadayif", yemekFiyat: 16.0)
        let y7 = Yemekler(yemekId: 7, yemekAdi: "Kahve", yemekResimAdi: "kahve", yemekFiyat: 6.0)
        let y8 = Yemekler(yemekId: 8, yemekAdi: "Köfte", yemekResimAdi: "kofte", yemekFiyat: 15.0)
        let y9 = Yemekler(yemekId: 9, yemekAdi: "Lazanya", yemekResimAdi: "lazanya", yemekFiyat: 21.0)
        let y10 = Yemekler(yemekId: 10, yemekAdi: "Makarna", yemekResimAdi: "makarna", yemekFiyat: 13.0)
        let y11 = Yemekler(yemekId: 11, yemekAdi: "Pizza", yemekResimAdi: "pizza", yemekFiyat: 18.0)
        let y12 = Yemekler(yemekId: 12, yemekAdi: "Su", yemekResimAdi: "su", yemekFiyat: 1.0)
        let y13 = Yemekler(yemekId: 13, yemekAdi: "Sütlaç", yemekResimAdi: "sutlac", yemekFiyat: 10.0)
        let y14 = Yemekler(yemekId: 14, yemekAdi: "Tiramisu", yemekResimAdi: "tiramisu", yemekFiyat: 16.0)
        yemekler.append(y1)
        yemekler.append(y2)
        yemekler.append(y3)
        yemekler.append(y4)
        yemekler.append(y5)
        yemekler.append(y6)
        yemekler.append(y7)
        yemekler.append(y8)
        yemekler.append(y9)
        yemekler.append(y10)
        yemekler.append(y11)
        yemekler.append(y12)
        yemekler.append(y13)
        yemekler.append(y14)
        
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource, YemekTableViewCellProtocol{

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yemekler.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let hucre = tableView.dequeueReusableCell(withIdentifier: "yemekHucre", for: indexPath) as! YemekTableViewCell
        let gelenVeri = yemekler[indexPath.row]
        hucre.yemekAdiLabel.text = gelenVeri.yemekAdi
        hucre.yemekFiyatLabel.text = String(format: "%.0f", gelenVeri.yemekFiyat!) + " TL"
        hucre.yemekResimImageView.image = UIImage(named: "\(gelenVeri.yemekResimAdi!)")
        hucre.hucreProtokol = self
        hucre.indexPath = indexPath
        return hucre
    }
    
    func siparisVer(indexPath: IndexPath) {
        let gelenVeri = yemekler[indexPath.row]
        print("\(gelenVeri.yemekAdi!) sipariş verildi. Fiyat \(gelenVeri.yemekFiyat!)")
    }
    
    
}
