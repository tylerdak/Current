//
//  DataRetrieval.swift
//  Current
//
//  Created by Tyler Dakin on 10/24/20.
//

import Foundation
import SwiftUI

extension SearchWindow {
    func dataGrab(platform: Platform, query: String) {
        //Prepare query for url
        let urlQuery = query.replacingOccurrences(of: " ", with: "%20")
        let tmdbRequest: String = "https://api.themoviedb.org/3/search/movie?api_key=\(tmdbKey)&query=\(urlQuery)&include_adult=false"
        let tvdbRequest: String = "https://api.themoviedb.org/3/search/tv?api_key=\(tmdbKey)&query=\(urlQuery)&include_adult=false"
        let bookRequest: String = ""
        let igdbRequest: String = ""
        
        //Change method based on platform
        // TODO: Refactor to use one URLSession case that is variable to each API
        switch platform {
        case movieType:
            print("MOVIE")
            guard let url = URL(string: tmdbRequest) else {
                print("URL BAD")
                return
            }
            print(url)
            let request = URLRequest(url: url)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    if let decodedResponse = try? JSONDecoder().decode(TMDBMovieResponse.self, from: data) {
                        print("What?")
                        DispatchQueue.main.async {
                            let tempResults: [TMDBMovie] = Array<TMDBMovie>(decodedResponse.results.prefix(upTo: min(decodedResponse.results.count, 50)))
                            var finalResults: [MediaType] = []
                            for result in tempResults {
                                let new = MediaType(title: result.title, imgLoc: "https://image.tmdb.org/t/p/original" + (result.poster_path ?? ""), description: result.overview ?? "", id: String(result.id))
                                
                                finalResults.append(new)
                            }
                            searchResults = finalResults
                            
                        }
                        return
                    }
                    print("Failed to decode response")
                }
                print("Error: \(error?.localizedDescription ?? "Unknown Error")")
            }.resume()
        default:
            print("DEFAULT")
        }
        
    }

    struct TMDBMovieResponse: Codable {
        var results: [TMDBMovie]
    }

    struct TMDBMovie: Codable {
        let title: String
        let overview: String?
        let id: Int
//        let release_date: String
        let poster_path: String?
    }
}
