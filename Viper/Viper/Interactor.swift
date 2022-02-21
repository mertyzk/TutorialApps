//
//  Interactor.swift
//  Viper
//
//  Created by Macbook Air on 20.02.2022.
//

import Foundation

protocol AnyInteractor{
    var presenter : AnyPresenter? {get set}
    
    func getKriptolar()
    
}

class KriptoInteractor:AnyInteractor{
    var presenter: AnyPresenter?
    
    func getKriptolar(){
        guard let url = URL(string: "https://apilink.json") else{
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else{
                self?.presenter?.interactorDidDownloadKripto(result: .failure(NetworkError.NetworkFailed))
                return
            }
            
            do {
                let result = try JSONDecoder().decode([Kripto].self, from: data)
                self?.presenter?.interactorDidDownloadKripto(result: .success(result))
            } catch {
                self?.presenter?.interactorDidDownloadKripto(result: .failure(NetworkError.ParsingFaield))
            }
            
        }.resume()
    }
    
}
