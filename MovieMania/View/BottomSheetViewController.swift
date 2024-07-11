//
//  BottomSheetViewController.swift
//  MovieMania
//
//  Created by neosoft on 7/11/24.
//

import UIKit

class BottomSheetViewController: UIViewController {

    @IBOutlet weak var categoryNameAndCountLabel: UILabel!
    @IBOutlet weak var firstLetterCountLabel: UILabel!
    @IBOutlet weak var secondLetterCountLabel: UILabel!
    @IBOutlet weak var thirdLetterCountLabel: UILabel!

    var dict: [[Character: Int]] = []
    var categoryName: String?
    var moviesCount : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    func setUpUI(){
        categoryNameAndCountLabel.text = "\(categoryName ?? "") = (\(moviesCount ?? 0) \(StringConstants.ITEMS))"
        for (index,dic) in dict.enumerated() {
            if index == 0{
                if let key = dic.keys.first,let value = dic.values.first {
                    firstLetterCountLabel.text = "\(key) = \(value)"
                }
            }else if index == 1 {
                if let key = dic.keys.first,let value = dic.values.first {
                    secondLetterCountLabel.text = "\(key) = \(value)"
                }
            }else {
                if let key = dic.keys.first,let value = dic.values.first {
                    thirdLetterCountLabel.text = "\(key) = \(value)"
                }
            }
        }
    }

}
