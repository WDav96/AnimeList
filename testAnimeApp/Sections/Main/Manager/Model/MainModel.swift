//
//  MainModel.swift
//  testAnimeApp
//
//  Created by Wilson David Molina Lozano on 25/02/23.
//

import Foundation

struct AnimeData: Codable {
    let data: [AnimeDescription]?
}

struct AnimeDescription: Codable {
    let images: Image?
    let title: String?
    let episodes: Int?
    let status: String?
    let rating: String?
    let score: Double?
    let type: String?
    let duration: String?
    let synopsis: String?
}

struct Image: Codable {
    let jpg: Jpg?
}

struct Jpg: Codable {
    let image_url: String?
}
