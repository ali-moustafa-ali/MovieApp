//
//  DiscoverSB.swift
//  TMDBAli
//
//  Created by Ali Moustafa on 03/07/2023.
//

import UIKit
import MOLH

class DiscoverSB: UIViewController, MoviesProtocol {
    @IBOutlet weak var movies: UILabel!
    
    var viewModel: MoviesViewModel!

    @IBOutlet weak var MoviesCollectionView: UICollectionView!{
        didSet{
            MoviesCollectionView.delegate = self
            MoviesCollectionView.dataSource = self
        }
    }
    
    var moviesArray: [ResultMovie] = []{
        didSet{
            MoviesCollectionView.reloadData()
        }
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)

        //MARK: - addNibFileOfCollection
        movies.text = NSLocalizedString("movies_label_text", comment: "")

        setupCollectionView()

        
        
        //MARK: - MVVM
        viewModel = MoviesViewModel(moviesViewController: self)
        
        //MARK: - fireLoadData
        viewModel.getMovies(for: MovieEndpoint.popular, page: "1")

    }
    
    @IBAction func langTapped(_ sender: UIButton) {
        if Locale.preferredLanguages[0] == "ar"{
            UserStatus.applicationLanguage = "en-US"
            MOLH.setLanguageTo("en")
            MOLH.reset()
        } else {
            UserStatus.applicationLanguage = "ar-US"

            MOLH.setLanguageTo("ar")
            MOLH.reset()
        }
    }
    

}
extension DiscoverSB {
    
    private func setupCollectionView() {
        MoviesCollectionView.register(UINib(nibName: "DisCVC", bundle: nil), forCellWithReuseIdentifier: "DisCVC")
    }
}
