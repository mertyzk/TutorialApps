//
//  KisilerDao.swift
//  ContactsApp
//
//  Created by Macbook Air on 9.02.2022.
//

import Foundation

class KisilerDao{
    
    let db:FMDatabase?
                
                init() {
                    let targetPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
                    let dbURL = URL(fileURLWithPath: targetPath).appendingPathComponent("kisiler.sqlite")
                    
                    db = FMDatabase(path: dbURL.path)
                }
    
    func getByAll() -> [Kisiler]{
        var list = [Kisiler]()
        
        db?.open()
        
        do {
            let result = try db!.executeQuery("SELECT * FROM kisiler", values: nil)
            while result.next(){
                let kisi = Kisiler(kisi_id: Int(result.string(forColumn: "kisi_id"))!, kisi_ad: result.string(forColumn: "kisi_ad")!, kisi_tel: result.string(forColumn: "kisi_tel")!)
                list.append(kisi)
            }
        } catch  {
            print(error.localizedDescription)
        }
        
        db?.close()
        
        return list
    }
    
    func getBySearch(kisi_ad:String) -> [Kisiler]{
        var list = [Kisiler]()
        
        db?.open()
        
        do {
            let result = try db!.executeQuery("SELECT * FROM kisiler WHERE kisi_ad LIKE '%\(kisi_ad)%'", values: nil)
            while result.next(){
                let kisi = Kisiler(kisi_id: Int(result.string(forColumn: "kisi_id"))!, kisi_ad: result.string(forColumn: "kisi_ad")!, kisi_tel: result.string(forColumn: "kisi_tel")!)
                list.append(kisi)
            }
        } catch  {
            print(error.localizedDescription)
        }
        
        db?.close()
        
        return list
    }
    
    func add(kisi_ad:String,kisi_tel:String){
        db?.open()
        
        do {
            try db!.executeUpdate("INSERT INTO kisiler (kisi_ad,kisi_tel) VALUES (?,?)", values: [kisi_ad,kisi_tel])
            }
        catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func update(kisi_id:Int,kisi_ad:String,kisi_tel:String){
        db?.open()
        
        do {
            try db!.executeUpdate("UPDATE kisiler SET kisi_ad = ? , kisi_tel = ? WHERE kisi_id =?", values: [kisi_ad,kisi_tel,kisi_id])
            }
        catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func delete(kisi_id:Int){
        db?.open()
        
        do {
            try db!.executeUpdate("DELETE FROM kisiler WHERE kisi_id = ?", values: [kisi_id])
            }
        catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    
    
}
