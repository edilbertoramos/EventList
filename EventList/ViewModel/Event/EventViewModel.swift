//
//  EventViewModel.swift
//  EventList
//
//  Created by EDILBERTO DA SILVA RAMOS JUNIOR on 23/05/20.
//  Copyright © 2020 Edilberto Ramos. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class EventViewModel: EventViewModelProtocol {
    
    internal var service: EventServiceProtocol = EventService()
    public var events: BehaviorRelay<[Event]> = BehaviorRelay(value: [])
    public var errorMessage: BehaviorRelay<String?> = BehaviorRelay(value: nil)

    init() {
        
    }
    
    func fetchEvents() {
        service.events { (serviceResponse) in
            if serviceResponse.isSuccess {
                self.events.accept(serviceResponse.data!)
            } else {
                self.errorMessage.accept(serviceResponse.errorMessage)
            }
        }
    }
    
}
