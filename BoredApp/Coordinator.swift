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
        let url = URLGenerator(for: requestType, model: filteredModel).generateURL()
        let network = NetworkCall(for: delegate, accordingTo: url).getData()
    }
}

protocol Executor {
    func okay(content : Content?)
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
    let participants : String
    let price : Bool
}

struct Content : Codable {
    let activity  : String
    let type : String
    let participants : Int
    let price : Double
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
        case "Busywork"  : return .busywork
        default : return .all
        }
    }
}






