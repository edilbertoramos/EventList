//
//  EventViewController.swift
//  EventList
//
//  Created by EDILBERTO DA SILVA RAMOS JUNIOR on 22/05/20.
//  Copyright © 2020 Edilberto Ramos. All rights reserved.
//

import UIKit

class EventViewController: UIViewController {

    private let eventView = EventView.newAutoLayout()
    
    override func loadView() {
        self.view = eventView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventView.tableView.register(EventCell.self, forCellReuseIdentifier: EventCell.cellIdentifier)
        eventView.tableView.delegate = self
        eventView.tableView.dataSource = self
    }

}

//MARK: - Rx Setup
extension EventViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EventCell.cellIdentifier, for: indexPath) as! EventCell
        cell.fill(title: "Title \(indexPath.row+1)")
        
        return cell
    }
    
}
