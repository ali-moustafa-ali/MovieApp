//
//  MoviesCollectionView.swift
//  TMDBAli
//
//  Created by Ali Moustafa on 19/06/2023.


import UIKit

extension MoviesViewController: CollectionView_Delegate_DataSource_FlowLayout{
    


    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(filteredMovies?.count, "count of array")

        return filteredMovies?.count ?? 0
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? MoviesCVC else {
            return UICollectionViewCell()
        }
        
        let movie = (filteredMovies?[indexPath.item])! // Assuming `filteredMovies` is the array of Movie instances
        
        // Configure the cell with movie data
        cell.configure(with: movie)
        
        // Set the initial state for the animation
        cell.transform = CGAffineTransform(translationX: 0, y: 50)
        cell.alpha = 0
        
        // Animate the cell to its final state
        UIView.animate(withDuration: 0.5, delay: 0.1 * Double(indexPath.item) - 1 , options: .curveEaseInOut, animations: {
            cell.transform = .identity
            cell.alpha = 1
        }, completion: nil)
        
        return cell
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        MoviesCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let selectedItem = filteredMovies?[indexPath.row].id

        
        let vc = CastViewController(nibName: "CastViewController", bundle: nil)

        vc.id = selectedItem
        navigationController!.pushViewController(vc, animated: true)

    }


    

    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = collectionView.bounds.width   // Adjust the number of items per row as needed
        let itemHeight = collectionView.bounds.height / 2
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
extension MoviesViewController : UICollectionViewDataSourcePrefetching{
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        viewModel.paginationHandler.startFetchingOrNot(indexRow: indexPaths.last!.row)

    }

}



////In table
//func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return moviesPageWithPagination.innerList.count
//    }
