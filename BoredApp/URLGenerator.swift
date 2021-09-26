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
            if let model = filteredModel {
                outputURLString += "participants=\(model.participants)&"
                if model.type != ActivityType.all.rawValue {
                    outputURLString += "type=\(model.type)&"
                }
                if !model.price {
                    outputURLString += "price=0"
                }
            }
        }
        if let outputURL = URL(string: outputURLString) {
            print(outputURL)
            return outputURL
        } else {
            return nil
        }
    }
    
        
}
