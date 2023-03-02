//
//  NetworkManager.swift
//  Moviermation
//
//  Created by Muhammed Emin Bardakcı on 1.03.2023.
//

import UIKit


class NetworkManager {
    
    static let shared = NetworkManager()
    private let apiUrl = "https://api.themoviedb.org/3/"
    private let apiKey = "fe057624f880e42fb64f6a17f96892b4"
    let decoder = JSONDecoder()
    
    func getMovies(moviename: String, page: Int) async throws -> [Movie] {
        let movienameForUrl = moviename.replacingOccurrences(of: " ", with: "-")
        let urlString = apiUrl + "search/movie?api_key=" + apiKey + "&query=" + movienameForUrl + "&page=\(page)"
        
        guard let url = URL(string: urlString) else { throw MovError.networkError }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw MovError.networkError }
        
        do {
            let movieResults = try decoder.decode(Movies.self, from: data)
            return movieResults.results
        } catch {
            throw MovError.networkError
        }
    }
    
    func getMovieInfo(id: Int) async -> MovieInfo? {
        let urlString = apiUrl + "/movie/\(id)?api_key=" + apiKey
        
        guard let url = URL(string: urlString) else { return nil }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return nil }
            
            do {
                let movieInfo = try decoder.decode(MovieInfo.self, from: data)
                return movieInfo
            } catch {
                return nil
            }
            
        } catch {
            return nil
        }
    }
    
    // bak bu nill ise place holder image yerleştir
    func downloadImage(imageLink: String) async -> UIImage? {
        let googleImageLink = "https://image.tmdb.org/t/p/w500" + imageLink
        guard let url = URL(string: googleImageLink) else { return nil }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return UIImage(data: data)
        } catch {
            return nil
        }
    }
}
