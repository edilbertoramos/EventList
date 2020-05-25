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
import SVProgressHUD

class EventDetailViewController: UITableViewController {

    private let disposeBag = DisposeBag.init()
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
        tableView.separatorStyle = .none
        tableView.tableHeaderView = imageViewEvent
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = estimateRowHeight
        tableView.register(EventDetailCell.self, forCellReuseIdentifier: EventDetailCell.cellIdentifier)
        tableView.register(EventLocationCell.self, forCellReuseIdentifier: EventLocationCell.cellIdentifier)

        let buttonShare = UIBarButtonItem.init(barButtonSystemItem: .action, target: self, action: #selector(share))
        navigationItem.rightBarButtonItem = buttonShare
    }
}

//MARK: - Actions
extension EventDetailViewController {
    
    @objc private func checkIn() {
        guard let eventId = viewModel?.eventId else { return }
        let controller = CheckInViewController.init(eventId: eventId)
        _ = navigationController?.pushViewController(controller, animated: true)
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
        SVProgressHUD.show()
        viewModel?.event.asObservable()
            .subscribe(onNext: {
                event in
                if let _ = event {
                    SVProgressHUD.dismiss()
                    self.viewModel?.fetchImage()
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func setupTableView() {
        viewModel?.details.asObservable()
            .bind(to: tableView.rx.items) {
                tableView, row, detail in
                if let eventDetail = detail as? EventDetail {
                    let cell = tableView.dequeueReusableCell(withIdentifier: EventDetailCell.cellIdentifier) as! EventDetailCell
                    cell.fill(eventDetail: eventDetail)
                    cell.buttonCheckIn.addTarget(self, action: #selector(self.checkIn), for: .touchUpInside)
                    return cell
                } else if let eventLocation = detail as? EventLocation {
                    let cell = tableView.dequeueReusableCell(withIdentifier: EventLocationCell.cellIdentifier) as! EventLocationCell
                    cell.fill(eventLocation: eventLocation)
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
                    SVProgressHUD.dismiss()
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
