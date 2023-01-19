//
//  MockNetwork.swift
//  StarWarsTests
//
//  Created by Nov Petrović on 19/01/2023.
//

import Foundation
@testable import StarWars

class MockNetworkManager: NetworkManagerProtocol {
    
    func fetchFilmList() async throws -> StarWars.FilmListModel {
        return FilmListModel(results: [.init(
            title: "A New Hope",
            characters: ["https://swapi.dev/api/people/1/",
                         "https://swapi.dev/api/people/2/",
                         "https://swapi.dev/api/people/3/",
                         "https://swapi.dev/api/people/4/"
                        ])])
    }
    
    func fetchCharacterList() async throws -> StarWars.CharacterListModel {
            return CharacterListModel(results: [CharacterModel(name: "Luke Skywalker", url: "https://swapi.dev/api/people/?page=1"),
                                                CharacterModel(name: "C-3PO", url: "https://swapi.dev/api/people/?page=2"),
                                                CharacterModel(name: "R2-D2", url: "https://swapi.dev/api/people/?page=3"),
                                                CharacterModel(name: "Darth Vader", url: "https://swapi.dev/api/people/?page=4")])
    }
}
