//
//  EventViewController.swift
//  EventList
//
//  Created by EDILBERTO DA SILVA RAMOS JUNIOR on 22/05/20.
//  Copyright © 2020 Edilberto Ramos. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SVProgressHUD

class EventViewController: UITableViewController {

    private let eventView = EventView.init()
    private let disposeBag = DisposeBag.init()
    private var viewModel: EventViewModelProtocol?
    
    override func loadView() {
        self.view = eventView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyStyle()
        applyLanguage()
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.fetchEvents()
    }
}

//MARK: - Apply
extension EventViewController {
    
    private func applyLanguage() {
        title = "Eventos"
    }
    
    private func applyStyle() {
        eventView.tableView.register(EventCell.self, forCellReuseIdentifier: EventCell.cellIdentifier)
        if #available(iOS 13.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
    }
}

//MARK: - Rx Setup
extension EventViewController {
    
    private func setup() {
        viewModel = EventViewModel.init()
        setupTableView()
        setupError()
        setupSelection()
    }
    
    private func setupTableView() {
        SVProgressHUD.show()
        viewModel?.events.asObservable()
            .bind(to: eventView.tableView.rx.items) {
                tableView, row, event in
                SVProgressHUD.dismiss()
                let indexPath = IndexPath(row: row, section: 0)
                let cell = tableView.dequeueReusableCell(withIdentifier: EventCell.cellIdentifier, for: indexPath) as! EventCell
                cell.fill(event: event)
                return cell
        }.disposed(by: disposeBag)
    }
    
    private func setupError() {
        viewModel?.errorMessage.asObservable()
            .subscribe(onNext: {
                message in
                if let message = message {
                    let alert = UIAlertController(title: "Ocorreu um erro", message: message, preferredStyle: .alert)
                    let action = UIAlertAction.init(title: "Tentar novamente", style: .default) { (_) in
                        self.viewModel?.fetchEvents()
                    }
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func setupSelection() {
        eventView.tableView
            .rx
            .modelSelected(Event.self)
            .subscribe(onNext: { event in
                if let indexPath = self.eventView.tableView.indexPathForSelectedRow {
                    self.eventView.tableView.deselectRow(at: indexPath, animated: true)
                }
                if let eventId = event.id {
                    DispatchQueue.main.async {
                        let controller = EventDetailViewController.init(eventId: eventId)
                        _ = self.navigationController?.pushViewController(controller, animated: true)
                    }
                }
            })
            .disposed(by: disposeBag)
    }
    
}
