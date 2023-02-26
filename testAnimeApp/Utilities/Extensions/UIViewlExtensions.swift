//
//  UIViewExtensions.swift
//  testAnimeApp
//
//  Created by Wilson David Molina Lozano on 26/02/23.
//

import UIKit

extension UIView {
    
    func downloadImage(imageService: ImageService, url: String, imageView: UIImageView) {
        guard let url = URL(string: url) else { return }
        imageService.image(for: url) { image in
            imageView.image = image
        }
    }
    
}
