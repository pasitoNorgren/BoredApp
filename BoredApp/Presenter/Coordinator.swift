//
//  Coordinator.swift
//  BoredApp
//
//  Created by Матвей Бойков on 24.09.2021.
//

import Foundation

protocol Executor {
    func performsAction(content : Content?, errorDescription : AlertInfo?)
    func filterSettingsSetup(with model : FilteredContent?)
}

protocol Mediator {
    func notify(requestType : RequestType, filteredModel : FilteredContent?)
}

class Coordinator : Mediator {
    
    static let shared = Coordinator()
    
    var delegate : Executor?
    
    private init() {}
    
    func notify(requestType: RequestType, filteredModel : FilteredContent? = nil) {
        guard let safeDelegate = delegate,
              let url = URLGenerator(for: requestType, model: filteredModel).generateURL()
        else { return }
        
        safeDelegate.filterSettingsSetup(with: filteredModel)
        let handler = DataHandler(executor: safeDelegate)
        let _ = NetworkCall(handler: handler).fetchRequest(with: url)
    }
}




