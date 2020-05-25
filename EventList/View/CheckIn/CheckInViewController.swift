//
//  CheckInViewController.swift
//  EventList
//
//  Created by EDILBERTO DA SILVA RAMOS JUNIOR on 24/05/20.
//  Copyright © 2020 Edilberto Ramos. All rights reserved.
//

import UIKit

class CheckInViewController: UIViewController {

    private let checkInView = CheckInView.init()
    
    convenience init(eventId: String) {
        self.init()
    }
    
    override func loadView() {
        self.view = checkInView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyStyle()
        applyLanguage()
    }

}

//MARK: - Apply
extension CheckInViewController {
    
    private func applyLanguage() {
        title = "Faça seu Check-in"
    }
    
    private func applyStyle() {
        checkInView.buttonCheckIn.addTarget(self, action: #selector(checkIn), for: .touchUpInside)
    }
}

//MARK: - Actions
extension CheckInViewController {
    
    @objc private func checkIn() {
        print("CheckIn")
    }
    
}

//MARK: - Rx Setup
extension EventDetailViewController {
    
    private func setup() {
    }

    
}
