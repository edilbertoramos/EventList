//
//  EventViewController.swift
//  EventList
//
//  Created by EDILBERTO DA SILVA RAMOS JUNIOR on 22/05/20.
//  Copyright © 2020 Edilberto Ramos. All rights reserved.
//

import UIKit
import PureLayout

class EventViewController: UIViewController {

    override func loadView() {
        self.view = EventView.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
