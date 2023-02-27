//
//  MainFactory.swift
//  testAnimeApp
//
//  Created by Wilson David Molina Lozano on 25/02/23.
//

import UIKit

class MainFactory {

    static func configure() -> UIViewController {
        let manager = MainManager()
        let router = MainRouter()
        let viewModel = MainViewModel(manager: manager)
        let controller = MainViewController(viewModel: viewModel, router: router)
        router.view = controller
        return controller
    }
    
}
