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
    case reloadFirstCV
    case errorMessage(String)
    case topError(Bool)
}

class MainViewModel {
    
    // MARK: - Properties
    
    private(set) var bestAnimes: [AnimeDescription] = []
    private(set) var bestAnimesFilter: [AnimeDescription] = []
    private(set) var animesDescription: [AnimeDescription] = []
    
    private var manager: MainManager
    
    var animesDescriptionCount: Int {
        animesDescription.count
    }
    
    // MARK: - Observable Properties
    
    var outputEvents: Observable<HomeViewModelOutput> {
        mutableOutputEvents
    }
    
    private let mutableOutputEvents = MutableObservable<HomeViewModelOutput>()

    // MARK: - Initializer
    
    init(manager: MainManager) {
        self.manager = manager
    }
    
    // MARK: - Methods
    
    func getBestAnimes() {
        mutableOutputEvents.postValue(.isLoading(true))
        manager.getBestAnimes { [weak self] result in
            self?.mutableOutputEvents.postValue(.isLoading(false))
            switch result {
            case .success(let bestAnimes):
                self?.bestAnimes = bestAnimes.data ?? []
                self?.bestAnimesFilter = bestAnimes.data ?? []
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
                self?.animesDescription.sort(by: { $0.score! > $1.score! })
                self?.mutableOutputEvents.postValue(.didGetData)
            case .failure(let error):
                self?.mutableOutputEvents.postValue(.errorMessage(error.localizedDescription))
            }
        }
    }
    
    func textFieldDidChangeSelection(text: String?) {
        guard let text = text else { return }
        Timer.scheduledTimer(withTimeInterval: 0.8, repeats: false) { [self] _ in
            
            bestAnimesFilter = bestAnimes
            
            if text.isEmpty {
                mutableOutputEvents.postValue(.reloadFirstCV)
                return
            }
            
            var filteredAnime: [AnimeDescription] = []
            for anime in bestAnimes {
                if let title = anime.title {
                    if title.lowercased().contains(text.lowercased()) {
                        filteredAnime.append(anime)
                    }
                }
            }
            
            bestAnimesFilter = filteredAnime
            mutableOutputEvents.postValue(.reloadFirstCV)
            
            mutableOutputEvents.postValue(.topError(filteredAnime.isEmpty ? false : true))
        }
    }
    
}
