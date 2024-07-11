//
//  Constants.swift
//  MovieMania
//
//  Created by neosoft on 7/11/24.
//

import Foundation
import UIKit

enum ColorConstants {
    static let ceruleanBlue = UIColor(hex: "#2C98F0")
    static let muteSage = UIColor(hex: "#ABB0AE")
    static let lightGray = UIColor(hex: "#E5EBEA")
    static let lightAqua = UIColor(hex: "#CDE8E1")
}

enum StringConstants {
    static let CANCEL = "Cancel"
    static let SEARCH = "Search"
    static let ITEMS = "items"
}

enum ImageConstant {
    static let placeholder_icon = "placeholder_icon"
    
    
}

enum FileName {
    static let moviesJson = "MoviesJson"
}

enum FileFormat: String{
    case json = "json"
}

enum Identifier {
    static let carousalTableViewCell =  "CarousalTableViewCell"
    static let searchView =  "SearchView"
    static let movieTableViewCell =  "MovieTableViewCell"
    static let carousalCollectionViewCell = "CarousalCollectionViewCell"
}
