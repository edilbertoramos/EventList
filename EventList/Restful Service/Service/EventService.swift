//
//  EventService.swift
//  EventList
//
//  Created by EDILBERTO DA SILVA RAMOS JUNIOR on 22/05/20.
//  Copyright © 2020 Edilberto Ramos. All rights reserved.
//

import Foundation
import Alamofire

struct EventService: EventServiceProtocol {
    
    enum Services: String, ServiceEndpoint {
        case events = "/events"
        case event = "/events/%@"
    }
    
    func events(callback: @escaping (ServiceResponse<[Event]>) -> Void) {
        let uri = ServiceHelper.mountUrl(withEndPoint: Services.events)
        ServiceHelper.get(url: uri, callbackForObjectArray: callback)
    }
    
    func event(with eventId: String, callback: @escaping (ServiceResponse<Event>) -> Void) {
        let uri = ServiceHelper.baseUrl + String(format: Services.event.endpoint, eventId)
        ServiceHelper.get(url: uri, callbackForObject: callback)
    }
    
    func image(with uri: String, completion: @escaping (Bool, Data?) -> Void) {
        let urlRequest = try! URLRequest(url: uri, method: .get, headers: nil)
        Alamofire.request(urlRequest)
            .downloadProgress { progress in
                //print("Download Progress: \(progress.fractionCompleted)")
            }
            .responseData { response in
            if let data = response.result.value {
                completion(true, data)
            }
            else {
                completion(false, nil)
            }
        }
    }
    
}
