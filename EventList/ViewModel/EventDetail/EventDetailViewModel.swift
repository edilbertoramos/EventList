//
//  EventDetailViewModel.swift
//  EventList
//
//  Created by EDILBERTO DA SILVA RAMOS JUNIOR on 23/05/20.
//  Copyright © 2020 Edilberto Ramos. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class EventDetailViewModel: EventDetailViewModelProtocol {
    
    internal var eventId: String = ""
    internal var service: EventServiceProtocol = EventService()
    public var event: BehaviorRelay<Event?> = BehaviorRelay(value: nil)
    public var image: BehaviorRelay<UIImage?> = BehaviorRelay(value: nil)
    public var errorMessage: BehaviorRelay<String?> = BehaviorRelay(value: nil)

    init(eventId: String) {
        self.eventId = eventId
    }
    
    func fetchEvent() {
        service.event(with: self.eventId) { (serviceResponse) in
            if serviceResponse.isSuccess {
                self.event.accept(serviceResponse.data!)
            } else {
                self.errorMessage.accept(serviceResponse.errorMessage)
            }
        }
    }
    
    func fetchImage() {
        guard let uri = event.value?.image else { return }
        service.image(with: uri) { (success, data) in
            if success {
                if let data = data, let image = UIImage(data: data) {
                    self.image.accept(image)
                } else {
                    self.image.accept(ImageItem.template.image)
                }
            } else {
                self.image.accept(ImageItem.template.image)
            }
        }
    }
}
