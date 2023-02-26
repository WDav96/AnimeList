//
//  MainAdapter.swift
//  testAnimeApp
//
//  Created by Wilson David Molina Lozano on 25/02/23.
//

import UIKit

class MainAdapter: NSObject {
    
    // MARK: - Properties
    
    var animeDescription: [AnimeDescription] = []
    
    
    // MARK: - Observable Properties
    
    var didSelectItemAt: Observable<AnimeDescription> {
        mutableDidSelectItemAt
    }
    
    private var mutableDidSelectItemAt = MutableObservable<AnimeDescription>()
    
}




