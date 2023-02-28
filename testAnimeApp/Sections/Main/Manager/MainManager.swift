//
//  MainManager.swift
//  testAnimeApp
//
//  Created by Wilson David Molina Lozano on 25/02/23.
//

import Foundation
import UIKit

protocol IMainManager {
    func getBestAnimes(completionHandler: @escaping ((Result<AnimeData, Error>) -> Void))
    func getAnimesDescription(completionHandler: @escaping ((Result<AnimeData, Error>) -> Void))
}

enum APIRouter {
    
    case getBestAnimes
    case getAnimesDescription
    
    var path: String {
        "https://api.jikan.moe/v4/"
    }
    
    var url: String {
        switch self {
            case .getBestAnimes:
                return path + "top/anime"
            case .getAnimesDescription:
                return path + "anime"
        }
    }
    
}

class MainManager: IMainManager {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getBestAnimes(completionHandler: @escaping ((Result<AnimeData, Error>) -> Void)) {
        guard let url = URL(string: APIRouter.getBestAnimes.url) else { return }
        URLSession.shared.request(url: url, expecting: AnimeData.self) { result in
            switch result {
            case .success(let data):
                completionHandler(.success(data))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getAnimesDescription(completionHandler: @escaping ((Result<AnimeData, Error>) -> Void)) {
        guard let url = URL(string: APIRouter.getAnimesDescription.url) else { return }
        URLSession.shared.request(url: url, expecting: AnimeData.self) { result in
            switch result {
            case .success(let data):
                completionHandler(.success(data))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
}


