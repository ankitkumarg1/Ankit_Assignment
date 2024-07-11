//
//  MoviesViewModel.swift
//  MovieMania
//
//  Created by neosoft on 11/07/24.
//

import Foundation
import SwiftUI

class MoviesViewModel: ObservableObject {
    
    @Published var categories: [CategoryModel] = []
    @Published var searchText: String = ""
    @Published var selectedIndex : Int = 0
    @Published var categoryChanged : Bool = false
    @Published var isEditing: Bool = false
    var isFocused: Bool = false
    var topThreeCharacters : [[Character: Int]] {
        guard filteredMovies?.count ?? 0 > 0 else {return [[:]]}
        let namesArray =  filteredMovies?.map { $0.name }
        let names = namesArray?.compactMap{$0}
        let cocatanatedString = names?.joined() ?? ""
        var charCount = [Character: Int]()
        for char in cocatanatedString {
            if char != " " { // Ignoring spaces
                charCount[char, default: 0] += 1
            }
        }
        let sortedCharCount = charCount.sorted { $0.value > $1.value }
        let topThreeChars = sortedCharCount.prefix(3)
        var result: [[Character: Int]] = []
        for (char, count) in topThreeChars {
            result.append([char: count])
        }
        return result
    }
    var filteredMovies : [MoviesListModel]? {
        guard categories.count != 0 else { return [] }
        guard !searchText.isEmpty else { return categories[selectedIndex].movies }
        return categories[selectedIndex].movies?.filter { movies in
            movies.name?.lowercased().contains(searchText.lowercased()) ?? false
        }
    }
    
    func getData() {
        if let rData = FileManager.getFileContent(with: FileName.moviesJson, and: .json) {
            if let decodedModel: BaseModel = JsonParser.decodeJson(from: rData, in: BaseModel.self) {
                    self.categories = decodedModel.data?.categories ?? []
            } else {
                   self.categories = []
            }
            
        }
    }
    
}
