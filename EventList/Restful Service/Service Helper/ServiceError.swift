//
//  ServiceError.swift
//  EventList
//
//  Created by EDILBERTO DA SILVA RAMOS JUNIOR on 22/05/20.
//  Copyright © 2020 Edilberto Ramos. All rights reserved.
//

import Foundation

public enum ServiceError: ELError {
    case requestFailure
    case responseObjectError
    
    public var description: String {
        switch self {
        case .requestFailure:
            return "service_request_error"
            
        case .responseObjectError:
            return "service_json_error"
        }
    }
}
