//
//  ApıCaller.swift
//  MovieApp
//
//  Created by Tolgahan Sonmez on 28.02.2023.
//

import Foundation


var movieTitles : [String] = [""]

class APICaller {
    
    static let shared = APICaller()
    
    
    enum APIError : Error {
        case failedToGetData
    }
    
    
    enum HTTPMethod : String {
        case GET
        case PUT
        case POST
        case DELETE
        
    }
    
   
    
    public func createRequest(
        with url : URL?,
        type: HTTPMethod,
        completion: @escaping (URLRequest)->Void )
    {
        guard let apiUrl = url else { return
        }
        var request = URLRequest(url: apiUrl)
        
        request.httpMethod = type.rawValue
        request.timeoutInterval = 30
        completion(request)
    }
    
    public func getTopMovies(with paging : Int = 1, completion: @escaping (Result<TopMovies,Error>)-> Void) {
        
        createRequest(with: URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=4fa8315b88b4af05b9a178d34b18ae38&language=en-US&page=\(paging+1)&include_adult=true"), type: .GET)
        { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(TopMovies.self, from: data)
                    completion(.success(result))
                }
                catch {
                    completion(.failure(error))
                    print(error)
                }
            }
            task.resume()
        }
    }
    
}
