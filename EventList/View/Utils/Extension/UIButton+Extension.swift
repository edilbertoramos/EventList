//
//  UIButton+Extension.swift
//  EventList
//
//  Created by EDILBERTO DA SILVA RAMOS JUNIOR on 25/05/20.
//  Copyright © 2020 Edilberto Ramos. All rights reserved.
//

import UIKit

extension UIButton {
    
    private func image(withColor color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State, cornerRadius: CGFloat = 0.0) {
        clipsToBounds = true
        self.setBackgroundImage(image(withColor: color)?.af_imageRounded(withCornerRadius: cornerRadius), for: state)
    }
}
