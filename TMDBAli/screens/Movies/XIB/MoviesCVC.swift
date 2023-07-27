//
//  MoviesCVC.swift
//  TMDBAli
//
//  Created by Ali Moustafa on 20/06/2023.
//

import UIKit
import Kingfisher

class MoviesCVC: UICollectionViewCell, ConfigurableCell {
    
    func configure(with data: ResultMovie) {
        let imgPath = NetworkConstants.baseImageUrl + (data.posterPath ?? "")
        
        movieImageView.kf.setImage(with: URL(string: imgPath))
        movieTitleLabel.text = data.title
        moviesVoteAverageLabel.text = "\(data.voteAverage ?? 0.0)"
        configProgress(valeu: data.voteAverage ?? 0)
        movieDateLabel.text = data.releaseDate
        movieOverviewTextView.text = data.overview


    }
    
    typealias DataType = ResultMovie
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var moviesVoteAverageLabel: UILabel!
    
    @IBOutlet weak var VoteAverageView: CircleProgressView!
    
    @IBOutlet weak var movieDateLabel: UILabel!
    @IBOutlet weak var movieOverviewTextView: UITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        movieImageView.layer.cornerRadius = 20  // Adjust the corner radius value as desired
        movieImageView.clipsToBounds = true

    }

    override func layoutSubviews() {
        super.layoutSubviews()

    }
    
    func configProgress(valeu: Double){
        VoteAverageView.trackColor = UIColor.gray.withAlphaComponent(0.2)
        VoteAverageView.progressColor = UIColor.orange
        VoteAverageView.setProgressWithAnimation(duration: 1.0, value: valeu / 10)
    }
    
}
