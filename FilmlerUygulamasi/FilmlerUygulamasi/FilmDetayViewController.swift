//
//  FilmDetayViewController.swift
//  FilmlerUygulamasi
//
//  Created by Macbook Air on 8.02.2022.
//

import UIKit

class FilmDetayViewController: UIViewController {

    @IBOutlet weak var imageViewFilmResim: UIImageView!
    @IBOutlet weak var labelFilmAdi: UILabel!
    @IBOutlet weak var labelFilmYil: UILabel!
    @IBOutlet weak var labelFilmKategori: UILabel!
    @IBOutlet weak var labelFilmYonetmen: UILabel!
    
    var film:Filmler?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let film = film{
            imageViewFilmResim.image = UIImage(named: film.film_resim!)
            labelFilmAdi.text = film.film_ad
            labelFilmYil.text = String(film.film_yil!)
            labelFilmKategori.text = film.kategori?.kategori_ad
            labelFilmYonetmen.text = film.yonetmen?.yonetmen_ad
        }

        
    }
    

}
