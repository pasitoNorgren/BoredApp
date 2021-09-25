//
//  NetworkCall.swift
//  BoredApp
//
//  Created by Матвей Бойков on 25.09.2021.
//

import Foundation


class NetworkCall {
    
    let executor : Executor?
    let optionalURL : URL?
    var model : Content?
    
    init(for ex : Executor?, accordingTo url : URL?) {
        self.executor = ex
        self.optionalURL = url
    }
        
    func getData() {
        guard let url = optionalURL else { return }
        fetchRequest(with: url)
    }
    func fetchRequest(with url : URL) {
        let group = DispatchGroup()
        group.enter()
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            defer { group.leave() }
            if error != nil {
                print("bruh")
            }
            if let safeData = data {
                if let givenModel = Parser.parseJSON(with: safeData) {
                    self.model = givenModel
                }
            }
        }
        task.resume()
        
        group.notify(queue: .main) {
            guard let _ = self.executor else { return }
            self.executor?.okay(content: self.model)
        }
        
    }
}

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
