//
//  EventView.swift
//  EventList
//
//  Created by EDILBERTO DA SILVA RAMOS JUNIOR on 23/05/20.
//  Copyright © 2020 Edilberto Ramos. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import PureLayout

class EventView: UIView {
    
    public let tableView = UITableView.newAutoLayout()
    private let estimateRowHeight: CGFloat = 400
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = estimateRowHeight
        autoLayout()
    }

    private func autoLayout() {
        tableView.autoPinEdgesToSuperviewEdges()
    }
    
}
