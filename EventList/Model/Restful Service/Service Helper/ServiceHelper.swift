//
//  ServiceHelper.swift
//  EventList
//
//  Created by EDILBERTO DA SILVA RAMOS JUNIOR on 22/05/20.
//  Copyright © 2020 Edilberto Ramos. All rights reserved.
//

import Foundation
import Alamofire

public struct ServiceHelper {
    
    static public func restManager() -> Alamofire.SessionManager {
        return Alamofire.SessionManager.default
    }
    
    static public var baseUrl: String {
        return AppConfig.config(withKey: .ServiceUrl)
    }
    
    static public func mountUrl(_ url: String = baseUrl, withEndPoint service: ServiceEndpoint) -> String {
        return "\(baseUrl)/\(service.endpoint)"
    }
    
    static public func mountUrl(_ url: String = baseUrl, withEndPoint service: ServiceEndpoint, pathParameters parameters: String...) -> String {
        return String(format: mountUrl(url, withEndPoint: service), parameters)
    }
    
    static public func addParams(_ params: [String: Any], onUrl url: String = baseUrl) -> String {
        return "\(url)?\(params.map{(k, v) in "\(k)=\(v)"}.joined(separator: "&"))"
    }
    
}

// MARK:- Service request brigde
extension ServiceHelper {
    
    // MARK: - Boolean
    static public func post(url: String, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, callbackForString callback: @escaping (ServiceResponse<String>) -> Void) {
        request(url: url, method: .post, parameters: parameters, headers: headers, callbackForString: callback)
    }
    
    static public func put(url: String, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, callbackForString callback: @escaping (ServiceResponse<String>) -> Void) {
        request(url: url, method: .put, parameters: parameters, headers: headers, callbackForString: callback)
    }
    
    static public func get(url: String, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, callbackForString callback: @escaping (ServiceResponse<String>) -> Void) {
        request(url: url, method: .get, parameters: parameters, headers: headers, callbackForString: callback)
    }
    
    // MARK: - Codable Object
    static public func post<T: Codable>(url: String, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, callbackForObject callback: @escaping (ServiceResponse<T>) -> Void) {
        request(url: url, method: .post, parameters: parameters, headers: headers, callbackForObject: callback)
    }
    
    static public func put<T: Codable>(url: String, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, callbackForObject callback: @escaping (ServiceResponse<T>) -> Void) {
        request(url: url, method: .put, parameters: parameters, headers: headers, callbackForObject: callback)
    }
    
    static public func get<T: Codable>(url: String, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, callbackForObject callback: @escaping (ServiceResponse<T>) -> Void) {
        request(url: url, method: .get, parameters: parameters, headers: headers, callbackForObject: callback)
    }
    
    // MARK: - Codable Array
    static public func post<T: Codable>(url: String, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, callbackForObjectArray callback: @escaping (ServiceResponse<[T]>) -> Void) {
        request(url: url, method: .post, parameters: parameters, headers: headers, callbackForObjectArray: callback)
    }
    
    static public func put<T: Codable>(url: String, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, callbackForObjectArray callback: @escaping (ServiceResponse<[T]>) -> Void) {
        request(url: url, method: .put, parameters: parameters, headers: headers, callbackForObjectArray: callback)
    }
    
    static public func get<T: Codable>(url: String, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, callbackForObjectArray callback: @escaping (ServiceResponse<[T]>) -> Void) {
        request(url: url, method: .get, parameters: parameters, headers: headers, callbackForObjectArray: callback)
    }
    
}

// MARK: - Service Response Helper
extension ServiceHelper {
    
    static public func responseForString(response: DataResponse<String>, callback: @escaping (ServiceResponse<String>) -> Void) {
        if response.result.isSuccess {
            callback(ServiceResponse(withData: response.result.value ?? "", statusCode: response.response?.statusCode))
        } else {
            var errorMessage: String? = nil
            if let data = response.data {
                if let message = String(data: data, encoding: .utf8) {
                    errorMessage = message
                }
            }
            callback(ServiceResponse(withError: ServiceError.requestFailure, statusCode: response.response?.statusCode, errorMessage: errorMessage))
        }
    }
    
    static public func responseForObject<T: Codable>(response: DataResponse<Data>, callback: @escaping (ServiceResponse<T>) -> Void) {
        if response.result.isSuccess {
            do {
                if let value = response.result.value {
                    let decoder = JSONDecoder()
                    let obj = try decoder.decode(T.self, from: value)
                    callback(ServiceResponse(withData: obj, statusCode: response.response?.statusCode))
                } else {
                    callback(ServiceResponse(withError: ServiceError.responseObjectError,
                                             statusCode: response.response?.statusCode))
                }            } catch {
                print(error.localizedDescription)
                callback(ServiceResponse(withError: ServiceError.responseObjectError,
                                         statusCode: response.response?.statusCode))
            }
        } else {
            var errorMessage: String? = nil
            if let data = response.data {
                if let message = String(data: data, encoding: .utf8) {
                    errorMessage = message
                }
            }
            callback(ServiceResponse(withError: ServiceError.requestFailure,
                                     statusCode: response.response?.statusCode,
                                     errorMessage: errorMessage))
        }
    }
    
    static public func responseForArray<T: Decodable>(response: DataResponse<Data>, callback: @escaping (ServiceResponse<[T]>) -> Void) {
        if response.result.isSuccess {
            do {
                if let value = response.result.value {
                    let decoder = JSONDecoder()
                    let obj = try decoder.decode([T].self, from: value)
                    callback(ServiceResponse(withData: obj, statusCode: response.response?.statusCode))
                } else {
                    callback(ServiceResponse(withError: ServiceError.responseObjectError,
                                             statusCode: response.response?.statusCode))
                }
            } catch {
                print(error.localizedDescription)
                callback(ServiceResponse(withError: ServiceError.responseObjectError,
                                         statusCode: response.response?.statusCode))
            }
        } else {
            var errorMessage: String? = nil
            if let data = response.data {
                if let message = String(data: data, encoding: .utf8) {
                    errorMessage = message
                }
            }
            callback(ServiceResponse(withError: ServiceError.requestFailure,
                                     statusCode: response.response?.statusCode,
                                     errorMessage: errorMessage))
        }
    }
    
}

// MARK: - Request Helper Default
extension ServiceHelper {
    
    fileprivate static func request(url: String, method: HTTPMethod, parameters: Parameters?, headers: HTTPHeaders?, callbackForString callback: @escaping (ServiceResponse<String>) -> Void) {
        ServiceHelper.restManager().request(url, method: method, parameters: parameters, encoding: method == .get ? URLEncoding.default : JSONEncoding.default, headers: headers)
            .validate(statusCode: [HttpStatusCode.success.code, HttpStatusCode.accepted.code, HttpStatusCode.created.code])
            .responseString(completionHandler: { (response) in
                responseForString(response: response, callback: callback)
            })
    }
    
    fileprivate static func request<T: Codable>(url: String, method: HTTPMethod, parameters: Parameters?, headers: HTTPHeaders?, callbackForObject callback: @escaping (ServiceResponse<T>) -> Void) {
        ServiceHelper.restManager().request(url, method: method, parameters: parameters, encoding: method == .get ? URLEncoding.default : JSONEncoding.default, headers: headers)
            .validate(statusCode: [HttpStatusCode.success.code, HttpStatusCode.accepted.code, HttpStatusCode.created.code])
            .responseData(completionHandler: { (response) in
                responseForObject(response: response, callback: callback)
            })
    }
    
    fileprivate static func request<T: Codable>(url: String, method: HTTPMethod, parameters: Parameters?, headers: HTTPHeaders?, callbackForObjectArray callback: @escaping (ServiceResponse<[T]>) -> Void) {
        ServiceHelper.restManager().request(url, method: method, parameters: parameters, encoding: method == .get ? URLEncoding.default : JSONEncoding.default, headers: headers)
            .validate(statusCode: [HttpStatusCode.success.code, HttpStatusCode.accepted.code, HttpStatusCode.created.code])
            .responseData(completionHandler: { (response) in
                responseForArray(response: response, callback: callback)
            })
    }
    
}
