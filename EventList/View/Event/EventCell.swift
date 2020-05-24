//
//  EventCell.swift
//  EventList
//
//  Created by EDILBERTO DA SILVA RAMOS JUNIOR on 23/05/20.
//  Copyright © 2020 Edilberto Ramos. All rights reserved.
//

import UIKit
import Alamofire

class EventCell: UITableViewCell {

    public static let cellIdentifier = "EventCellIdentifier"
    private let imageViewHeight: CGFloat = 400
    private let margin: CGFloat = 16

    private let labelTitle: UILabel = {
        let label = UILabel.init()
        return label
    }()
    
    private let imageViewEvent: UIImageView = {
        let imageView = UIImageView.init()
        imageView.contentMode = .scaleAspectFit
        return imageView
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
        textLabel?.text = nil
        imageView?.image = nil
    }

}

//MARK: Setup Cell
extension EventCell {
    
    private func commonInit() {
        addSubview(labelTitle)
        addSubview(imageViewEvent)
        autoLayout()
    }
    
    private func autoLayout() {
        labelTitle.autoPinEdge(toSuperviewEdge: .top, withInset: margin)
        labelTitle.autoPinEdge(toSuperviewEdge: .leading, withInset: margin)
        labelTitle.autoPinEdge(toSuperviewEdge: .trailing, withInset: -margin)

        imageViewEvent.autoPinEdge(.top, to: .bottom, of: labelTitle)
        imageViewEvent.autoPinEdge(toSuperviewEdge: .leading, withInset: margin)
        imageViewEvent.autoPinEdge(toSuperviewEdge: .trailing, withInset: margin)
        imageViewEvent.autoPinEdge(toSuperviewEdge: .bottom, withInset: margin)
        imageViewEvent.autoSetDimension(.height, toSize: imageViewHeight)
    }
}

//MARK: Public Methods
extension EventCell {
   
    public func fill(event: Event) {
        labelTitle.text = event.title
        imageViewEvent.image = ImageItem.template.image
    }
    
}
