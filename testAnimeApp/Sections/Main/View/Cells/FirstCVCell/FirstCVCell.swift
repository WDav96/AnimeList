//
//  FirstCVCell.swift
//  testAnimeApp
//
//  Created by Wilson David Molina Lozano on 25/02/23.
//

import UIKit

class FirstCVCell: UICollectionViewCell {
    
    // MARK: - IBOulets
        
    @IBOutlet private weak var animeImage: UIImageView!
    
    // MARK: - Properties
    
    var bestAnime: AnimeDescription? {
        didSet {
            setupCell()
        }
    }
    
    private var imageService = ImageService()
    
    // MARK: - Methods
    
    func setupCell() {
        let url = bestAnime?.images?.jpg?.image_url ?? ""
        self.downloadImage(imageService: imageService, url: url, imageView: animeImage)
    }
    
}
