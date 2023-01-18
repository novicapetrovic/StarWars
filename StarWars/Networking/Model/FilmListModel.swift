//
//  StarWarsAPIModel.swift
//  StarWars
//
//  Created by Nov Petrović on 16/01/2023.
//

import Foundation

struct FilmListModel: Decodable {
    let results: [FilmModel]
}
