//
//  NetworkLayer.swift
//  Netflix_Clone_ex
//
//  Created by Designer on 2023/07/20.
//

import Foundation
import UIKit

// "http://itunes.apple.com/search?media=movie&term=movie"

// media
// movie, podcast, music, musicVideo, audiobook, shortFilm, tvShow, software, ebook, all

enum MyError: Error {
    case badURL
    case badNetwork
    case badConnection
    case badResponseData
    case badImage
}

class NetworkLayer {
    static func request(urlString: String, completion: @escaping (UIImage?)  -> Void) {
        guard let url = URL(string: urlString) else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let hasData = data else {
                return
            }
            let image = UIImage(data: hasData)
            completion(image)
            
        }.resume()
        
    }
    
    // async await style
    static func requestAsyncAwait(urlString: String) async -> Result<UIImage?, MyError> {
        
        guard let url = URL(string: urlString) else {
            return .failure(.badURL)
        }
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else {
                return .failure(.badImage)
            }
            return .success(image)
        }catch{
            print(error)
            return .failure(.badNetwork)
        }
        
    }
    
    static func request(type: MediaType, completion: @escaping (MovieModel) -> Void) {
        let term = URLQueryItem(name: "term", value: type.queryValue)
        let media = URLQueryItem(name: "media", value: type.queryValue)
        
        let querys = [term, media]
        
        var  components = URLComponents(string: "http://itunes.apple.com/search")
        
        components?.queryItems = querys
        guard let hasUrl = components?.url else {
            return
        }
        
        URLSession.shared.dataTask(with: hasUrl) { data, response, error in
            if let hasData = data {
                do {
                    let movieModel = try JSONDecoder().decode(MovieModel.self, from: hasData)
//                    print(movieModel)
                    completion(movieModel)
                }catch{
                    print("decode error", error)
                }

            }
        }.resume()
    }
    
}
