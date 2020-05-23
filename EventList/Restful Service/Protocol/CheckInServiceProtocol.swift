//
//  CheckInServiceProtocol.swift
//  EventList
//
//  Created by EDILBERTO DA SILVA RAMOS JUNIOR on 22/05/20.
//  Copyright © 2020 Edilberto Ramos. All rights reserved.
//

import Foundation

protocol CheckInServiceProtocol {
    
    func checkIn(with data: CheckIn, callback: @escaping (ServiceResponse<CheckIn>) -> Void)

}

