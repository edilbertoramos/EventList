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
    private let estimateRowHeight: CGFloat = 400

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
        title = "Detalhes do evento"
    }
    
    private func applyStyle() {
        tableView.dataSource = nil
        tableView.delegate = nil
        tableView.tableHeaderView = imageViewEvent
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = estimateRowHeight
        tableView.register(EventDetailCell.self, forCellReuseIdentifier: EventDetailCell.cellIdentifier)

        let buttonCheckIn = UIBarButtonItem.init(title: "Check-In", style: .plain, target: self, action: #selector(checkIn))
        let buttonShare = UIBarButtonItem.init(barButtonSystemItem: .action, target: self, action: #selector(share))
        navigationItem.rightBarButtonItems = [buttonShare, buttonCheckIn]
        
        if #available(iOS 13.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
    }
}

//MARK: - Actions
extension EventDetailViewController {
    
    @objc private func checkIn() {
        print("CheckIn")
    }
    
    @objc private func share() {
        print("Share")
    }
}

//MARK: - Rx Setup
extension EventDetailViewController {
    
    private func setup() {
        setupEventData()
        setupTableView()
        setupError()
        setupImage()
    }
    
    private func setupEventData() {
        viewModel?.event.asObservable()
            .subscribe(onNext: {
                event in
                if let _ = event {
                    self.viewModel?.fetchImage()
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func setupTableView() {
        viewModel?.details.asObservable()
            .bind(to: tableView.rx.items) {
                tableView, row, detail in
                let indexPath = IndexPath(row: row, section: 0)
                if let eventDetail = detail as? EventDetail {
                    let cell = tableView.dequeueReusableCell(withIdentifier: EventDetailCell.cellIdentifier,
                                                             for: indexPath) as! EventDetailCell
                    cell.fill(eventDetail: eventDetail)
                    return cell
                } else {
                    return UITableViewCell.init()
                }
        }.disposed(by: disposeBag)
    }
    
    private func setupError() {
        viewModel?.errorMessage.asObservable()
            .subscribe(onNext: {
                message in
                if let message = message {
                    let alert = UIAlertController.init(title: "Ocorreu um erro", message: message, preferredStyle: .alert)
                    let action = UIAlertAction.init(title: "OK", style: .default) { (_) in
                        _ = self.navigationController?.popViewController(animated: true)
                    }
                    alert.addAction(action)
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
