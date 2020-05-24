//
//  Double+Extension.swift
//  EventList
//
//  Created by EDILBERTO DA SILVA RAMOS JUNIOR on 24/05/20.
//  Copyright © 2020 Edilberto Ramos. All rights reserved.
//

import Foundation

extension Double {
    
    var toDate: Date {
        let timestamp = TimeInterval.init(self/1000)
        return .init(timeIntervalSince1970: timestamp)
    }
    
    var toCurrency: String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = .current
        
        return numberFormatter.string(from: NSNumber(value: self))
    }
    
}
