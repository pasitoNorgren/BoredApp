//
//  Interpreter.swift
//  BoredApp
//
//  Created by Матвей Бойков on 28.09.2021.
//

import Foundation


struct Interpreter {
    
    static func getCardViewTypeName(type : String) -> String {
        guard let activityType = ActivityType(rawValue: type) else { return "" }
        let outputString = representation(of: activityType)
        return outputString
    }
    
    static func representation(of activityType: ActivityType) -> String {
        
        switch activityType {
        case .education : return "Education"
        case .recreational : return "Recreational"
        case .social : return "Social"
        case .diy : return "Diy"
        case .charity : return "Charity"
        case .cooking : return "Cooking"
        case .relaxation : return "Relaxation"
        case .music : return "Music"
        case .busywork : return "Busy work"
        default : return "All"
        }
    }
    
    static func requestShaper(buttonTitle : String, participantsTitle : String, priceIsEnabled : Bool) -> (requestType : RequestType, model : FilteredContent? ) {
        
        let buttonTitleProcessing = buttonTitle.lowercased().replacingOccurrences(of: " ", with: "")
        var buttonActivityType : ActivityType = .all
        if let activityType = ActivityType(rawValue: buttonTitleProcessing) {
            buttonActivityType = activityType
        }
        var intermediateRequestType : RequestType = .randomActivity
        var intermediateContent : FilteredContent?
        var shouldPayAttentionToParticipantsCount = true
        
        shouldPayAttentionToParticipantsCount = Int(participantsTitle) != nil
        
        if  ((buttonActivityType == .all) &&
            priceIsEnabled &&
            (shouldPayAttentionToParticipantsCount == false)) {
            intermediateRequestType = .randomActivity
            intermediateContent = nil
        } else if shouldPayAttentionToParticipantsCount == false {
            intermediateRequestType = .filteredActivity
            intermediateContent = FilteredContent(type: buttonActivityType.rawValue, participants: nil, price: priceIsEnabled)
        } else if shouldPayAttentionToParticipantsCount == true {
            intermediateRequestType = .filteredActivity
            intermediateContent = FilteredContent(type: buttonActivityType.rawValue, participants: participantsTitle, price: priceIsEnabled)
        }
        
        return (intermediateRequestType, intermediateContent)
        
    }
}
