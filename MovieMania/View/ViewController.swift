//
//  ViewController.swift
//  MovieMania
//
//  Created by neosoft on 7/11/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var floatingButton: UIButton!
    
    var viewModel : MoviesViewModel = MoviesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    func setUpUI(){
        //MARK: - Register completion to reload tableview
        viewModel.reloadData = {[weak self] animation in
            self?.reloadData(with: animation)
        }
        
        floatingButton.layer.cornerRadius = floatingButton.frame.size.height / 2
        registerCell()
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        viewModel.getData()
        reloadData()
    }
    
    func registerCell(){
        tableView.register(UINib(nibName:Identifier.carousalTableViewCell, bundle: nil), forCellReuseIdentifier: Identifier.carousalTableViewCell)
        tableView.register(UINib(nibName: Identifier.searchView, bundle: nil), forHeaderFooterViewReuseIdentifier:Identifier.searchView)
        tableView.register(UINib(nibName: Identifier.movieTableViewCell, bundle: nil), forCellReuseIdentifier: Identifier.movieTableViewCell)
    }
    
    private func reloadData(with animation: Bool  = false){
        if animation {
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.2) {
                    self.tableView.reloadData()
                }
            }
        } else {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension ViewController {
    
    @IBAction func floatingButtonAction(_ sender: UIButton){
        
        let viewControllerToPresent = BottomSheetViewController()
        viewControllerToPresent.categoryName = viewModel.getSelectedCategoryName()
        viewControllerToPresent.moviesCount = viewModel.getFilteredData()?.count ?? 0
        viewControllerToPresent.dict = viewModel.topThreeCharacters
            if let sheet = viewControllerToPresent.sheetPresentationController {
                let fraction = UISheetPresentationController.Detent.custom { context in
                    // height is the view.frame.height of the view controller which presents this bottom sheet
                    250.0
                }
                sheet.detents = [fraction,.medium()]
                sheet.largestUndimmedDetentIdentifier = .medium
                sheet.prefersScrollingExpandsWhenScrolledToEdge = false
                sheet.prefersEdgeAttachedInCompactHeight = true
                sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
            }
            present(viewControllerToPresent, animated: true, completion: nil)
         
    }
    
}

extension ViewController : UITableViewDelegate , UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.getSections().count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       let sectionType  = viewModel.getSections()
        switch sectionType[section] {
        case .top:
            return nil
        case .list:
            let searchView = tableView.dequeueReusableHeaderFooterView(withIdentifier: Identifier.searchView) as! SearchView
            searchView.searchBar.delegate = self
            searchView.searchBar.text = viewModel.searchText
            searchView.isEditingActive = viewModel.isEditingActive
            searchView.placeholder = viewModel.getSelectedCategoryName()
            return searchView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sectionType  = viewModel.getSections()
        switch sectionType[section] {
        case .top:
            return 0
        case .list:
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sections = viewModel.getSections()
        switch sections[indexPath.section] {
        case .top:
            guard let carouselCell: CarousalTableViewCell = tableView.dequeueReusableCell(withIdentifier: Identifier.carousalTableViewCell) as? CarousalTableViewCell else { return UITableViewCell() }
            carouselCell.currentIndex = viewModel.selectedIndex
            carouselCell.categories = viewModel.getCategories()
            carouselCell.updateBottomView = { [weak self] currentIndex in
                guard let strongSelf = self else { return }
                strongSelf.viewModel.selectedIndex = currentIndex
                strongSelf.reloadData()
            }
            return carouselCell
        case .list:
            guard let movieCell: MovieTableViewCell = tableView.dequeueReusableCell(withIdentifier: Identifier.movieTableViewCell) as? MovieTableViewCell else {return UITableViewCell() }
            let movie = viewModel.getFilteredData()?[indexPath.row]
            movieCell.movie = movie
            return movieCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == viewModel.getTopSection() {
            return UIScreen.main.bounds.size.height * 0.3
        }
        return UITableView.automaticDimension
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        viewModel.toggleEditingStatus(true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            searchBar.showsCancelButton = true
        })
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        //MARK: - Space at first index is restricted
        if text == " " && range.location == 0 {
            return false
        }
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.updateModel(with: searchBar.text)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        viewModel.updateModel(with: searchBar.text)
        viewModel.toggleEditingStatus(false)
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        //MARK: - Hide cancel on editing end
        viewModel.updateModel(with: searchBar.text)
        if !viewModel.isEditingActive {
            searchBar.showsCancelButton = false
        }
    }
    
}
