//
//  BaseRouter.swift
//  RouteTracker
//
//  Created by Станислав Лемешаев on 05.10.2020.
//

import UIKit

class BaseRouter: NSObject {
    @IBOutlet weak var controller: UIViewController!
    
    func show(_ controller: UIViewController) {
        self.controller.show(controller, sender: nil)
    }
    
    func present(_ controller: UIViewController) {
        self.controller.present(controller, animated: true)
    }
    
    func setAsRoot(_ controller: UIViewController) {
        UIApplication.shared.keyWindowInConnectedScenes?.rootViewController = controller
    }
    
}


