//
//  NetworkManager.swift
//  StarWars
//
//  Created by Nov Petrović on 16/01/2023.
//

import UIKit

enum APIError: Error {
    case responseProblem
    case decodingProblem
}

final class NetworkManager {
    
    // MARK: - Properties
    static let shared = NetworkManager()
    let cache = NSCache<NSString, UIImage>()
    
    private let baseURL = "https://swapi.dev/api/"
    
    // MARK: - Private Init to avoid multiple instances
    private init() { }
    
    // MARK: - Public Interface
    func fetchFilmList(completion: @escaping(Result<FilmListModel, APIError>) -> Void) {
        
        guard let url = URL(string: baseURL + "/films") else {
            return
        }
        
        do {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response , _ in
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(.responseProblem))
                    return
                }
                
                guard httpResponse.statusCode == 200, let jsonData = data else {
                    return
                }
                
                do {
                    let decodedData = try JSONDecoder().decode(FilmListModel.self, from: jsonData)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(.decodingProblem))
                }
            }
            dataTask.resume()
        }
    }
    
    func fetchCharacterList(completion: @escaping(Result<CharacterListModel, APIError>) -> Void) {
        
        guard let resourceURL = URL(string: baseURL + "/people/") else {
            return
        }
        
        do {
            var urlRequest = URLRequest(url: resourceURL)
            urlRequest.httpMethod = "GET"

            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response , _ in
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(.responseProblem))
                    return
                }
                
                guard httpResponse.statusCode == 200, let jsonData = data else {
                    return
                }
                
                do {
                    let decodedData = try JSONDecoder().decode(CharacterListModel.self, from: jsonData)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(.decodingProblem))
                }
            }
            dataTask.resume()
        }
    }
}
