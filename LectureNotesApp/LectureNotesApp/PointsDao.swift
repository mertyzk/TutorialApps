//
//  PointsDao.swift
//  LectureNotesApp
//
//  Created by Macbook Air on 8.02.2022.
//

import Foundation

class PointsDao{
    let db:FMDatabase?
        
        init() {
            let targetPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let dbURL = URL(fileURLWithPath: targetPath).appendingPathComponent("points.sqlite")
            
            db = FMDatabase(path: dbURL.path)
        }
    
    func getByAll()->[Notlar]{
            var list = [Notlar]()
            db?.open()
            
            do {
                let result = try db!.executeQuery("SELECT * FROM notlar", values: nil)
                while result.next(){
                    let point = Notlar(not_id: Int(result.string(forColumn: "not_id"))!, ders_adi: result.string(forColumn: "ders_adi")!, not1: Int(result.string(forColumn: "not1"))!, not2: Int(result.string(forColumn: "not2"))! )
                    
                    list.append(point)
                }
            } catch {
                print(error.localizedDescription)
            }
            
            db?.close()
            
            return list
        }
    
    func add(ders_adi:String,not1:Int,not2:Int){
        db?.open()
        do {
            try db!.executeUpdate("INSERT INTO notlar (ders_adi,not1,not2) VALUES (?,?,?)", values: [ders_adi,not1,not2])
        } catch {
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    func delete(not_id:Int){
        db?.open()
        do {
            try db!.executeUpdate("DELETE FROM notlar WHERE not_id = ?", values: [not_id])
        } catch {
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    func update(not_id:Int,ders_adi:String,not1:Int,not2:Int){
            db?.open()
            do {
                try db!.executeUpdate("UPDATE notlar SET ders_adi = ? , not1 = ? ,not2 = ? WHERE not_id = ?", values: [ders_adi,not1,not2,not_id])
            } catch {
                print(error.localizedDescription)
            }
            db?.close()
        }
    
    
    
}
