//
//  MainManager.swift
//  testAnimeApp
//
//  Created by Wilson David Molina Lozano on 25/02/23.
//

import Foundation
import CoreData
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
    
    func saveAnimesData(_ animes: AnimeData) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        animes.data?.forEach { anime in
            let animesCoreData = AnimeInfo(context: appDelegate.persistentContainer.viewContext)
            animesCoreData.tittle = anime.title
            animesCoreData.image = anime.images?.jpg?.image_url
            animesCoreData.episodes = Int64(anime.episodes ?? 0)
            animesCoreData.status = anime.status
            animesCoreData.rating = anime.rating
            animesCoreData.score = Double(anime.score!)
            animesCoreData.type = anime.type
            animesCoreData.duration = anime.duration
            animesCoreData.synopsis = anime.synopsis
            appDelegate.saveContext()
            
        }
    }
    
    func getAnimes() -> [AnimeDescription] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return []
        }
        var animeData: [AnimeDescription] = []
        do {
            let fetchRequest: NSFetchRequest<AnimeInfo> = AnimeInfo.fetchRequest()
            let coreDataAnimes = try appDelegate.persistentContainer.viewContext.fetch(fetchRequest)
            coreDataAnimes.forEach {
                let dataCD = AnimeDescription(images: Image(jpg: Jpg(image_url: $0.image)),
                                              title: $0.tittle,
                                              episodes: Int($0.episodes),
                                              status: $0.status,
                                              rating: $0.rating,
                                              score: $0.score,
                                              type: $0.type,
                                              duration: $0.duration,
                                              synopsis: $0.synopsis)
                animeData.append(dataCD)
            }
        } catch {
            print(error.localizedDescription)
        }
        return animeData
    }
}


