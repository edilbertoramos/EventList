//
//  People.swift
//  EventList
//
//  Created by EDILBERTO DA SILVA RAMOS JUNIOR on 22/05/20.
//  Copyright © 2020 Edilberto Ramos. All rights reserved.
//

import Foundation

struct People {
    var id: String?
    var eventId: String?
    var name: String?
    var picture: String?
}

extension People: Decodable {
    enum keys: String, CodingKey {
        case id
        case eventId
        case name
        case picture
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: keys.self)
        
        if let id = try container.decodeIfPresent(String.self, forKey: .id) {
            self.id = id
        }
        if let eventId = try container.decodeIfPresent(String.self, forKey: .eventId) {
            self.eventId = eventId
        }
        if let name = try container.decodeIfPresent(String.self, forKey: .name) {
            self.name = name
        }
        if let picture = try container.decodeIfPresent(String.self, forKey: .picture) {
            self.picture = picture
        }
    }
}


