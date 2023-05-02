//
//  PokemonCodable.swift
//  Pokemon
//
//  Created by Vyacheslav Lagutov on 18.04.2023.
//

import UIKit

struct UnitCodable: Codable {
    var name: String
    var url: String
}

struct SpritesOtherCodable: Codable {
    var home: SpritesHomeCodable?
}

struct SpritesHomeCodable: Codable {
    var front_default: String?
    var front_shiny: String?
}

struct SpritesCodable: Codable {
    var back_default: String?
    var front_default: String?
    var other: SpritesOtherCodable?
}

struct TypesItemCodable: Codable {
    var slot: Int
    var type: UnitCodable
}

struct AbilityShortCodable: Codable {
    var ability: UnitCodable
    var is_hidden: Bool
    var slot: Int
}

struct PokemonCodable: Codable {
    var abilities: [AbilityShortCodable]
    var id: Int
    var name: String
    var sprites: SpritesCodable
    var types: [TypesItemCodable]
    var species: UnitCodable
}

struct PokemonSpeciesCodable: Codable {
    var color: UnitCodable
    var egg_groups: [UnitCodable]
    var id: Int
    var is_baby: Bool
    var name: String
    var order: Int
    var generation: UnitCodable
}
