//
//  Date+Extension.swift
//  EventList
//
//  Created by EDILBERTO DA SILVA RAMOS JUNIOR on 24/05/20.
//  Copyright © 2020 Edilberto Ramos. All rights reserved.
//

import Foundation

extension Date {
    
    var toString: String {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = DateFormaItem.fullDate.format
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: self)
    }
    
}
