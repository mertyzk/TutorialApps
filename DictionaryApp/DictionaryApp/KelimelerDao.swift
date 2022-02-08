//
//  KelimelerDao.swift
//  DictionaryApp
//
//  Created by Macbook Air on 8.02.2022.
//

import Foundation

class KelimelerDao {
    let db:FMDatabase?
        
        init() {
            let targetPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let dbURL = URL(fileURLWithPath: targetPath).appendingPathComponent("sozluk.sqlite")
            
            db = FMDatabase(path: dbURL.path)
        }
    
    func getByAll()->[Kelimeler]{
        var list = [Kelimeler]()
        db?.open()
        
        do {
            let result = try db!.executeQuery("SELECT * FROM kelimeler", values: nil)
            while result.next(){
                let word = Kelimeler(kelime_id: Int(result.string(forColumn: "kelime_id"))!, ingilizce: result.string(forColumn: "ingilizce")!, turkce: result.string(forColumn: "turkce")!)
                
                list.append(word)
            }
        } catch {
            print(error.localizedDescription)
        }
        
        db?.close()
        
        return list
        
    }
    
    func getSearchByEnglish(ingilizce:String)->[Kelimeler]{
        var list = [Kelimeler]()
        db?.open()
        
        do {
            let result = try db!.executeQuery("SELECT * FROM kelimeler WHERE ingilizce LIKE '%\(ingilizce)%'", values: nil)
            while result.next(){
                let word = Kelimeler(kelime_id: Int(result.string(forColumn: "kelime_id"))!, ingilizce: result.string(forColumn: "ingilizce")!, turkce: result.string(forColumn: "turkce")!)
                
                list.append(word)
            }
        } catch {
            print(error.localizedDescription)
        }
        
        db?.close()
        
        return list
        
    }
    
    
    
    
    
    
    
    
    
    
}
