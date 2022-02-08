//
//  BayraklarDao.swift
//  FlagApplication
//
//  Created by Macbook Air on 8.02.2022.
//

import Foundation

class BayraklarDao {
    let db:FMDatabase?

    init() {
        let targetPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let dbURL = URL(fileURLWithPath: targetPath).appendingPathComponent("bayrakquiz.sqlite")
        
        db = FMDatabase(path: dbURL.path)
    }
    
    func random5Question() -> [Bayraklar] {
        var list = [Bayraklar]()
        db?.open()
        
        do {
            let result = try db!.executeQuery("SELECT * FROM bayraklar ORDER BY RANDOM() LIMIT 10", values: nil)
            while(result.next()){
                let flag = Bayraklar(bayrak_id: Int(result.string(forColumn: "bayrak_id"))!, bayrak_ad: result.string(forColumn: "bayrak_ad")!, bayrak_resim: result.string(forColumn: "bayrak_resim")!)
                list.append(flag)
            }
        } catch  {
            print(error.localizedDescription)
        }
        db?.close()
        return list
    }
    
    
    func random3FalseQuestion(bayrak_id:Int) -> [Bayraklar] {
        var list = [Bayraklar]()
        db?.open()
        
        do {
            let result = try db!.executeQuery("SELECT * FROM bayraklar WHERE bayrak_id != ? ORDER BY RANDOM() LIMIT 3", values: [bayrak_id])
            while(result.next()){
                let flag = Bayraklar(bayrak_id: Int(result.string(forColumn: "bayrak_id"))!, bayrak_ad: result.string(forColumn: "bayrak_ad")!, bayrak_resim: result.string(forColumn: "bayrak_resim")!)
                list.append(flag)
            }
        } catch  {
            print(error.localizedDescription)
        }
        db?.close()
        return list
    }
    
}
