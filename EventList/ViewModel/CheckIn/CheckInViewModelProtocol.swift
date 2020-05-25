//
//  CheckInViewModelProtocol.swift
//  EventList
//
//  Created by EDILBERTO DA SILVA RAMOS JUNIOR on 24/05/20.
//  Copyright © 2020 Edilberto Ramos. All rights reserved.
//

import Foundation
import RxCocoa

protocol CheckInViewModelProcotol {
    
    var errorMessage: BehaviorRelay<String?> { get set }
    var requesSuccess: BehaviorRelay<Bool?> { get set }
    var service: CheckInServiceProtocol { get set }
    var eventId: String { get set }
    func checkIn(name: String, email: String)
    
}
