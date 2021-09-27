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

class Colourist {
    static func giveMeColour(type : String) -> UIColor? {
        switch type {
        case "education" : return UIColor(red: 235/255, green: 87/255, blue: 87/255, alpha: 1)
        case "recreational" : return UIColor(red: 255/255, green: 147/255, blue: 0/255, alpha: 1)
        case "social" : return UIColor(red: 25/255, green: 67/255, blue: 72/255, alpha: 1)
        case "diy" : return UIColor(red: 33/255, green: 150/255, blue: 82/255, alpha: 1)
        case "charity" : return UIColor(red: 173/255, green: 133/255, blue: 238/255, alpha: 1)
        case "cooking" : return UIColor(red: 229/255, green: 95/255, blue: 168/255, alpha: 1)
        case "relaxation" : return UIColor(red: 47/255, green: 128/255, blue: 237/255, alpha: 1)
        case "music" : return UIColor(red: 255/255, green: 47/255, blue: 146/255, alpha: 1)
        case "busywork" : return UIColor(red: 64/255, green: 43/255, blue: 117/255, alpha: 1)
        default : return UIColor.gray
        }
    }
}
