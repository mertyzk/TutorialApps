//
//  Service.swift
//  KriptoMVVM
//
//  Created by Macbook Air on 20.02.2022.
//

import Foundation

class Service {
    
    let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!
    
    func getData(completion: @escaping ([Kripto]?) -> ()){
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if error != nil || data == nil {
                print(error?.localizedDescription ?? "error")
            }
            do {
                let result = try JSONDecoder().decode([Kripto].self, from: data!)
                completion(result)
                print(result)
            } catch {
                print(error.localizedDescription)
            }
            
            
            
        }.resume()
        
        
    }
    
    
}
