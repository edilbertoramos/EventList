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
import PureLayout

class EventDetailViewController: UITableViewController {

    private let disposeBag = DisposeBag()
    private var viewModel: EventDetailViewModelProtocol?
    
    private let imageViewEvent: UIImageView = {
        let size = CGSize.init(width: 400, height: 340)
        let frame = CGRect.init(origin: .zero, size: size)
        let imageView = UIImageView.init(frame: frame)
        return imageView
    }()
    
    convenience init(eventId: String) {
        self.init()
        viewModel = EventDetailViewModel.init(eventId: eventId)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyStyle()
        applyLanguage()
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.fetchEvent()
    }
}

//MARK: - Apply
extension EventDetailViewController {
    
    private func applyLanguage() {
        title = "Event Detail"
    }
    
    private func applyStyle() {
        if #available(iOS 13.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        tableView.tableHeaderView = imageViewEvent
    }
}

//MARK: - Rx Setup
extension EventDetailViewController {
    
    private func setup() {
        setupEventData()
        setupError()
        setupImage()
    }
    
    private func setupEventData() {
        viewModel?.event.asObservable()
            .subscribe(onNext: {
                event in
                if let event = event {
                   print(event)
                    self.viewModel?.fetchImage()
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
    
    private func setupImage() {
        viewModel?.image.asObservable()
            .subscribe(onNext: {
                image in
                self.imageViewEvent.image = image
            })
            .disposed(by: disposeBag)
    }
    
}
