//
//  UIViewControllerExtensions.swift
//  testAnimeApp
//
//  Created by Wilson David Molina Lozano on 27/02/23.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String) {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertView.addAction(.init(title: "Ok", style: .default))
        self.present(alertView, animated: true)
    }
    
}
