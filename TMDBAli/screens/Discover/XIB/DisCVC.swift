//
//  DisCVC.swift
//  TMDBAli
//
//  Created by Ali Moustafa on 03/07/2023.
//

import UIKit

class DisCVC: UICollectionViewCell, ConfigurableCell {
    
    func configure(with data: ResultMovie) {
        let imgPath = NetworkConstants.baseImageUrl + (data.posterPath ?? "")
        imageView.kf.setImage(with: URL(string: imgPath))
        nameOfMovie.text = data.title
        desOfMovie.text = data.overview
        
    }
    
    typealias DataType = ResultMovie
    
    @IBOutlet weak var theMainView: UIView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var deatailsView: UIView!
    
    @IBOutlet weak var nameOfMovie: UILabel!
    
    @IBOutlet weak var desOfMovie: UITextView!
    
    @IBOutlet weak var detailsButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        detailsButton.layer.cornerRadius = 5
        detailsButton.clipsToBounds = true

        let cornerRadius: CGFloat = 10.0

        deatailsView.layer.cornerRadius = cornerRadius
        deatailsView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        deatailsView.clipsToBounds = true

        
        theMainView.layer.cornerRadius = 20
        theMainView.clipsToBounds = true

        
        // Initialization code
    }
    @IBOutlet weak var detclickout: UIButton!
    
    @IBAction func detailsTapped(_ sender: Any) {
        
    }
    
    
}

