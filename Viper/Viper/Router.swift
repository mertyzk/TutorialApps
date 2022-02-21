//
//  Router.swift
//  Viper
//
//  Created by Macbook Air on 20.02.2022.
//

import Foundation
import UIKit


typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter{
    var entry : EntryPoint? {get}
    static func startExecute() -> AnyRouter

}

class KriptoRouter:AnyRouter{
    var entry: EntryPoint?
    
    static func startExecute() -> AnyRouter{
        let router = KriptoRouter()
        
        var view : AnyView = KriptoViewController()
        var presenter : AnyPresenter = KriptoPresenter()
        var interactor : AnyInteractor = KriptoInteractor()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        router.entry = view as? EntryPoint
        
        return router
    }
}
