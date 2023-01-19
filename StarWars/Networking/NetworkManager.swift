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

enum Path: String {
    case films = "/films"
    case people = "/people"
}

protocol NetworkManagerProtocol {
    func fetchFilmList() async throws -> FilmListModel
    func fetchCharacterList() async throws -> CharacterListModel
}

final class NetworkManager: NetworkManagerProtocol {

    // MARK: - Properties
    static let shared = NetworkManager()
    private let baseURL = "https://swapi.dev/api/"
    let decoder = JSONDecoder()
    
    // MARK: - Private Init to avoid multiple instances
    private init() { }
    
    // MARK: - Public Interface
    func fetchFilmList() async throws -> FilmListModel {
        guard let url = endpoint(for: .films) else {
            throw NetworkError.invalidUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        do {
            return try decoder.decode(FilmListModel.self, from: data)
        } catch {
            throw NetworkError.invalidData
        }
    }
    
    func fetchCharacterList() async throws -> CharacterListModel {
        guard let url = endpoint(for: .people) else {
            throw NetworkError.invalidUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        do {
            return try decoder.decode(CharacterListModel.self, from: data)
        } catch {
            throw NetworkError.invalidData
        }
    }

    func endpoint(for path: Path) -> URL? {
        return URL(string: baseURL + path.rawValue)
    }
}
