//
//  CollectionViewFilmCell.swift
//  CollectionViewApp
//
//  Created by Macbook Air on 6.02.2022.
//

import UIKit

protocol CollectionViewFilmCellProtocol {
    func sepeteEkle(indexPath:IndexPath)
}

class CollectionViewFilmCell: UICollectionViewCell {
    
    @IBOutlet weak var filmimageView: UIImageView!
    @IBOutlet weak var filmAdiLabel: UILabel!
    @IBOutlet weak var filmFiyatLabel: UILabel!
    
    var hucreProtocol:CollectionViewFilmCellProtocol?
    var indexPath:IndexPath?
    

    @IBAction func sepeteEkleButton(_ sender: Any) {
        hucreProtocol?.sepeteEkle(indexPath: indexPath!)
    }
    
}

