//
//  Coordinator.swift
//  BoredApp
//
//  Created by Матвей Бойков on 24.09.2021.
//

import Foundation

class Coordinator : Mediator {
    
    static let shared = Coordinator()
    
    var delegate : Executor?
    
    private init() {}
    
    func notify(requestType: RequestType, filteredModel : FilteredContent? = nil) {
        guard let url = URLGenerator(for: requestType, model: filteredModel).generateURL() else { return }
        guard let safeDelegate = delegate else { return }
        
        safeDelegate.filterSettingsSetup(with: filteredModel)
        let handler = DataHandler(executor: safeDelegate)
        let _ = NetworkCall(handler: handler).fetchRequest(with: url) {
            handler.getDataFromNet()
        }
    }
}

protocol Executor {
    func performsAction(content : Content?, errorDescription : AlertInfo?)
    func filterSettingsSetup(with model : FilteredContent?)
}

protocol Mediator {
    func notify(requestType : RequestType, filteredModel : FilteredContent?)
}

enum RequestType {
    case randomActivity
    case filteredActivity
}

struct FilteredContent {
    let type : String
    let participants : String?
    let price : Bool
}

struct Content : Codable {
    let activity  : String
    let type : String
    let participants : Int
    let price : Double
}

enum ErrorType : String {
    case networkConnection = "Check my internet connection"
    case parsing = "Change my filter settings"
    case noDataFromServer = "Server is in trouble, ok"
}

struct AlertInfo {
    let errorType : ErrorType
    let errorDescriprion : String?
}

enum ActivityType : String {
    
    case all = ""
    case education = "education"
    case recreational = "recreational"
    case social = "social"
    case diy = "diy"
    case charity = "charity"
    case cooking = "cooking"
    case relaxation = "relaxation"
    case music = "music"
    case busywork = "busywork"
    
}

struct Interpreter {
    
    static func getCardViewTypeName(type : String) -> String {
        
        var outputString = String()
                
        if type.count > 0 {
            if type == ActivityType.busywork.rawValue {
                outputString = "Busy work"
            } else {
                outputString = String(type.prefix(1).capitalized) + String(type.suffix(type.count - 1).lowercased())
            }
        }
        return outputString
    }
    
    static func representation(OfActivityType : String) -> ActivityType {
        switch OfActivityType {
        case "Education" : return .education
        case "Recreational" : return .recreational
        case "Social" : return .social
        case "Diy" : return .diy
        case "Charity" : return .charity
        case "Cooking" : return .cooking
        case "Relaxation" : return .relaxation
        case "Music" : return .music
        case "Busy work"  : return .busywork
        default : return .all
        }
    }
    
    static func requestShaper(buttonActivityType : ActivityType, participantsTitle : String, priceIsEnabled : Bool) -> (requestType : RequestType, model : FilteredContent? ) {
        
        var intermediateRequestType : RequestType = .randomActivity
        var intermediateContent : FilteredContent?
        var shouldPayAttentionToParticipantsCount = true
        
        if let _ = Int(participantsTitle) {
            shouldPayAttentionToParticipantsCount = true
        } else {
            shouldPayAttentionToParticipantsCount = false
        }
        
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






