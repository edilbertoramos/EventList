//
//  AppConfig.swift
//  EventList
//
//  Created by EDILBERTO DA SILVA RAMOS JUNIOR on 22/05/20.
//  Copyright © 2020 Edilberto Ramos. All rights reserved.
//

import Foundation

public struct AppConfig {
    
    public enum Key: String {
        case ServiceUrl
    }
    
    fileprivate enum ConfigMap: String {
        case Restful = "restful"
        case ProdUrl = "Prod URL"
    }
    
    static fileprivate var configDict: NSDictionary {
        guard let path = Bundle.main.path(forResource: "AppConfig", ofType: "plist"),
            let config = NSDictionary(contentsOfFile: path) else {
                NSException(name: NSExceptionName(rawValue: "Error"),
                            reason: "Create a .plist file with your config data",
                            userInfo: nil).raise()
                return NSDictionary()
        }
        
        return config
    }
    
    static public func config<T>(withKey key: Key) -> T {
        var finalKey = String()
        var finalConfigDict = NSDictionary()
        
        switch key {
        case .ServiceUrl:
            finalConfigDict = configDict[ConfigMap.Restful.rawValue] as! NSDictionary
            finalKey = ConfigMap.ProdUrl.rawValue
        }
        
        if finalKey.count <= 0 {
            NSException(name: NSExceptionName(rawValue: "Error"),
                        reason: "Invalid config type, register config at enum value Key and implement the case method",
                        userInfo: nil).raise()
        }
        
        return finalConfigDict[finalKey] as! T
    }
}
