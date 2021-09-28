//
//  Interpreter.swift
//  BoredApp
//
//  Created by Матвей Бойков on 28.09.2021.
//

import Foundation


struct Interpreter {
    
    static func getCardViewTypeName(type : String) -> String {
        let activityType = ActivityType(rawValue: type)
        guard let safeActivityType = activityType else { return "" }
        let outputString = reversalRepresentation(OfActivityType: safeActivityType)
        return outputString
    }
    
    static func reversalRepresentation(OfActivityType : ActivityType) -> String {
        
        switch OfActivityType {
        case .education : return K.AtcivityTypes.education
        case .recreational : return K.AtcivityTypes.recreational
        case .social : return K.AtcivityTypes.social
        case .diy : return K.AtcivityTypes.diy
        case .charity : return K.AtcivityTypes.charity
        case .cooking : return K.AtcivityTypes.cooking
        case .relaxation : return K.AtcivityTypes.relaxation
        case .music : return K.AtcivityTypes.music
        case .busywork : return K.AtcivityTypes.busywork
        default : return K.AtcivityTypes.all
        }
    }
    
    static func representation(OfActivityType : String) -> ActivityType {
        switch OfActivityType {
        case K.AtcivityTypes.education : return .education
        case K.AtcivityTypes.recreational : return .recreational
        case K.AtcivityTypes.social : return .social
        case K.AtcivityTypes.diy : return .diy
        case K.AtcivityTypes.charity : return .charity
        case K.AtcivityTypes.cooking : return .cooking
        case K.AtcivityTypes.relaxation : return .relaxation
        case K.AtcivityTypes.music : return .music
        case K.AtcivityTypes.busywork  : return .busywork
        default : return .all
        }
    }
    
    static func requestShaper(buttonActivityType : ActivityType, participantsTitle : String, priceIsEnabled : Bool) -> (requestType : RequestType, model : FilteredContent? ) {
        
        var intermediateRequestType : RequestType = .randomActivity
        var intermediateContent : FilteredContent?
        var shouldPayAttentionToParticipantsCount = true
        
        shouldPayAttentionToParticipantsCount = Int(participantsTitle) != nil ? true : false
        
        if  ((buttonActivityType == .all) &&
            (priceIsEnabled == true) &&
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
