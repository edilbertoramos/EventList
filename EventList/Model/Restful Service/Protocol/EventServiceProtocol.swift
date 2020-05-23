//
//  EventServiceProtocol.swift
//  EventList
//
//  Created by EDILBERTO DA SILVA RAMOS JUNIOR on 22/05/20.
//  Copyright © 2020 Edilberto Ramos. All rights reserved.
//

import Foundation

protocol EventServiceProtocol {
    
    func events(callback: @escaping (ServiceResponse<[Event]>) -> Void)
    func event(with eventId: String, callback: @escaping (ServiceResponse<Event>) -> Void)
    
}


