//
//  MainAdapter.swift
//  testAnimeApp
//
//  Created by Wilson David Molina Lozano on 25/02/23.
//

import UIKit

class MainAdapter: NSObject {
    
    // MARK: - Properties
    
    var viewModel: MainViewModel
    var firstCV: UICollectionView
    
    // MARK: - Observable Properties
    
    var didSelectItemAt: Observable<AnimeDescription> {
        mutableDidSelectItemAt
    }
    
    private var mutableDidSelectItemAt = MutableObservable<AnimeDescription>()
    
    internal init(viewModel: MainViewModel, firstCV: UICollectionView) {
        self.viewModel = viewModel
        self.firstCV = firstCV
    }
    
}

extension MainAdapter: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        CGFloat(collectionView == firstCV ? viewModel.bestAnimesFilter.count : viewModel.animesDescriptionCount)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        collectionView == firstCV ? CGSize(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.height / 4) : CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == firstCV {
            self.mutableDidSelectItemAt.postValue(viewModel.bestAnimes[indexPath.row])
        } else {
            self.mutableDidSelectItemAt.postValue(viewModel.animesDescription[indexPath.row])
        }
    }
    
}

extension MainAdapter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionView == firstCV ? viewModel.bestAnimesFilter.count : viewModel.animesDescription.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == firstCV {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "firstCell", for: indexPath) as? FirstCVCell {
                cell.bestAnime = viewModel.bestAnimesFilter[indexPath.row]
                return cell
            } else {
                return UICollectionViewCell()
            }
        } else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "secondCell", for: indexPath) as? SecondCVCell {
                cell.animeDescription = viewModel.animesDescription[indexPath.row]
                return cell
            } else {
                return UICollectionViewCell()
            }
        }
    }
    
}
