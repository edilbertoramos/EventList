//
//  ELError.swift
//  EventList
//
//  Created by EDILBERTO DA SILVA RAMOS JUNIOR on 22/05/20.
//  Copyright © 2020 Edilberto Ramos. All rights reserved.
//

import Foundation

public protocol ELError: Error, CustomStringConvertible {
    
}

extension Error {
    var description: String { return "\(self)" }
}

struct CustomError: Error {
    var description: String
}
