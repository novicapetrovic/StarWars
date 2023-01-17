//
//  StarWarsFilmModel.swift
//  StarWars
//
//  Created by Nov Petrović on 16/01/2023.
//

import Foundation

struct FilmModel: Codable, Hashable {
    let title: String
    let characters: [String]
}

// MARK: - Conforming to Hashable
extension FilmModel {

    static func == (lhs: FilmModel, rhs: FilmModel) -> Bool {
        if lhs.title == rhs.title && lhs.characters == rhs.characters {
            return true
        } else {
            return false
        }
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}
