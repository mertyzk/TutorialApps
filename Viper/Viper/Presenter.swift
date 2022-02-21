//
//  Presenter.swift
//  Viper
//
//  Created by Macbook Air on 20.02.2022.
//

import Foundation

enum NetworkError : Error{
    case NetworkFailed
    case ParsingFaield
}


protocol AnyPresenter{
    var router : AnyRouter? {get set}
    var interactor : AnyInteractor? {get set}
    var view : AnyView? {get set}
    
    func interactorDidDownloadKripto(result: Result<[Kripto],Error>)
}

class KriptoPresenter : AnyPresenter{
    var router: AnyRouter?
    
    var interactor: AnyInteractor? {
        didSet{
            interactor?.getKriptolar()
        }
    }
    
    var view: AnyView?
    
    func interactorDidDownloadKripto(result: Result<[Kripto], Error>) {
        switch result {
        case .success(let kriptolar):
            view?.update(with: kriptolar)
        case .failure(_):
            view?.update(with: "try again")
        }
    }
    

    
}
