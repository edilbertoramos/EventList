//
//  CheckInService.swift
//  EventList
//
//  Created by EDILBERTO DA SILVA RAMOS JUNIOR on 22/05/20.
//  Copyright © 2020 Edilberto Ramos. All rights reserved.
//

import Foundation

struct CheckInService: CheckInServiceProtocol {
    
    enum Services: String, ServiceEndpoint {
        case checkIn = "checkin"
    }
    
    func checkIn(with data: CheckIn, callback: @escaping (ServiceResponse<CheckIn>) -> Void) {
        let uri = ServiceHelper.mountUrl(withEndPoint: Services.checkIn)
        ServiceHelper.post(url: uri, parameters: data.parameters, headers: nil, callbackForObject: callback)
    }
    
}
