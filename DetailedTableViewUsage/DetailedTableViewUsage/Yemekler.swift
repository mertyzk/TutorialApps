//
//  Yemekler.swift
//  DetailedTableViewUsage
//
//  Created by Macbook Air on 6.02.2022.
//

import Foundation

class Yemekler{
    var yemekId:Int?
    var yemekAdi:String?
    var yemekResimAdi:String?
    var yemekFiyat:Double?

    init() {
        
    }
    
    init(yemekId:Int,yemekAdi:String,yemekResimAdi:String,yemekFiyat:Double) {
        self.yemekId = yemekId
        self.yemekAdi = yemekAdi
        self.yemekFiyat = yemekFiyat
        self.yemekResimAdi = yemekResimAdi
    }


}
