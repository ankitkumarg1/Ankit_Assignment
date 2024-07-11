//
//  FileManager.swift
//  MovieMania
//
//  Created by neosoft on 7/11/24.
//

import Foundation

struct FileManager {
    
   static func getFileContent(with fileName: String, and format: FileFormat) -> Data? {
       guard let url =  Bundle.main.url(forResource: fileName, withExtension: format.rawValue) else {
           return nil
       }
       let  rData = try? Data(contentsOf: url)
       return rData
    }
    
}
