//
//  MoviesViewModel.swift
//  MovieMania
//
//  Created by neosoft on 7/11/24.
//

import Foundation

class MoviesViewModel: ObservableObject {
    
     enum Sections: Int, CaseIterable {
        case top
        case list
    }
    
    var categories: [CategoryModel] = []
    var searchText: String = ""
    var selectedIndex : Int = 0
   var categoryChanged : Bool = false
    
    var isEditingActive = false
    
    var reloadData: ((Bool) -> Void)?
    
    func toggleEditingStatus(_ editingEnabled: Bool){
        self.isEditingActive = editingEnabled
        reloadData?(true)
    }
    
    func updateModel(with text: String?){
        searchText = text ?? ""
        reloadData?(true)
    }
    
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
    
    func getSelectedCategoryName() -> String?{
        guard categories.count > 0 else {return "" }
        return categories[selectedIndex].name ?? ""
    }
    
    func getCategories() -> [CategoryModel]? {
        return categories
    }
    
    private var filteredMovies : [MoviesListModel]? {
        guard categories.count != 0 else { return [] }
        guard !searchText.isEmpty else { return categories[selectedIndex].movies }
        return categories[selectedIndex].movies?.filter { movies in
            movies.name?.lowercased().contains(searchText.lowercased()) ?? false
        }
    }
    
    func getFilteredData() -> [MoviesListModel]? {
        return filteredMovies
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
    
    func numberOfRowsInSection(section: Int) -> Int{
        return section == 0 ? (isEditingActive ? 0 : 1) : filteredMovies?.count ?? 0
    }
    
    func getTopSection() -> Int {
    return Sections.top.rawValue
    }
    
    func getSections() -> [Sections]{
        return Sections.allCases
    }
}
