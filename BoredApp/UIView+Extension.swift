//
//  UIView+Extension.swift
//  BoredApp
//
//  Created by Матвей Бойков on 22.09.2021.
//

import Foundation
import UIKit


extension UIView {
    
    func round(by radius : Double = 1.0, theseCorners chosenCorners: UIRectCorner...) {

        let corners : UIRectCorner = .init(chosenCorners)
        let maskPath = UIBezierPath(roundedRect: self.bounds,
                                     byRoundingCorners: corners,
                                     cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
        
    }
}
