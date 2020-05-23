//
//  ServiceResponse.swift
//  EventList
//
//  Created by EDILBERTO DA SILVA RAMOS JUNIOR on 22/05/20.
//  Copyright © 2020 Edilberto Ramos. All rights reserved.
//

import Foundation

public struct ServiceResponse<T> {
    
    fileprivate let success: Bool
    public let data: T?
    public let error: ELError?
    public let statusCode: Int?
    public let errorMessage: String?
    
    public var isSuccess: Bool { return success }
    
    fileprivate init(success: Bool = false, data: T?, error: ELError?, statusCode: Int?, errorMessage: String?) {
        self.success = success
        self.data = data
        self.error = error
        self.statusCode = statusCode
        self.errorMessage = errorMessage
    }
    
    public init(withError error: ELError, statusCode: Int? = nil, errorMessage: String? = nil) {
        self.init(success: false, data: nil, error: error, statusCode: statusCode, errorMessage: errorMessage)
    }
    
    public init(withData data: T, statusCode: Int? = nil) {
        self.init(success: true, data: data, error: nil, statusCode: statusCode, errorMessage: nil)
    }
    
    func logError() -> ELError {
        print("Error: \(error!), message: \(errorMessage ?? "")")
        return error!
    }
}
