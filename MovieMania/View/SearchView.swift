//
//  SearchView.swift
//  MovieMania
//
//  Created by neosoft on 7/11/24.
//

import UIKit


class SearchView : UITableViewHeaderFooterView{
  
    @IBOutlet weak var searchBar: UISearchBar!{
        didSet{
            searchBar.searchTextField.backgroundColor = .clear
        }
    }

    
    var isEditingActive: Bool = false {
        didSet {
            searchBar.searchTextField.text = isEditingActive ? searchBar.searchTextField.text : ""
        }
    }
    
    var placeholder: String? = "" {
        didSet {
            searchBar.searchTextField.placeholder = "\(StringConstants.SEARCH) \(placeholder ?? "") ......"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
