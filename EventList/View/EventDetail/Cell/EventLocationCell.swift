//
//  EventLocationCell.swift
//  EventList
//
//  Created by EDILBERTO DA SILVA RAMOS JUNIOR on 24/05/20.
//  Copyright © 2020 Edilberto Ramos. All rights reserved.
//

import UIKit
import MapKit

class EventLocationCell: UITableViewCell {

    public static let cellIdentifier = "EventLocationCellIdentifier"
    private let margin: CGFloat = 16
    private let mapViewHeight: CGFloat = 200

    private let labelTitle: UILabel = {
        let label = UILabel.init()
        label.font = .boldSystemFont(ofSize: 20)
        label.text = "Local do evento"
        return label
    }()
    
    private let mapView: MKMapView = {
        let label = MKMapView.init()
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
    }
    
}

//MARK: Setup Cell
extension EventLocationCell {
    
    private func commonInit() {
        selectionStyle = .none
        addSubview(labelTitle)
        addSubview(mapView)
        autoLayout()
    }
    
    private func autoLayout() {
        labelTitle.autoPinEdge(toSuperviewEdge: .top, withInset: margin)
        labelTitle.autoPinEdge(toSuperviewEdge: .leading, withInset: margin)
        labelTitle.autoPinEdge(toSuperviewEdge: .trailing, withInset: margin)
        
        mapView.autoPinEdge(.top, to: .bottom, of: labelTitle, withOffset: margin/2)
        mapView.autoPinEdge(toSuperviewEdge: .leading, withInset: margin)
        mapView.autoPinEdge(toSuperviewEdge: .trailing, withInset: margin)
        mapView.autoPinEdge(toSuperviewEdge: .bottom, withInset: margin)
        mapView.autoSetDimension(.height, toSize: mapViewHeight)
    }
    
}

//MARK: Public Methods
extension EventLocationCell {
   
    public func fill(eventLocation: EventLocation) {
        setupLocation(eventLocation: eventLocation)
    }
 
}

//MARK: Location
extension EventLocationCell {
    
    private func setupLocation(eventLocation: EventLocation) {
        guard let latitude = eventLocation.latitude, let longitude = eventLocation.longitude else { return }
        let coordinate = CLLocationCoordinate2D.init(latitude: latitude, longitude: longitude)
        let annotation = MKPointAnnotation.init()
        let region = MKCoordinateRegion.init(center: coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
        annotation.coordinate = coordinate
        mapView.showsUserLocation = false
        mapView.addAnnotation(annotation)
        mapView.setCenter(coordinate, animated: true)
        mapView.setRegion(region, animated: true)
    }
    
}


