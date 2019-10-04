//
//  MovieController.swift
//  Movie
//
//  Created by Zebadiah Watson on 10/4/19.
//  Copyright © 2019 Zebadiah Watson. All rights reserved.
//

import UIKit

struct StringConstants {
    fileprivate static let baseURL = "https://api.themoviedb.org/3/"
    fileprivate static let search = "search"
    fileprivate static let apiKeyKey = "api_key"
    fileprivate static let apiKeyValue = "df805281976a69f805e3cedd8c74c655"
    fileprivate static let movie = "movie"
    fileprivate static let queryItem = "query"
}

class MovieController {
    
    static func fetchMovie(searchText: String, completion: @escaping ([Results]) -> Void) {
        
        guard var baseURL = URL(string: StringConstants.baseURL) else {completion([]); return }
        baseURL.appendPathComponent(StringConstants.search)
        baseURL.appendPathComponent(StringConstants.movie)
        guard var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else { completion([]); return }
        //let searchComponent = URLComponents(string: StringConstants.search)
        //let movieComponent = URLComponents(string: StringConstants.movie)
        let apiQuery = URLQueryItem(name: StringConstants.apiKeyKey, value: StringConstants.apiKeyValue)
        let searchQuery = URLQueryItem(name: StringConstants.queryItem, value: searchText)
        
        components.queryItems = [apiQuery, searchQuery]
        
        guard let finalURL = components.url else { return }
        print(finalURL)
        
        let dataTask = URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("error retrieving the data \(error.localizedDescription)")
                completion([])
                return
            }
            guard let data = data else {
                print("no data received")
                completion([])
                return
            }
            let jsonDecoder = JSONDecoder()
            do {
                let movie = try jsonDecoder.decode(TopLevelDictionary.self, from: data)
                completion(movie.results)
            } catch {
                print("there was an error decoding the data \(error.localizedDescription)")
                completion([])
            }
        }
        dataTask.resume()
    }
    
    static func getPoster(item: Results, completion: @escaping (UIImage?) -> Void) {
        guard let posterURL = item.poster,
            let url = URL(string: posterURL) else {
                print("item did not have a poster")
                completion(nil)
                return
        }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("error getting image data\(error.localizedDescription)")
                completion(nil)
                return
            }
            guard let data = data else {
                print("could not image retrieve data")
                completion(nil)
                return
            }
            let image = UIImage(data: data)
            completion(image)
            } .resume()
    }
} // End of Class
