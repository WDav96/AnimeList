//
//  MainConfiguration.swift
//  testAnimeApp
//
//  Created by Wilson David Molina Lozano on 25/02/23.
//

import UIKit

class MainConfiguration {

    static func configure(params: [String: Any] = [:]) -> UIViewController {
        let controller = MainViewController()
        let router = MainRouter(view: controller)
        let manager = MainManager()
        let viewModel = MainViewModel(manager: manager, view: controller)
        
        controller.viewModel = viewModel
        controller.router = router
        return controller
    }
    
}
