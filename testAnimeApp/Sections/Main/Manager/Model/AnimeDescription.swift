//
//  AnimeDescription.swift
//  testAnimeApp
//
//  Created by Wilson David Molina Lozano on 27/02/23.
//

import Foundation

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
