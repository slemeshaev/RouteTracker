//
//  MapRouter.swift
//  RouteTracker
//
//  Created by Станислав Лемешаев on 05.10.2020.
//

import UIKit

final class MainRouter: BaseRouter {
    func toMap(usseles: String) {
        let controller = UIStoryboard(name: "MapViewController", bundle: nil)
            .instantiateViewController(MapViewController.self)
        
        controller.usselesExampleVariable = usseles
        
        show(controller)
    }
    
    func toLaunch() {
        let controller = UIStoryboard(name: "AuthViewController", bundle: nil)
            .instantiateViewController(AuthViewController.self)
        setAsRoot(UINavigationController(rootViewController: controller))
    }
}
