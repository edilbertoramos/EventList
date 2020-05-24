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

class EventViewController: UIViewController {

    private let eventView = EventView()
    private let disposeBag = DisposeBag()
    private var viewModel = EventViewModel()

    override func loadView() {
        self.view = eventView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        viewModel.fetchEvents()
    }

}

//MARK: - Rx Setup
extension EventViewController {
    
    private func setup() {
        title = "Events"
        eventView.tableView.register(EventCell.self, forCellReuseIdentifier: EventCell.cellIdentifier)
        setupTableView()
        setupError()
        setupSelection()
    }
    
    private func setupTableView() {
        viewModel.events.asObservable()
            .bind(to: eventView.tableView.rx.items) {
                tableView, row, event in
                let indexPath = IndexPath(row: row, section: 0)
                let cell = tableView.dequeueReusableCell(withIdentifier: EventCell.cellIdentifier, for: indexPath) as! EventCell
                cell.fill(event: event)
                return cell
        }.disposed(by: disposeBag)
    }
    
    private func setupError() {
        viewModel.errorMessage.asObservable()
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
    
    private func setupSelection() {
        eventView.tableView
            .rx
            .modelSelected(Event.self)
            .subscribe(onNext: { event in
                // TODO: - push to event detail -
                if let indexPath = self.eventView.tableView.indexPathForSelectedRow {
                    self.eventView.tableView.deselectRow(at: indexPath, animated: true)
                }
            })
            .disposed(by: disposeBag)
    }
    
}
