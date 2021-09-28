//
//  Constants.swift
//  BoredApp
//
//  Created by Матвей Бойков on 28.09.2021.
//

import Foundation


struct K {
    // Segue Identifier from ViewController to SettingsViewController
    static let VCtoSVCsegueIdentifier = "VCtoSVC"
    
    // Colour name of top right slider imageView at ViewController
    static let sliderTintColourName = "sliderTint"
    
    // Colour name of ViewController background
    static let mainBackgroundColourName = "mainBackground"
    
    // Main title of CDAlertView
    static let mainAlertTitle = "Oops, error occured"
    
    static let cardViewXibName = "CardView"
    
    // Data from server is nil description
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
