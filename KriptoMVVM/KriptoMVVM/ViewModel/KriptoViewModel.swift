//
//  KriptoViewModel.swift
//  KriptoMVVM
//
//  Created by Macbook Air on 20.02.2022.
//

import Foundation

struct KriptoListViewModel {
    let kriptoList: [Kripto]
    
    func numberOfRowsInsection() -> Int{
        return self.kriptoList.count
    }
    
    func kriptoAtIndex(_ index: Int) -> KriptoViewModel{
        let kripto = self.kriptoList[index]
        return KriptoViewModel(kripto: kripto)
    }
    
}

struct KriptoViewModel {
    let kripto : Kripto
    
    var name : String{
        return kripto.currency
    }
    
    var price : String{
        return kripto.price
    }
    
}
