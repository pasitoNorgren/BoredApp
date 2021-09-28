//
//  DataHandler.swift
//  BoredApp
//
//  Created by Матвей Бойков on 26.09.2021.
//

import Foundation

protocol CanWorkWithNetworkResponse {
    var networkData : Data? { get set }
    var networkResponse : URLResponse? { get set }
    var networkError : Error? { get set }
    func saveResponse(data : Data?, response : URLResponse?, error : Error?)
}

class DataHandler : CanWorkWithNetworkResponse {
    
    let executor : Executor
    
    var networkData : Data?
    var networkResponse : URLResponse?
    var networkError : Error?
    
    init(executor : Executor) {
        self.executor = executor
    }
    
    func saveResponse(data : Data?, response : URLResponse?, error : Error?) {
        networkData = data
        networkResponse = response
        networkError = error
    }
    
    func getDataFromNet() {
        var errorString : String? = String()
        var errType : ErrorType = .networkConnection
        let error = errorHandling(error: networkError)
        
        // если пришла ошибка, то не парсю данные в принципе, отправляю сообщение об ошибке в алерт
        if error != nil {
            errorString = error
            errType = .networkConnection
            responseResult(info: AlertInfo(errorType: errType, errorDescriprion: errorString))
            return
        }

        let data = dataParsing(for: networkData)
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
                errType = .parsing
            }
        } else {
            errorFound = true
            errorString = K.noDataText
            errType = .noDataFromServer
        }
        
        if errorFound {
            responseResult(info: AlertInfo(errorType: errType, errorDescriprion: errorString))
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
    func responseResult(about model : Content? = nil, info description : AlertInfo? = nil) {
        executor.performsAction(content: model, errorDescription: description)
    }

}
