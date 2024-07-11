//
//  JsonParser.swift
//  MovieMania
//
//  Created by neosoft on 7/11/24.
//

import Foundation

class JsonParser {
    
    static func decodeJson<T: Codable>(from data: Data,in type: T.Type) -> T? {
        if let response = try? JSONDecoder().decode(T.self, from: data) {
        return response
        }else{
        return nil 
        }
    }
    
}
