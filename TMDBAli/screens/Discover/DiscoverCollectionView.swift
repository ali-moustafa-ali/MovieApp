//
//  DiscoverCollectionView.swift
//  TMDBAli
//
//  Created by Ali Moustafa on 03/07/2023.
//

import UIKit

extension DiscoverSB: CollectionView_Delegate_DataSource_FlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        moviesArray.count
    }
    
    @objc func detailTapped(sender: UIButton){
//        let vc  = CastViewController(nibName: "CastViewController", bundle: nil)
//        navigationController?.pushViewController(vc, animated: true)
        let vc = CastViewController(nibName: "CastViewController", bundle: nil)
        vc.id = sender.tag
        navigationController!.pushViewController(vc, animated: true)


        sender.tag
        //        detclickout
        print(sender.tag)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DisCVC", for: indexPath) as? DisCVC else {
            return UICollectionViewCell()
        }
        
        let movie = moviesArray[indexPath.item] // Assuming `moviesArray` is the array of Movie instances
        
        cell.detclickout.tag = movie.id ?? 0
        
        cell.detclickout.addTarget(self, action: #selector(detailTapped), for: .touchUpInside)
        cell.configure(with: movie)
        
        return cell
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        MoviesCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = collectionView.bounds.width
        let itemHeight = collectionView.bounds.height
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
}
