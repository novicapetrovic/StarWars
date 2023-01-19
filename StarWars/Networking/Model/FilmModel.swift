//
//  StarWarsFilmModel.swift
//  StarWars
//
//  Created by Nov Petrović on 16/01/2023.
//

import Foundation

struct FilmModel: Decodable {
    let title: String
    let characters: [String]
}
