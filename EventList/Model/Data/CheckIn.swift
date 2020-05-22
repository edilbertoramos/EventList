//
//  CheckIn.swift
//  EventList
//
//  Created by EDILBERTO DA SILVA RAMOS JUNIOR on 22/05/20.
//  Copyright © 2020 Edilberto Ramos. All rights reserved.
//

import Foundation

struct CheckIn {
    var eventId: String
    var name: String
    var email: String
}

extension CheckIn: Encodable {
    enum keys: String, CodingKey {
        case eventId
        case name
        case email
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: keys.self)
        try container.encode(eventId, forKey: .eventId)
        try container.encode(name, forKey: .name)
        try container.encode(email, forKey: .email)
    }
}
