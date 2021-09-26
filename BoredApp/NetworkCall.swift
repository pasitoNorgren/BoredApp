//
//  NetworkCall.swift
//  BoredApp
//
//  Created by Матвей Бойков on 25.09.2021.
//

import Foundation


//class NetworkCall {
//    
//    let executor : Executor? // тут неважно, кому уйдут данные
//    var model : Content? // тут неважно, что за данные вообще
//    let optionalURL : URL? // по сути важно
//   
//    let group = DispatchGroup()
//    
//    init(for ex : Executor?, accordingTo url : URL?) {
//        self.executor = ex
//        self.optionalURL = url
//    }
//        
//    func getData() {
//        guard let url = optionalURL else { return }
//        fetchRequest(with: url)
//    }
//    func fetchRequest(with url : URL) {
//       
//        group.enter()
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            defer { self.group.leave() }
//            if error != nil {
//                print("bruh")
//            }
//            if let safeData = data {
//                if let givenModel = Parser.parseJSON(with: safeData).0 {
//                    self.model = givenModel
//                }
//            }
//        }
//        task.resume()
//        
//        group.notify(queue: .main) {
//            guard let _ = self.executor else { return }
//            self.executor?.okay(content: self.model)
//        }
//        
//        func giveDataBack(group : DispatchGroup, data : Data) {
//            
//        }
//    
//    }
//}

class NewNetworkCall<T : CanWorkWithNetworkResponse> {
    
    let handler : T
    
    init(handler : T) {
        self.handler = handler
    }
    
    func fetchRequest(with url : URL, complitionHandler : @escaping (() -> Void)) {
        let group = DispatchGroup()
        group.enter()
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            defer { group.leave() }
            self.getDataBack(data: data, response: response, error: error)
        }
        task.resume()
        group.notify(queue: .main) {
            complitionHandler()
        }
    }
    
    func getDataBack(data : Data?, response : URLResponse?, error : Error?) {
        handler.saveResponse(data: data, response: response, error: error)
    }
}

protocol CanWorkWithNetworkResponse {
    func saveResponse(data : Data?, response : URLResponse?, error : Error?)
}

class DataHandler : CanWorkWithNetworkResponse {
    
    let executor : Executor?
    
    var dataHandler : Data?
    var responseHandler : URLResponse?
    var errorHandler : Error?
    
    init(ex : Executor?) {
        self.executor = ex
    }
    
    func saveResponse(data : Data?, response : URLResponse?, error : Error?) {
        dataHandler  = data
        responseHandler = response
        errorHandler = error
    }
    
    func getDataFromNet() {
        var errorString : String? = "Something is going wrong in the cloud"
        let error = errorHandling(error: errorHandler)
        
        // если пришла ошибка, то не парсю данные в принципе, отправляю сообщение об ошибке в алерт
        if error != nil {
            errorString = error
            responseResult(info: errorString)
            return
        }

        let data = dataParsing(for: dataHandler)
        var errorFound : Bool = false
        var modelToSend : Content? = nil
      
        if let safeData = data {   // если по каким-то причинам даты вообще нет
            if let model = safeData.model {
                modelToSend = model
            } else {
                // если данные есть, но их невозможно распарсить, пришел ответ,
                // который не предполагался
                errorFound = true
                errorString = safeData.errorDescription
            }
        } else { errorFound = true }
        
        if errorFound {
            responseResult(info: errorString)
        } else {
            responseResult(about: modelToSend)
        }
    }
    
    func errorHandling(error : Error?) -> String? {
        return error != nil ? error?.localizedDescription : nil
    }
    
    func dataParsing(for data : Data?) -> (model : Content?, errorDescription : String?)? {
        guard let safeData = data else { return nil }
        return Parser.parseJSON(with: safeData)
    }
    func responseResult(about model : Content? = nil, info description : String? = nil) {
        guard let safeExecutor = executor else { return }
        safeExecutor.okay(content: model, errorString: description)
    }

}


