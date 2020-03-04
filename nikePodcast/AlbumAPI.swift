//
//  AlbumAPI.swift
//  nikePodcast
//
//  Created by Jake Flaten on 3/3/20.
//  Copyright © 2020 Jake Flaten. All rights reserved.
//

import Foundation
enum APIError : Error {
    case networkingError(Error)
    case serverError // HTTP 5xx
    case requestError(Int, String) // HTTP 4xx
    case invalidResponse
    case badURL
    case decodingError(DecodingError)
}

class AlbumAPI {
    
    let session: URLSession
    
    init(_ session: URLSession = .shared) {
        self.session = session
    }
        
    func fetchAlbums(completion: @escaping (Result<Response, APIError>) -> Void) {
        guard let url = URL(string: "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/100/explicit.json") else {
            completion(.failure(.badURL))
            return
        }
        let request = URLRequest(url: url)
        perform(request: request, completion: parseDecodable(completion: completion))
    }
    
    private func parseDecodable<T : Decodable>(completion: @escaping (Result<T, APIError>) -> Void) -> (Result<Data, APIError>) -> Void {
           return { result in
               switch result {
               case .success(let data):

                   do {
                       let jsonDecoder = JSONDecoder()
                       let object = try jsonDecoder.decode(T.self, from: data)
                       DispatchQueue.main.async {
                           completion(.success(object))
                       }
                   } catch let decodingError as DecodingError {
                       DispatchQueue.main.async {
                           completion(.failure(.decodingError(decodingError)))
                       }
                   }
                   catch {
                       fatalError("Unhandled error raised.")
                   }

               case .failure(let error):
                   DispatchQueue.main.async {
                       completion(.failure(error))
                   }
               }
           }
    }

   private func perform(request: URLRequest, completion: @escaping (Result<Data, APIError>) -> Void) {
       let task = session.dataTask(with: request) { data, response, error in
           if let error = error {
               completion(.failure(.networkingError(error)))
               return
           }
           guard let http = response as? HTTPURLResponse, let data = data else {
               completion(.failure(.invalidResponse))
               return
           }
           switch http.statusCode {
           case 200:
               completion(.success(data))
           case 400...499:
               let body = String(data: data, encoding: .utf8)
               completion(.failure(.requestError(http.statusCode, body ?? "<no body>")))
           case 500...599:
               completion(.failure(.serverError))
           default:
               fatalError("Unhandled HTTP status code: \(http.statusCode)")
           }
       }
       task.resume()
    }
}
