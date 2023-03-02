//
//  MovieInfo.swift
//  Moviermation
//
//  Created by Muhammed Emin Bardakcı on 1.03.2023.
//

import Foundation


struct MovieInfo: Codable {
    var original_title: String?
    var poster_path: String?
    var overview: String?
    var genres: [Genre]?
    var vote_average: Float?
    var release_date: String?
    var budget: Int?
    var revenue: Int?
}
struct Genre: Codable {
    var name: String?
}
