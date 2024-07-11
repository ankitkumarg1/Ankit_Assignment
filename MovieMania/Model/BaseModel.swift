//
//  BaseModel.swift
//  MovieMania
//
//  Created by neosoft on 7/11/24.
//

import Foundation

struct BaseModel: Codable {
    var data : DataModel?
}

struct DataModel: Codable  {
    var categories : [CategoryModel]?
}

struct CategoryModel: Codable , Identifiable{
    var id: Int?
    var name : String?
    var image: String?
    var movies : [MoviesListModel]?
}
struct MoviesListModel: Codable,Identifiable {
    var id : Int?
    var name : String?
    var image : String?
    var description: String?
}
