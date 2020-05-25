//
//  String+Extension.swift
//  EventList
//
//  Created by EDILBERTO DA SILVA RAMOS JUNIOR on 24/05/20.
//  Copyright © 2020 Edilberto Ramos. All rights reserved.
//

import UIKit

//MARK: - Validators
extension String {
    
    func emailValid(textField: UITextField) -> Bool {
        let trimmedText = trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        textField.text = trimmedText
        return trimmedText.isEmail
    }
    
    func nameValid(textField: UITextField) -> Bool {
        let trimmedText = trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        textField.text = trimmedText
        return trimmedText.isName
    }
    
    var isEmail: Bool {
        let trimmedText = trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let regexText = "^(([a-zA-Z0-9_\\-\\.]+)@([a-zA-Z0-9_\\-\\.]+)\\.([a-zA-Z]{2,5}){1,25})$"
        return trimmedText.matchPattern(regexText)
    }
    
    var isName: Bool {
        let trimmedText = trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let regexText = "(?<! )[-a-zA-Z' ]{2,26}"
        return trimmedText.matchPattern(regexText)
    }
    
    func matchPattern(_ patStr:String)->Bool {
          var isMatch:Bool = false
          do {
              let regex = try NSRegularExpression(pattern: patStr, options: [.caseInsensitive])
              let result = regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, count))
              
              if (result != nil) {
                  isMatch = true
              }
          }
          catch {
              isMatch = false
          }
          return isMatch
      }

}
