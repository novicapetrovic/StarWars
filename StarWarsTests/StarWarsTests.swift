//
//  StarWarsTests.swift
//  StarWarsTests
//
//  Created by Nov Petrović on 16/01/2023.
//

import XCTest
@testable import StarWars

final class StarWarsTests: XCTestCase {
    
    var listViewController: ListViewController!
    var detailViewController: DetailViewController!

    override func setUp() {
        super.setUp()
        listViewController = ListViewController(networkManager: MockNetworkManager())
        detailViewController = DetailViewController(characters: [])
    }
    
    func testListViewController() {
        listViewController.loadViewIfNeeded()
        XCTAssertEqual(listViewController.title, "Star Wars Films")
    }
    
    func testCharacterListMapping() {
        let characterList = makeCharacterList()
        listViewController.createCharacterDictionary(for: characterList)
        XCTAssertEqual(listViewController.characterDict[characterList[0].url], characterList[0].name)
        XCTAssertEqual(listViewController.characterDict[characterList[1].url], characterList[1].name)
        XCTAssertEqual(listViewController.characterDict[characterList[2].url], characterList[2].name)
        XCTAssertEqual(listViewController.characterDict[characterList[3].url], characterList[3].name)
    }
    
    func testDetailViewController() {
        detailViewController.loadViewIfNeeded()
        XCTAssertEqual(detailViewController.title, "Characters")
    }
}

// MARK: - Helper methods
extension StarWarsTests {
    private func makeCharacterList() -> [CharacterModel] {
        let characterList = [
            CharacterModel(name: "Luke Skywalker", url: "https://swapi.dev/api/people/?page=1"),
            CharacterModel(name: "C-3PO", url: "https://swapi.dev/api/people/?page=2"),
            CharacterModel(name: "R2-D2", url: "https://swapi.dev/api/people/?page=3"),
            CharacterModel(name: "Darth Vader", url: "https://swapi.dev/api/people/?page=4")
        ]
        
        return characterList
    }
}
