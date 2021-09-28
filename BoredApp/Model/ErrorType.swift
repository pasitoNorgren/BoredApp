//
//  ErrorType.swift
//  BoredApp
//
//  Created by Матвей Бойков on 28.09.2021.
//

import Foundation

enum ErrorType : String {
    case networkConnection = "Check my internet connection"
    case parsing = "Change parameters"
    case noDataFromServer = "Server is in trouble, ok"
}
