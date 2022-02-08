//
//  FilmViewController.swift
//  FilmlerUygulamasi
//
//  Created by Macbook Air on 8.02.2022.
//

import UIKit

class FilmViewController: UIViewController {

    @IBOutlet weak var filmCollectionView: UICollectionView!
    
    var filmlist = [Filmler]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let f11 = Filmler(film_id: 1, film_ad: "test", film_yil: 2022, film_resim: "django", kategori: Kategoriler(), yonetmen: Yonetmenler())
        let f12 = Filmler(film_id: 2, film_ad: "fffff", film_yil: 2005, film_resim: "inception", kategori: Kategoriler(), yonetmen: Yonetmenler())
        let f13 = Filmler(film_id: 3, film_ad: "cccc", film_yil: 1992, film_resim: "interstellar", kategori: Kategoriler(), yonetmen: Yonetmenler())
        filmlist.append(f11)
        filmlist.append(f12)
        filmlist.append(f13)
        
        filmCollectionView.delegate = self
        filmCollectionView.dataSource = self
        
        let design:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = self.filmCollectionView.frame.size.width
        design.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let cellWidth = (width-30)/2
        design.itemSize = CGSize(width: cellWidth, height: cellWidth*1.652)
        design.minimumInteritemSpacing = 10 // yatayda aralarındaki boşluk
        design.minimumLineSpacing = 10 // alt alta arasındaki boşluk
        
        filmCollectionView.collectionViewLayout = design
       
    }
}

extension FilmViewController:UICollectionViewDelegate,UICollectionViewDataSource,FilmHucreCollectionViewCellProtocol{

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filmlist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "filmHucre", for: indexPath) as! FilmHucreCollectionViewCell
        let incomingData = filmlist[indexPath.item]
        item.filmAdiLabel.text = incomingData.film_ad
        item.filmFiyatLabel.text = "14.99"
        item.filmResimImageView.image = UIImage(named: incomingData.film_resim!)
        item.layer.borderColor = UIColor.lightGray.cgColor
        item.layer.borderWidth = 1.5
        
        item.cellProtocol = self
        item.indexPath = indexPath
        
        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDetail", sender: indexPath.item)
    }
    
    func sepeteEkle(indexPath: IndexPath) {
        print("Sepete eklenen: \(filmlist[indexPath.item].film_ad!)")
    }
    
    
}
