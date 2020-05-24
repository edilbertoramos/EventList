//
//  UIViewController+Extension.swift
//  EventList
//
//  Created by EDILBERTO DA SILVA RAMOS JUNIOR on 23/05/20.
//  Copyright © 2020 Edilberto Ramos. All rights reserved.
//

import UIKit

extension UIViewController {

    func embedInNavigation() -> UINavigationController {
        return UINavigationController.init(rootViewController: self)
    }
    
}
