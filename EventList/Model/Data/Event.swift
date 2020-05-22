//
//  Event.swift
//  EventList
//
//  Created by EDILBERTO DA SILVA RAMOS JUNIOR on 22/05/20.
//  Copyright © 2020 Edilberto Ramos. All rights reserved.
//

import Foundation

struct Event {
    var id: String?
    var title: String?
    var image: String?
    var description: String?
    var date: Double?
    var longitude: Double?
    var latitude: Double?
    var price: Double?
    var people: [People]?
    var cupons: [Cupon]?
}

extension Event: Decodable {
    enum keys: String, CodingKey {
        case id
        case title
        case image
        case description
        case date
        case longitude
        case latitude
        case price
        case people
        case cupons
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: keys.self)
        
        if let id = try container.decodeIfPresent(String.self, forKey: .id) {
            self.id = id
        }
        if let title = try container.decodeIfPresent(String.self, forKey: .title) {
            self.title = title
        }
        if let image = try container.decodeIfPresent(String.self, forKey: .image) {
            self.image = image
        }
        if let description = try container.decodeIfPresent(String.self, forKey: .description) {
            self.description = description
        }
        if let date = try container.decodeIfPresent(Double.self, forKey: .date) {
            self.date = date
        }
        if let longitude = try container.decodeIfPresent(Double.self, forKey: .longitude) {
            self.longitude = longitude
        }
        if let latitude = try container.decodeIfPresent(Double.self, forKey: .latitude) {
            self.latitude = latitude
        }
        if let price = try container.decodeIfPresent(Double.self, forKey: .price) {
            self.price = price
        }
        if let people = try container.decodeIfPresent([People].self, forKey: .people) {
            self.people = people
        }
        if let cupons = try container.decodeIfPresent([Cupon].self, forKey: .cupons) {
            self.cupons = cupons
        }
    }
}
