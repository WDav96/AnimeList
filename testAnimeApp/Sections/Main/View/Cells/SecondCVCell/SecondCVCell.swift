//
//  SecondCVCell.swift
//  testAnimeApp
//
//  Created by Wilson David Molina Lozano on 25/02/23.
//

import UIKit

class SecondCVCell: UICollectionViewCell {

    // MARK: IBOutlets
    
    @IBOutlet private weak var animeImage: UIImageView!
    @IBOutlet private weak var categoryLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var episodeLabel: UILabel!
    @IBOutlet private weak var durationLabel: UILabel!
    
    // MARK: - Properties
    
    var animeDescription: AnimeDescription? {
        didSet {
            setupCell()
        }
    }
    
    private var imageService = ImageService()
    private var isTV = false
    
    // MARK: - Methods
    
    private func setupCell() {
        let url = animeDescription?.images?.jpg?.image_url ?? ""
        self.downloadImage(imageService: imageService, url: url, imageView: animeImage)
        
        categoryLabel.text = animeDescription?.type
        nameLabel.text = animeDescription?.title
        if categoryLabel.text == "TV" {
            isTV = true
        }
        episodeLabel.text = "Episodes: \(animeDescription?.episodes ?? 0)"
        durationLabel.text = animeDescription?.duration
        
        categoryLabel.backgroundColor = isTV ? .mainBlueColor : .red
    }

}
