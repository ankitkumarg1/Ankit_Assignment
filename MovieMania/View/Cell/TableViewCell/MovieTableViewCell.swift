//
//  MovieTableViewCell.swift
//  MovieMania
//
//  Created by neosoft on 7/11/24.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!{
        didSet{
            containerView.layer.cornerRadius = 10
        }
    }
    
    var movie: MoviesListModel?{
        didSet{
            setData()
        }
    }
    
    func setData(){
        movieNameLabel.text = movie?.name ?? ""
        movieDescriptionLabel.text = movie?.description ?? ""
        if let urlString = movie?.image, let url = URL(string:urlString){
            posterImageView.setImage(from: url, placeholder: UIImage(named: ImageConstant.placeholder_icon))
        }else{
            posterImageView.image = UIImage(named: ImageConstant.placeholder_icon)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        posterImageView.layer.cornerRadius =  10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
