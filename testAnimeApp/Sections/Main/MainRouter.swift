//
//  MainRouter.swift
//  testAnimeApp
//
//  Created by Wilson David Molina Lozano on 25/02/23.
//

import UIKit

class MainRouter {
    
    // MARK: - Properties
    
    var view: MainViewController?
    
    init(view: MainViewController?) {
        self.view = view
    }
    
    // MARK: - Methods
    
    func goToDescription(animeDescription: AnimeDescription) {
        let vc = DescriptionViewController()
        vc.animeDescription = animeDescription
        vc.modalTransitionStyle = .flipHorizontal
        view?.present(vc, animated: true)
    }
    
}
