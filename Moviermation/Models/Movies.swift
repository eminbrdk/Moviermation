//
//  Movies.swift
//  Moviermation
//
//  Created by Muhammed Emin Bardakcı on 1.03.2023.
//

import Foundation


struct Movies: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let uuid = UUID()

    private enum CodingKeys : String, CodingKey { case poster_path, original_title, id }
    
    var poster_path: String?
    var original_title: String?
    let id: Int
}

// aynı movie den iki tane olamıyordu oyüzden bunu ekledik
extension Movie : Hashable {
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.uuid == rhs.uuid
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}
