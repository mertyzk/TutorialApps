//
//  FilmlerDao.swift
//  FilmlerUygulamasi
//
//  Created by Macbook Air on 9.02.2022.
//

import Foundation

class FilmlerDao{
    let db:FMDatabase?
            
            init() {
                let targetPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
                let dbURL = URL(fileURLWithPath: targetPath).appendingPathComponent("filmler.sqlite")
                
                db = FMDatabase(path: dbURL.path)
            }
    
    func getFilmsByCategoryId(kategori_id:Int)->[Filmler]{
        
        var list = [Filmler]()
        
        db?.open()
        do {
            let result = try db!.executeQuery("SELECT * FROM kategoriler,yonetmenler,filmler WHERE filmler.kategori_id = kategoriler.kategori_id AND filmler.yonetmen_id = yonetmenler.yonetmen_id AND filmler.kategori_id = ?", values: [kategori_id])
            while result.next(){
                let cat = Kategoriler(kategori_id: Int(result.string(forColumn: "kategori_id"))!, kategori_ad: result.string(forColumn: "kategori_ad")!)
                let yonetmen = Yonetmenler(yonetmen_id: Int(result.string(forColumn: "yonetmen_id"))!, yonetmen_ad: result.string(forColumn: "yonetmen_ad")!)
                let film = Filmler(film_id: Int(result.string(forColumn: "film_id"))!, film_ad: result.string(forColumn: "film_ad")!, film_yil: Int(result.string(forColumn: "film_yil"))!, film_resim: result.string(forColumn: "film_resim")!, kategori: cat, yonetmen: yonetmen)
                list.append(film)
            }
        } catch  {
            print(error.localizedDescription)
        }
        db?.close()
        
        return list
    }
}
