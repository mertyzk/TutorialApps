//
//  ViewController.swift
//  CollectionViewApp
//
//  Created by Macbook Air on 6.02.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var filmCollectionView: UICollectionView!
    
    var filmler = [Filmler]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let design:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = self.filmCollectionView.frame.size.width
        
        design.sectionInset = UIEdgeInsets(top: 11, left: 11, bottom: 11, right: 11)
        
        design.minimumLineSpacing = 5
        design.minimumInteritemSpacing = 5
        
        let cellWidth = (width-80)/2
        
        design.itemSize = CGSize(width: cellWidth, height: cellWidth*1.80)
        
        filmCollectionView!.collectionViewLayout = design
        
        
        filmCollectionView.delegate = self
        filmCollectionView.dataSource = self
        
        let film1 = Filmler(filmId: 1, filmBaslik: "Django", filmResimAdi: "django", filmFiyat: 15.99)
        let film2 = Filmler(filmId: 2, filmBaslik: "Bir Zamanlar Anadoluda", filmResimAdi: "birzamanlaranadoluda", filmFiyat: 27.99)
        let film3 = Filmler(filmId: 3, filmBaslik: "Inception", filmResimAdi: "inception", filmFiyat: 34.99)
        let film4 = Filmler(filmId: 4, filmBaslik: "Interstellar", filmResimAdi: "interstellar", filmFiyat: 9.99)
        let film5 = Filmler(filmId: 5, filmBaslik: "The hateful eight", filmResimAdi: "thehatefuleight", filmFiyat: 18.99)
        let film6 = Filmler(filmId: 6, filmBaslik: "The Pianist", filmResimAdi: "thepianist", filmFiyat: 45.99)
        
        filmler.append(film1)
        filmler.append(film2)
        filmler.append(film3)
        filmler.append(film4)
        filmler.append(film5)
        filmler.append(film6)
        
        
    }
}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, CollectionViewFilmCellProtocol {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filmler.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filmHucre", for: indexPath) as! CollectionViewFilmCell
        
        let incomingData = filmler[indexPath.item]
        
        cell.filmimageView.image = UIImage(named: "\(incomingData.filmResimAdi!)")
        cell.filmAdiLabel.text = incomingData.filmBaslik!
        cell.filmFiyatLabel.text = "\(incomingData.filmFiyat!) TL"
        
        cell.hucreProtocol = self
        cell.indexPath = indexPath
        
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let film = filmler[indexPath.item]
        print("\(film.filmBaslik!) adlı \(film.filmFiyat!) fiyatlı ürünü inceliyorsunuz.")
    }
    
    func sepeteEkle(indexPath: IndexPath) {
        let film = filmler[indexPath.item]
        print("\(film.filmBaslik!) filmi sipariş verildi.")
    }
    
    
    
}
