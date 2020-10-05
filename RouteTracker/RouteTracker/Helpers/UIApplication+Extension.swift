//
//  UIApplication+Extension.swift
//  RouteTracker
//
//  Created by Станислав Лемешаев on 05.10.2020.
//

import UIKit

extension UIApplication {
    
    var keyWindowInConnectedScenes: UIWindow? {
        return windows.first(where: { $0.isKeyWindow })
    }
    
}


