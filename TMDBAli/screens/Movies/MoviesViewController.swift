//
//  MoviesViewController.swift
//  TMDBAli
//
//  Created by Ali Moustafa on 19/06/2023.
//

import UIKit
import MOLH
class MoviesViewController: UIViewController, MoviesProtocol {
    
    @IBOutlet weak var movies: UILabel!
    var viewModel: MoviesViewModel!
    @IBOutlet weak var segmentTitle: UILabel!
    
    @IBOutlet weak var searchBarView: UIView!
    
    @IBOutlet weak var textFieldSearch: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    
    @IBOutlet weak var MoviesCollectionView: UICollectionView!{
        didSet{
            MoviesCollectionView.delegate = self
            MoviesCollectionView.dataSource = self
            MoviesCollectionView.prefetchDataSource = self

        }
    }
    
    
    @IBOutlet weak var MovieSegment: UISegmentedControl!
    
    var filteredMovies: [ResultMovie]?
    
    var moviesArray: [ResultMovie] = []{
        didSet{
            filteredMovies = moviesArray
            filterMovies()
            MoviesCollectionView.reloadData()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)

        movies.text = NSLocalizedString("movies_label_text", comment: "")
        
        localizeSegmentTitles()

        // Do any additional setup after loading the view.
        //MARK: - setupSearchView
        SearchViewSetupUtility.setupUI(for: searchBarView, textFieldSearch: textFieldSearch, searchButton: searchButton)
        //MARK: - SearchFunc
        textFieldSearch.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        //MARK: - addNibFileOfCollection
        setupCollectionView()
        
        //MARK: - MVVM
        viewModel = MoviesViewModel(moviesViewController: self)
        
        //MARK: - fireLoadData
        viewModel.getMovies(for: MovieEndpoint.popular, page: "1")
        
        //MARK: - Segment
        // Set the initial selected segment
        MovieSegment.selectedSegmentIndex = 0
        segmentTitle.text = MovieSegment.titleForSegment(at: 0)

        
        // Add a target-action for value changes
        MovieSegment.addTarget(self, action: #selector(segmentValueChanged), for: .valueChanged)
        
    }
    
    
    @IBAction func setLanguage(_ sender: Any) {
        
print(Locale.preferredLanguages[0])
        
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
    
    
    @objc func segmentValueChanged(sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex

        switch selectedIndex {
        case 0:
            viewModel.paginationHandler.onChangeStartOver()
            viewModel.getMovies(for: .popular, page: "1")
            segmentTitle.text = NSLocalizedString("popular_segment_title", comment: "")

        case 1:
            viewModel.paginationHandler.onChangeStartOver()
            viewModel.getMovies(for: .toprated, page: "1")
            segmentTitle.text = NSLocalizedString("toprated_segment_title", comment: "")

        case 2:
            viewModel.paginationHandler.onChangeStartOver()
            viewModel.getMovies(for: .upcoming, page: "1")
            segmentTitle.text = NSLocalizedString("upcoming_segment_title", comment: "")

        case 3:
            viewModel.paginationHandler.onChangeStartOver()
            viewModel.getMovies(for: .nowplaying, page: "1")
            segmentTitle.text = NSLocalizedString("nowplaying_segment_title", comment: "")

        default:
            break
        }
    }

}

    

extension MoviesViewController {
    
    private func setupCollectionView() {
        MoviesCollectionView.register(UINib(nibName: "MoviesCVC", bundle: nil), forCellWithReuseIdentifier: "cell")
    }
}

extension MoviesViewController {
    

    @objc func textFieldDidChange(_ textField: UITextField) {
           filterMovies()
           MoviesCollectionView.reloadData()
       }
    
    
    private func filterMovies() {
        guard let searchText = textFieldSearch.text?.lowercased().trimmingCharacters(in: .whitespacesAndNewlines), !searchText.isEmpty else {
            filteredMovies = moviesArray
            return
        }
        
        let searchWords = searchText.components(separatedBy: .whitespacesAndNewlines)
        
        filteredMovies = moviesArray.filter { movie in
            let movieName = movie.title?.lowercased()
            return searchWords.allSatisfy { word in movieName!.contains(word) }
        }
    }

    
    private func localizeSegmentTitles() {
        MovieSegment.setTitle(NSLocalizedString("popular_segment_title", comment: ""), forSegmentAt: 0)
        MovieSegment.setTitle(NSLocalizedString("toprated_segment_title", comment: ""), forSegmentAt: 1)
        MovieSegment.setTitle(NSLocalizedString("upcoming_segment_title", comment: ""), forSegmentAt: 2)
        MovieSegment.setTitle(NSLocalizedString("nowplaying_segment_title", comment: ""), forSegmentAt: 3)
    }

    
    
    
}
