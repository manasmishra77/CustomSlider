//
//  CustomSlider.swift
//  CustomSlider
//
//  Created by Manas Mishra on 14/02/19.
//  Copyright © 2019 manas. All rights reserved.
//

import UIKit

class CustomSlider: UISlider {
    
    override func thumbRect(forBounds bounds: CGRect, trackRect rect: CGRect, value: Float) -> CGRect {
        let val = CGFloat(value)
        var newRect = CGRect(x: val*bounds.width, y: bounds.minY, width: 50, height: 50)
        let x = val*bounds.width
        if x < 20 {
            newRect.origin.x = -20
        } else if x > (bounds.maxX - 20 - 50) {
            newRect.origin.x = bounds.maxX-20
        }
        return newRect
    }
//    override func trackRect(forBounds bounds: CGRect) -> CGRect {
//        return CGRect(x: 100, y: 100, width: 100, height: 100)
//    }

}
