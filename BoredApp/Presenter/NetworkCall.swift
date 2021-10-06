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
    
    func fetchRequest(with url : URL) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            self.giveDataBack(data: data, response: response, error: error)
        }
        task.resume()
    }
    
    func giveDataBack(data : Data?, response : URLResponse?, error : Error?) {
        handler.saveResponse(data: data, response: response, error: error)
    }
}
