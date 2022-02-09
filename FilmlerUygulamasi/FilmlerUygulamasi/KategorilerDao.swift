//
//  KategorilerDao.swift
//  FilmlerUygulamasi
//
//  Created by Macbook Air on 9.02.2022.
//

import Foundation

class KategorilerDao{
    
    let db:FMDatabase?
            
            init() {
                let targetPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
                let dbURL = URL(fileURLWithPath: targetPath).appendingPathComponent("filmler.sqlite")
                
                db = FMDatabase(path: dbURL.path)
            }
    
    
    func getByAll()->[Kategoriler]{
        
        var list = [Kategoriler]()
        
        db?.open()
        do {
            let result = try db!.executeQuery("SELECT * FROM kategoriler", values: nil)
            while result.next(){
                let cat = Kategoriler(kategori_id: Int(result.string(forColumn: "kategori_id"))!, kategori_ad: result.string(forColumn: "kategori_ad")!)
                list.append(cat)
            }
        } catch  {
            print(error.localizedDescription)
        }
        db?.close()
        
        return list
    }
    
    
    
}
