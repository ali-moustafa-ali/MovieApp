//
//  page.swift
//  TMDBAli
//
//  Created by Ali Moustafa on 30/06/2023.
//

import Foundation

class MoviesPageWithPagination{

    // api
    var totaItemsCountFromApi = 0
    var innerList: [ResultMovie] = []{
        didSet{
            viewModel.moviesList = innerList
//            guard let table = viewModel.MoviesCollectionView else{ return}
//            viewModel.MoviesCollectionView.reloadData()
        }
    }

    // fetching
    var currentPageNum = 1
    var isFetching = false

    weak var viewModel: MoviesViewModel!

    init(controller: MoviesViewModel!){
        self.viewModel = controller
    }


    func getData(){
        viewModel.getMovies(page: String(currentPageNum))
    }


    // api
    func passListAndItemTotalFromApi(list: [ResultMovie], totalFavsFromApi: Int?){

        innerList.append(contentsOf: list)

        if let total = totalFavsFromApi,
           total > self.innerList.count{
            totaItemsCountFromApi = total

            currentPageNum += 1

            isFetching = false
        }
    }

    func onChangeStartOver(){
        totaItemsCountFromApi = 0
        innerList = []

        currentPageNum = 1
        isFetching = false
    }
    
    // fetching
    func startFetchingOrNot(indexRow: Int){
        if indexRow >= innerList.count - 1 && !isFetching && (totaItemsCountFromApi > innerList.count) {
            isFetching = true
            getData()
        }
    }
}





// On controller

//class MovieListViewController: UIViewController {
//
//    var moviesPageWithPagination: MoviesPageWithPagination!
//    moviesPageWithPagination = MoviesPageWithPagination(controller: self)
//
//
//// In viewDidload
//
//        tableView.prefetchDataSource = self
//
//
//

//In network call
//
//       self.moviesPageWithPagination.passListAndItemTotalFromApi(list: res.data?.movies ?? [],
//                                                                            totalFavsFromApi: 100)




//In prefetch rows, or WillDisplay

// MARK: Pagination
//extension MovieListViewController : UITableViewDataSourcePrefetching{
//    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
//
//// this can be used on willDisplay and use index >- innerlist.count - 2
//        moviesPageWithPagination.startFetchingOrNot(indexRow: indexPaths.last!.row)
//    }
//}
//
//
//
////In table
//func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return moviesPageWithPagination.innerList.count
//    }


