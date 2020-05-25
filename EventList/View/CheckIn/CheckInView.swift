//
//  CheckInView.swift
//  EventList
//
//  Created by EDILBERTO DA SILVA RAMOS JUNIOR on 24/05/20.
//  Copyright © 2020 Edilberto Ramos. All rights reserved.
//

import UIKit
import PureLayout

class CheckInView: UIView {
    
    private let margin: CGFloat = 16
    private let buttonCheckInSize: CGSize = CGSize.init(width: 100, height: 30)
    private let textFieldHeight: CGFloat = 30

    private let contentView = UIView.newAutoLayout()
    
    let textFieldName: ELTextField = {
        let textField = ELTextField.init()
        textField.placeholder = " Digite seu nome"
        textField.borderStyle = .none
        textField.backgroundColor = .groupTableViewBackground
        textField.layer.cornerRadius = 6
        textField.autocapitalizationType = .words
        textField.keyboardType = .default
        return textField
    }()
    
    let textFieldEmail: ELTextField = {
        let textField = ELTextField.init()
        textField.placeholder = " Digite seu email"
        textField.backgroundColor = .groupTableViewBackground
        textField.layer.cornerRadius = 6
        textField.autocapitalizationType = .none
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    internal let buttonCheckIn: UIButton = {
        let button = UIButton.init()
        button.setTitle("CHECK-IN", for: .normal)
        button.layer.cornerRadius = 6
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.setBackgroundColor(.systemBlue, for: .normal)
        button.isEnabled = false
        button.setBackgroundColor(UIColor.lightGray.withAlphaComponent(0.4), for: .disabled)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        addSubview(contentView)
        contentView.addSubview(textFieldName)
        contentView.addSubview(textFieldEmail)
        contentView.addSubview(buttonCheckIn)
        backgroundColor = .white
        autoLayout()
    }

    private func autoLayout() {
        contentView.autoPinEdgesToSuperviewSafeArea()
        
        textFieldName.autoPinEdge(toSuperviewEdge: .top, withInset: margin)
        textFieldName.autoPinEdge(toSuperviewEdge: .leading, withInset: margin)
        textFieldName.autoPinEdge(toSuperviewEdge: .trailing, withInset: margin)
        textFieldName.autoSetDimension(.height, toSize: textFieldHeight)
        
        textFieldEmail.autoPinEdge(.top, to: .bottom, of: textFieldName, withOffset: margin/2)
        textFieldEmail.autoPinEdge(toSuperviewEdge: .leading, withInset: margin)
        textFieldEmail.autoPinEdge(toSuperviewEdge: .trailing, withInset: margin)
        textFieldEmail.autoSetDimension(.height, toSize: textFieldHeight)

        buttonCheckIn.autoPinEdge(.top, to: .bottom, of: textFieldEmail, withOffset: margin)
        buttonCheckIn.autoAlignAxis(toSuperviewAxis: .vertical)
        buttonCheckIn.autoSetDimensions(to: buttonCheckInSize)
    }
    
}
