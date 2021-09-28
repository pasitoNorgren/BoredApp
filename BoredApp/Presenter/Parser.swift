//
//  Parser.swift
//  BoredApp
//
//  Created by Матвей Бойков on 25.09.2021.
//

import Foundation

class Parser {
    static func parseJSON(with data : Data) -> (Content?, String?) {
        let decoder = JSONDecoder()
        do {
            let model = try decoder.decode(Content.self, from: data)
            return (model, nil)
        } catch {
            return (nil, error.localizedDescription)
        }
    }
}
