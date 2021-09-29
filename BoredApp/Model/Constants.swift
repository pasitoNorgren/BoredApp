//
//  Constants.swift
//  BoredApp
//
//  Created by Матвей Бойков on 28.09.2021.
//

import Foundation


struct K {
    
    static let VCtoSVCsegueIdentifier = "VCtoSVC"
    
    
    static let sliderTintColourName = "sliderTint"
    
    
    static let mainBackgroundColourName = "mainBackground"
    
    
    static let mainAlertTitle = "Oops, error occured"
    
    static let cardViewXibName = "CardView"
    

    static let noDataText = "Something is going wrong in the cloud"
    
    static let basicUrlOfBoredAPI = "https://www.boredapi.com/api/activity?"
    
    struct AtcivityTypes {
        static let education = "Education"
        static let recreational = "Recreational"
        static let social = "Social"
        static let diy = "Diy"
        static let charity = "Charity"
        static let cooking = "Cooking"
        static let relaxation = "Relaxation"
        static let music = "Music"
        static let busywork = "Busy work"
        static let all = "All"
    }
    
    struct SettingsVC {
        static let participantsCountLabelForRandom = "Randomly"
        static let dismissButtonSuccess = "Apply changes"
        static let dismissButtonFail = "Dismiss the window"
    }    
}
