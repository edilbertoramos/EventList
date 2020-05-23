//
//  HttpStatusCode.swift
//  EventList
//
//  Created by EDILBERTO DA SILVA RAMOS JUNIOR on 22/05/20.
//  Copyright © 2020 Edilberto Ramos. All rights reserved.
//

import Foundation

public enum HttpStatusCode: Int {
    case success = 200
    case created = 201
    case accepted = 202
    case reset = 205
    case moved = 301
    case found = 302
    case invalidRequest = 400
    case notAuthorized = 401
    case prohibided = 403
    case notFound = 404
    case internalError = 500
    case badGateway = 502
    
    public var code: Int {
        return rawValue
    }
}
