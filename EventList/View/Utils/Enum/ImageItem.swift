//
//  ImageItem.swift
//  EventList
//
//  Created by EDILBERTO DA SILVA RAMOS JUNIOR on 23/05/20.
//  Copyright © 2020 Edilberto Ramos. All rights reserved.
//

import UIKit

enum ImageItem: String {
    
    case template = "template"
}


extension ImageItem {
    
    var image: UIImage? {
        return UIImage.init(named: self.rawValue)
    }
    
}
