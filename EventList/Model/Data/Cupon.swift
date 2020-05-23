//
//  Cupon.swift
//  EventList
//
//  Created by EDILBERTO DA SILVA RAMOS JUNIOR on 22/05/20.
//  Copyright © 2020 Edilberto Ramos. All rights reserved.
//

import Foundation

struct Cupon {
    var id: String?
    var eventId: String?
    var discount: Double?
}

extension Cupon: Decodable {
    enum keys: String, CodingKey {
        case id
        case eventId
        case discount
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: keys.self)
        
        if let id = try container.decodeIfPresent(String.self, forKey: .id) {
            self.id = id
        }
        if let eventId = try container.decodeIfPresent(String.self, forKey: .eventId) {
            self.eventId = eventId
        }
        if let discount = try container.decodeIfPresent(Double.self, forKey: .discount) {
            self.discount = discount
        }
    }
}
