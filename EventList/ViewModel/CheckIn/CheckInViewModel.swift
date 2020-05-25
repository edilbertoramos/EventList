//
//  CheckInViewModel.swift
//  EventList
//
//  Created by EDILBERTO DA SILVA RAMOS JUNIOR on 24/05/20.
//  Copyright © 2020 Edilberto Ramos. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class CheckInViewModel: CheckInViewModelProcotol {
    
    internal var service: CheckInServiceProtocol = CheckInService()
    public var errorMessage: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    public var requesSuccess: BehaviorRelay<Bool?> = BehaviorRelay(value: nil)
    public var eventId: String = ""

    init(eventId: String) {
        self.eventId = eventId
    }
    
    func checkIn(name: String, email: String) {
        let checkIn = CheckIn.init(eventId: eventId, name: name, email: email)
        service.checkIn(with: checkIn) { (serviceResponse) in
            if serviceResponse.isSuccess {
                self.requesSuccess.accept(serviceResponse.isSuccess)
            } else {
                self.errorMessage.accept(serviceResponse.errorMessage)
            }
        }
    }
}
