//
//  MainManager.swift
//  testAnimeApp
//
//  Created by Wilson David Molina Lozano on 25/02/23.
//

import Foundation

protocol IMainManager {
    func getBestAnimes(completionHandler: @escaping ((Result<AnimeData, Error>) -> Void))
    func getAnimesDescription(completionHandler: @escaping ((Result<AnimeData, Error>) -> Void))
}

class MainManager: IMainManager {
    
    func getBestAnimes(completionHandler: @escaping ((Result<AnimeData, Error>) -> Void)) {
        guard let url = URL(string: "https://api.jikan.moe/v4/top/anime") else { return }
        URLSession.shared.request(url: url, expecting: AnimeData.self) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    completionHandler(.success(data))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
        
    func getAnimesDescription(completionHandler: @escaping ((Result<AnimeData, Error>) -> Void)) {
        guard let url = URL(string: "https://api.jikan.moe/v4/anime") else { return }
        URLSession.shared.request(url: url, expecting: AnimeData.self) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    completionHandler(.success(data))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
        
}
