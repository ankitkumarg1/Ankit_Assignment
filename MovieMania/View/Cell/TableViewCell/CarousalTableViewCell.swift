//
//  CarousalTableViewCell.swift
//  MovieMania
//
//  Created by neosoft on 7/11/24.
//

import UIKit

class CarousalTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var updateBottomView: ((Int) -> ())?
    
    var categories : [CategoryModel]?{
        didSet{
            pageControl.numberOfPages = categories?.count ?? 0
            pageControl.currentPage = currentIndex
            pageControl.currentPageIndicatorTintColor =  ColorConstants.ceruleanBlue
            pageControl.tintColor = ColorConstants.muteSage
        }
    }
    
    var currentIndex : Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName: Identifier.carousalCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Identifier.carousalCollectionViewCell)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension CarousalTableViewCell : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: CarousalCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.carousalCollectionViewCell, for: indexPath) as? CarousalCollectionViewCell else {return UICollectionViewCell() }
        cell.category = categories?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        self.currentIndex = pageControl.currentPage
        updateBottomView?(currentIndex)
    }
    
}
