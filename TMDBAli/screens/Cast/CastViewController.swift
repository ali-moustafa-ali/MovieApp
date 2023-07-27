//
//  CastViewController.swift
//  TMDBAli
//
//  Created by Ali Moustafa on 03/07/2023.
//

import UIKit
import CoreImage

class CastViewController: UIViewController {
    @IBOutlet weak var arrow: UIButton!
    @IBOutlet weak var titleOfMovie: UILabel!
    var id: Int?
    @IBOutlet weak var backGround: UIImageView!
    private var blurEffectView: UIVisualEffectView?

    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var posterImg: UIImageView!
    
    @IBOutlet weak var desOfMovie: UILabel!
    var movieDetails: MovieDetails?{
        didSet{
            releaseDate.text = movieDetails?.releaseDate

            let imgPath2 = NetworkConstants.baseImageUrl + (movieDetails?.posterPath ?? "")
            
            posterImg.kf.setImage(with: URL(string: imgPath2))
            
            
            desOfMovie.text = movieDetails?.overview
            
            
            titleOfMovie.text = movieDetails?.title
            let imgPath = NetworkConstants.baseImageUrl + (movieDetails?.backdropPath ?? "")
            
            backGround.kf.setImage(with: URL(string: imgPath))
            applyBlurEffect()

        }
    }
    
    private func applyBlurEffect() {
        // Create a blur effect
        let blurEffect = UIBlurEffect(style: .light)
        
        // Create a blur effect view and add it as a subview to the background image view
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView?.frame = backGround.bounds
        backGround.addSubview(blurEffectView!)
    }

    @IBOutlet weak var movieID: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        posterImg.layer.cornerRadius = 20  // Adjust the corner radius value as desired
        posterImg.clipsToBounds = true

        setArrowButtonImage(arrow: arrow, imageName: "CaretLeft")
        if let id = id {
            getMovies(MovieID: String(describing: id))

        }
    }

    @IBAction func backTapped(_ sender: Any) {
            self.navigationController?.popViewController(animated: true)
    }

    
    func setArrowButtonImage(arrow: UIButton, imageName: String) {
        if UIView.userInterfaceLayoutDirection(for: arrow.semanticContentAttribute) == .rightToLeft {
            arrow.setImage(UIImage(named: imageName)?.imageFlippedForRightToLeftLayoutDirection(), for: .normal)
        } else {
            arrow.setImage(UIImage(named: imageName), for: .normal)
        }
    }
    
    func getMovies(MovieID: String) {
        print(UserStatus.applicationLanguage)
        let params: [String: Any] = [
            "api_key": NetworkConstants.baseParameters,
            "language": UserStatus.applicationLanguage,
            "id": MovieID
        ]
print(params)
     let netWork = RequestsHandler.shared

       
            netWork.getMovieDetails(params: params){
                [weak self] result in
                switch result {
                case .success(let moviesModel):
                        

                        self?.movieDetails = moviesModel
                 
                case .failure(let error):
                    // Handle the failure case if needed
                    break
                }
            }
         

        }
    }

  
