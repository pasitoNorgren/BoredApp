//
//  NetworkCall.swift
//  BoredApp
//
//  Created by Матвей Бойков on 25.09.2021.
//

import Foundation


class NetworkCall<T : CanWorkWithNetworkResponse> {
    
    let handler : T
    
    init(handler : T) {
        self.handler = handler
    }
    
    func fetchRequest(with url : URL, complitionHandler : @escaping (() -> Void)) {
        let group = DispatchGroup()
        group.enter()
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            defer { group.leave() }
            self.giveDataBack(data: data, response: response, error: error)
        }
        task.resume()
        group.notify(queue: .main) {
            complitionHandler()
        }
    }
    
    func giveDataBack(data : Data?, response : URLResponse?, error : Error?) {
        handler.saveResponse(data: data, response: response, error: error)
    }
}
