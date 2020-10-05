//
//  LoginRouter.swift
//  RouteTracker
//
//  Created by Станислав Лемешаев on 05.10.2020.
//

import UIKit

final class LoginRouter: BaseRouter {
    func toMain() {
        let controller = UIStoryboard(name: "MapViewController", bundle: nil)
            .instantiateViewController(MapViewController.self)
        
        setAsRoot(UINavigationController(rootViewController: controller))
    }
    
    func onRecover() {
        let controller = UIStoryboard(name: "AuthViewController", bundle: nil)
            .instantiateViewController(AuthViewController.self)
        
        show(controller)
    }
}
