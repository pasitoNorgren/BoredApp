//
//  ActivityType.swift
//  BoredApp
//
//  Created by Матвей Бойков on 28.09.2021.
//

import UIKit


enum ActivityType : String {
    
    case all
    case education = "education"
    case recreational = "recreational"
    case social = "social"
    case diy = "diy"
    case charity = "charity"
    case cooking = "cooking"
    case relaxation = "relaxation"
    case music = "music"
    case busywork = "busywork"
    
    var color : UIColor {
        switch self {
        case .education :
            return UIColor(red: 235/255, green: 87/255, blue: 87/255, alpha: 1)
        case .recreational :
            return UIColor(red: 255/255, green: 147/255, blue: 0/255, alpha: 1)
        case .social :
            return UIColor(red: 25/255, green: 67/255, blue: 72/255, alpha: 1)
        case .diy:
            return UIColor(red: 33/255, green: 150/255, blue: 82/255, alpha: 1)
        case .charity:
            return UIColor(red: 173/255, green: 133/255, blue: 238/255, alpha: 1)
        case .cooking:
            return UIColor(red: 229/255, green: 95/255, blue: 168/255, alpha: 1)
        case .relaxation:
            return UIColor(red: 47/255, green: 128/255, blue: 237/255, alpha: 1)
        case .music:
            return UIColor(red: 255/255, green: 47/255, blue: 146/255, alpha: 1)
        case .busywork:
            return UIColor(red: 64/255, green: 43/255, blue: 117/255, alpha: 1)
        default :
            return UIColor.gray
        }
    }
    
}
