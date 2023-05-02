//
//  ResponseCodable.swift
//  Pokemon
//
//  Created by Vyacheslav Lagutov on 19.04.2023.
//

import UIKit

struct PokemonListCodable: Codable {
    var count: Int
    var next: String?
    var previous: String?
    var results: [UnitCodable]
}
