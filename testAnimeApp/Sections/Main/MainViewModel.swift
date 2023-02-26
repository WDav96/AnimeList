//
//  MainViewModel.swift
//  testAnimeApp
//
//  Created by Wilson David Molina Lozano on 25/02/23.
//

import Foundation

enum HomeViewModelOutput {
    case isLoading(Bool)
    case didGetData
    case errorMessage(String)
}

class MainViewModel {
    
    // MARK: - Properties
    
    var manager: MainManager
    var view: MainViewController
    var bestAnimes: [AnimeDescription] = []
    var animesDescription: [AnimeDescription] = []
    
    // MARK: - Observable Properties
    
    var outputEvents: Observable<HomeViewModelOutput> {
        mutableOutputEvents
    }
    
    private let mutableOutputEvents = MutableObservable<HomeViewModelOutput>()

    // MARK: - Initializer
    
    init(manager: MainManager, view: MainViewController) {
        self.manager = manager
        self.view = view
    }
    
    // MARK: - Methods
    
    func getBestAnimes() {
        mutableOutputEvents.postValue(.isLoading(true))
        manager.getBestAnimes { [weak self] result in
            self?.mutableOutputEvents.postValue(.isLoading(false))
            switch result {
            case .success(let bestAnimes):
                self?.bestAnimes = bestAnimes.data ?? []
                self?.mutableOutputEvents.postValue(.didGetData)
            case .failure(let error):
                self?.mutableOutputEvents.postValue(.errorMessage(error.localizedDescription))
            }
        }
    }
    
    func getAnimesDescription() {
        mutableOutputEvents.postValue(.isLoading(true))
        manager.getAnimesDescription { [weak self] result in
            self?.mutableOutputEvents.postValue(.isLoading(false))
            switch result {
            case .success(let animeData):
                self?.animesDescription = animeData.data ?? []
                self?.mutableOutputEvents.postValue(.didGetData)
            case .failure(let error):
                self?.mutableOutputEvents.postValue(.errorMessage(error.localizedDescription))
            }
        }
    }
    
}
