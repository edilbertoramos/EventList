//
//  CheckInViewController.swift
//  EventList
//
//  Created by EDILBERTO DA SILVA RAMOS JUNIOR on 24/05/20.
//  Copyright © 2020 Edilberto Ramos. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SVProgressHUD

class CheckInViewController: UIViewController {

    private let checkInView = CheckInView.init()
    private let disposeBag = DisposeBag.init()
    private var viewModel: CheckInViewModelProcotol?
    private let throttleIntervalInMilliseconds = 100
    
    convenience init(eventId: String) {
        self.init()
        viewModel = CheckInViewModel.init(eventId: eventId)
    }
    
    override func loadView() {
        self.view = checkInView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyStyle()
        applyLanguage()
        setup()
    }

}

//MARK: - Apply
extension CheckInViewController {
    
    private func applyLanguage() {
        title = "Faça seu Check-in"
    }
    
    private func applyStyle() {
        checkInView.buttonCheckIn.addTarget(self, action: #selector(checkIn), for: .touchUpInside)
    }
}

//MARK: - Actions
extension CheckInViewController {
    
    @objc private func checkIn() {
        view.endEditing(true)
        guard let name = checkInView.textFieldName.text, let email = checkInView.textFieldEmail.text else { return }
        SVProgressHUD.show()
        viewModel?.checkIn(name: name, email: email)
    }
    
}

//MARK: - Rx Setup
extension CheckInViewController {
    
    private func setup() {
        setupTextField()
        setupRequest()
    }

    private func setupTextField() {
        let nameValidate = checkInView.textFieldName
            .rx
            .text
            .observeOn(MainScheduler.asyncInstance)
            .distinctUntilChanged()
            .throttle(.milliseconds(throttleIntervalInMilliseconds), scheduler: MainScheduler.instance)
            .map { [unowned self] in
                $0?.nameValid(textField: self.checkInView.textFieldName) ?? false
        }
        
        nameValidate
            .subscribe(onNext: { [unowned self] in
                self.checkInView.textFieldName.valid = $0
            })
            .disposed(by: disposeBag)
        
        let mailValidate = checkInView.textFieldEmail
            .rx
            .text
            .observeOn(MainScheduler.asyncInstance)
            .distinctUntilChanged()
            .throttle(.milliseconds(throttleIntervalInMilliseconds), scheduler: MainScheduler.instance) //2
            .map { [unowned self] in
                $0?.emailValid(textField: self.checkInView.textFieldEmail) ?? false
        }
        mailValidate
            .subscribe(onNext: { [unowned self] in
                self.checkInView.textFieldEmail.valid = $0
            })
            .disposed(by: disposeBag)
        
        let everythingValid = Observable<Bool>
            .combineLatest(nameValidate, mailValidate) {
                $0 && $1
        }
        
        everythingValid
            .bind(to: checkInView.buttonCheckIn.rx.isEnabled)
            .disposed(by: disposeBag)
        
    }
    
    private func setupRequest() {
        viewModel?.requesSuccess.asObservable()
            .subscribe(onNext: {
                success in
                if let success = success, success {
                    SVProgressHUD.showSuccess(withStatus: "Check-in realizado com sucesso!")
                    SVProgressHUD.dismiss(withDelay: 2) {
                        _ = self.navigationController?.popViewController(animated: true)
                    }
                }
            })
            .disposed(by: disposeBag)
        
        viewModel?.errorMessage.asObservable()
            .subscribe(onNext: {
                message in
                if let message = message {
                    SVProgressHUD.dismiss()
                    let alert = UIAlertController.init(title: "Ocorreu um erro", message: message, preferredStyle: .alert)
                    let action = UIAlertAction.init(title: "OK", style: .default)
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
            })
            .disposed(by: disposeBag)
    }
    
}
