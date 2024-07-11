//
//  CarousalCollectionViewCell.swift
//  MovieMania
//
//  Created by neosoft on 7/11/24.
//

import UIKit

class CarousalCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var carousalImageView: UIImageView!
    
    var category : CategoryModel? {
        didSet{
            if let image = category?.image,let url = URL(string: image){
                carousalImageView.setImage(from: url, placeholder: UIImage(named: ImageConstant.placeholder_icon))
            }else{
                carousalImageView.image = UIImage(named: ImageConstant.placeholder_icon)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        carousalImageView.layer.cornerRadius = 10
    }

}
