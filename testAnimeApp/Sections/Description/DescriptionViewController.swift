//
//  DescriptionViewController.swift
//  testAnimeApp
//
//  Created by Wilson David Molina Lozano on 26/02/23.
//

import UIKit

class DescriptionViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var animeNameLabel: UILabel!
    @IBOutlet private weak var onAirLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var animeImage: UIImageView!
    @IBOutlet private weak var synopsisTextView: UITextView!
    
    
    //MARK: - Properties
    
    var animeDescription: AnimeDescription? {
        didSet {
            setupView()
        }
    }
    
    private var imageService = ImageService()
    private var isForMajors = false
    
    // MARK: - ViewController Methods

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Methods
    
    private func setupView() {
        let url = animeDescription?.images?.jpg?.image_url ?? ""
        self.view?.downloadImage(imageService: imageService, url: url, imageView: animeImage)
        
        animeNameLabel.text = animeDescription?.title
        onAirLabel.text = animeDescription?.status
        ratingLabel.text = animeDescription?.rating
        if ratingLabel.text!.contains("17") {
            isForMajors = true
        }
        synopsisTextView.text = animeDescription?.synopsis
        
        ratingLabel.backgroundColor = isForMajors ? .red : .systemGreen
    }

}
