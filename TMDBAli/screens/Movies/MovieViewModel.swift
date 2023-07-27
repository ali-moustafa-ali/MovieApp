//
//  MovieViewModel.swift
//  TMDBAli
//
//  Created by Ali Moustafa on 23/06/2023.
//

import Foundation

//getpopulurMovies

protocol MoviesProtocol: AnyObject{
    
    var moviesArray: [ResultMovie] {get set}
}

class MoviesViewModel {
    
    weak var moviesController: MoviesProtocol!
    
    init(moviesViewController: MoviesProtocol!) {
        self.moviesController = moviesViewController
        self.paginationHandler = MoviesPageWithPagination(controller: self)

    }
    
    var paginationHandler:MoviesPageWithPagination!
    
    //MARK: - pagenagian
    var moviesList: [ResultMovie] = []{
        didSet{
            moviesController.moviesArray = moviesList
        }
    }
    
    
    let netWork = RequestsHandler.shared
    
// paginacontroller
    
    
  

    
    func getMovies(for endpoint: MovieEndpoint = .popular, page: String) {
            let params: [String: Any] = [
                "api_key": NetworkConstants.baseParameters,
                "language": UserStatus.applicationLanguage,
                "page": page
            ]
print(params)
        
        switch endpoint {
        case .popular:
            netWork.getPopularMovies(params: params) {
                [weak self] result in
                switch result {
                case .success(let moviesModel):
                    if let moviesModelData = moviesModel.results {
                        
                        self?.paginationHandler.passListAndItemTotalFromApi(list: moviesModelData,
                                                                                                    totalFavsFromApi: 100)


//                        self?.moviesList = moviesModelData
                    } else {
                        print("Response has no data")
                    }
                case .failure(let error):
                    // Handle the failure case if needed
                    break
                }
            }
            // Add more cases for other movie endpoints if needed
        case .upcoming:
            netWork.getUpcomingMovies(params: params) {
                [weak self] result in
                switch result {
                case .success(let moviesModel):
                    if let moviesModelData = moviesModel.results {
                        
                        self?.paginationHandler.passListAndItemTotalFromApi(list: moviesModelData,
                                                                                                    totalFavsFromApi: 100)

//                        self?.moviesList = moviesModelData
                    } else {
                        print("Response has no data")
                    }
                case .failure(let error):
                    // Handle the failure case if needed
                    break
                }
            }
        // Add more cases for other movie endpoints if needed
        case .nowplaying:
            netWork.getNowPlayingMovies(params: params) {
                [weak self] result in
                switch result {
                case .success(let moviesModel):
                    if let moviesModelData = moviesModel.results {
                        
                        self?.paginationHandler.passListAndItemTotalFromApi(list: moviesModelData,
                                                                                                    totalFavsFromApi: 100)

//                        self?.moviesList = moviesModelData
                    } else {
                        print("Response has no data")
                    }
                case .failure(let error):
                    // Handle the failure case if needed
                    break
                }
            }
            // Add more cases for other movie endpoints if needed
        case .toprated:
            netWork.getTopRatedMovies(params: params) {
                [weak self] result in
                switch result {
                case .success(let moviesModel):
                    if let moviesModelData = moviesModel.results {
                        
                        self?.paginationHandler.passListAndItemTotalFromApi(list: moviesModelData,
                                                                                                    totalFavsFromApi: 100)

//                        self?.moviesList = moviesModelData
                    } else {
                        print("Response has no data")
                    }
                case .failure(let error):
                    // Handle the failure case if needed
                    break
                }
            }
            // Add more cases for other movie endpoints if needed

        }
    }

    
    

    

    
}


enum MovieEndpoint {
    case popular
    case upcoming
    case nowplaying
    case toprated
    // Add more cases for other movie endpoints if needed
}
