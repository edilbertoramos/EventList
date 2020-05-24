//
//  EventDetailViewController.swift
//  EventList
//
//  Created by EDILBERTO DA SILVA RAMOS JUNIOR on 23/05/20.
//  Copyright © 2020 Edilberto Ramos. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class EventDetailViewController: UIViewController {

    private let eventDetailView = EventDetailView()
    private let disposeBag = DisposeBag()
    private var viewModel: EventDetailViewModelProtocol?
    
    convenience init(eventId: String) {
        self.init()
        viewModel = EventDetailViewModel.init(eventId: eventId)
    }
    
    override func loadView() {
        self.view = eventDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.fetchEvent()
    }
}

//MARK: - Rx Setup
extension EventDetailViewController {
    
    private func setup() {
        title = "Event Detail"
        setupEventData()
        setupError()
    }
    
    private func setupEventData() {
        viewModel?.event.asObservable()
            .subscribe(onNext: {
                event in
                if let event = event {
                   print(event)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func setupError() {
        viewModel?.errorMessage.asObservable()
            .subscribe(onNext: {
                message in
                if let message = message {
                    let alert = UIAlertController(title: "Ocorreu um erro", message: message, preferredStyle: .alert)
                    alert.addAction(.init(title: "OK", style: .default))
                    self.present(alert, animated: true, completion: nil)
                }
            })
            .disposed(by: disposeBag)
    }
    
}
