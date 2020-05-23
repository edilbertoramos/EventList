//
//  ServiceEndpoint.swift
//  EventList
//
//  Created by EDILBERTO DA SILVA RAMOS JUNIOR on 22/05/20.
//  Copyright © 2020 Edilberto Ramos. All rights reserved.
//

import Foundation

public protocol ServiceEndpoint {
    var endpoint: String { get }
}

extension ServiceEndpoint where Self: RawRepresentable, Self.RawValue == String {
    
    public var endpoint: String {
        return self.rawValue
    }
    
}
