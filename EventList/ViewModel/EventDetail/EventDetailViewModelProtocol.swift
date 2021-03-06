//
//  EventDetailViewModelProtocol.swift
//  EventList
//
//  Created by EDILBERTO DA SILVA RAMOS JUNIOR on 23/05/20.
//  Copyright © 2020 Edilberto Ramos. All rights reserved.
//

import UIKit
import RxCocoa

protocol EventDetailViewModelProtocol {
    
    var eventId: String { get set }
    var event: BehaviorRelay<Event?> { get set }
    var details: BehaviorRelay<[Any]> { get set }
    var image: BehaviorRelay<UIImage?> { get set }
    var errorMessage: BehaviorRelay<String?> { get set }
    var service: EventServiceProtocol { get set }
    func fetchEvent()
    func fetchImage()

}
