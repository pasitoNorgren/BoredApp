//
//  URLGenerator.swift
//  BoredApp
//
//  Created by Матвей Бойков on 25.09.2021.
//

import Foundation


struct URLGenerator {
    
    let requestType : RequestType
    let filteredModel : FilteredContent?
    
    let basicURLString : String = "https://www.boredapi.com/api/activity?"
    
    init(for type : RequestType, model filteredModel : FilteredContent?) {
        self.requestType = type
        self.filteredModel = filteredModel
    }
    
    func generateURL() -> URL? {
        var outputURLString = String()
        if requestType == .randomActivity {
            outputURLString = basicURLString
        }
        if requestType == .filteredActivity {
            outputURLString = basicURLString
            if let safeModel = filteredModel {
                if safeModel.type != ActivityType.all.rawValue {
                    outputURLString += "type=\(safeModel.type)&"
                }
                if safeModel.price == false {
                    outputURLString += "price=0&"
                }
                if let safeParticioants = safeModel.participants {
                    outputURLString += "participants=\(safeParticioants)&"
                }
            }
        }
        if let outputURL = URL(string: outputURLString) {
            return outputURL
        } else {
            return nil
        }
    }
    
        
}
