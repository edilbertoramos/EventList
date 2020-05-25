//
//  ELTextField.swift
//  EventList
//
//  Created by EDILBERTO DA SILVA RAMOS JUNIOR on 24/05/20.
//  Copyright © 2020 Edilberto Ramos. All rights reserved.
//

import UIKit

class ELTextField: UITextField {

    var valid: Bool = false {
      didSet {
        configureForValid()
      }
    }
    
    var hasBeenExited: Bool = false {
      didSet {
        configureForValid()
      }
    }
    
    override func resignFirstResponder() -> Bool {
      hasBeenExited = true
      return super.resignFirstResponder()
    }
    
    private func configureForValid() {
      if !valid && hasBeenExited {
        layer.borderColor = UIColor.red.cgColor
        layer.borderWidth = 1
      } else {
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 0
      }
    }

}
