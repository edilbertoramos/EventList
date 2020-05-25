//
//  DateFormatItem.swift
//  EventList
//
//  Created by EDILBERTO DA SILVA RAMOS JUNIOR on 24/05/20.
//  Copyright © 2020 Edilberto Ramos. All rights reserved.
//

import Foundation

enum DateFormaItem: String {
    
    case fullDate = "dd-MMM-yyyy"
    
}

extension DateFormaItem {
    
    var format: String {
        return self.rawValue
    }
    
}
