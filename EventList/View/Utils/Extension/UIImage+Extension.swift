//
//  UIImage+Extension.swift
//  EventList
//
//  Created by EDILBERTO DA SILVA RAMOS JUNIOR on 25/05/20.
//  Copyright © 2020 Edilberto Ramos. All rights reserved.
//

import UIKit

extension UIImage {

    public func af_imageRounded(withCornerRadius radius: CGFloat, divideRadiusByImageScale: Bool = false) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)

        let scaledRadius = divideRadiusByImageScale ? radius / scale : radius

        let clippingPath = UIBezierPath(roundedRect: CGRect(origin: CGPoint.zero, size: size), cornerRadius: scaledRadius)
        clippingPath.addClip()

        draw(in: CGRect(origin: CGPoint.zero, size: size))

        let roundedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return roundedImage
    }
    
}
