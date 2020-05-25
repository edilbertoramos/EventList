//
//  EventDetailCell.swift
//  EventList
//
//  Created by EDILBERTO DA SILVA RAMOS JUNIOR on 24/05/20.
//  Copyright © 2020 Edilberto Ramos. All rights reserved.
//

import UIKit

class EventDetailCell: UITableViewCell {

    public static let cellIdentifier = "EventDetailCellIdentifier"
    private let margin: CGFloat = 16

    private let labelTitle: UILabel = {
        let label = UILabel.init()
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let labelDate: UILabel = {
        let label = UILabel.init()
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let labelPrice: UILabel = {
        let label = UILabel.init()
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let labelDescription: UILabel = {
        let label = UILabel.init()
        label.numberOfLines = 0
        label.textColor = .systemGray
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        labelTitle.text = nil
        labelDate.text = nil
        labelPrice.text = nil
        labelDescription.text = nil
    }

}

//MARK: Setup Cell
extension EventDetailCell {
    
    private func commonInit() {
        selectionStyle = .none
        addSubview(labelTitle)
        addSubview(labelDate)
        addSubview(labelPrice)
        addSubview(labelDescription)
        autoLayout()
    }
    
    private func autoLayout() {
        labelTitle.autoPinEdge(toSuperviewEdge: .top, withInset: margin)
        labelTitle.autoPinEdge(toSuperviewEdge: .leading, withInset: margin)
        labelTitle.autoPinEdge(toSuperviewEdge: .trailing, withInset: margin)
        
        labelPrice.autoPinEdge(.top, to: .bottom, of: labelTitle, withOffset: margin/3)
        labelPrice.autoPinEdge(toSuperviewEdge: .leading, withInset: margin)
        
        labelDate.autoAlignAxis(.horizontal, toSameAxisOf: labelPrice)
        labelDate.autoPinEdge(toSuperviewEdge: .trailing, withInset: margin)

        labelDescription.autoPinEdge(.top, to: .bottom, of: labelPrice, withOffset: margin)
        labelDescription.autoPinEdge(toSuperviewEdge: .leading, withInset: margin)
        labelDescription.autoPinEdge(toSuperviewEdge: .trailing, withInset: margin)
        labelDescription.autoPinEdge(toSuperviewEdge: .bottom, withInset: margin)
    }
    
}

//MARK: Public Methods
extension EventDetailCell {
   
    public func fill(eventDetail: EventDetail) {
        labelTitle.text = eventDetail.title
        labelDate.text = eventDetail.date
        labelPrice.text = eventDetail.price
        labelDescription.text = eventDetail.description
    }
    
}
