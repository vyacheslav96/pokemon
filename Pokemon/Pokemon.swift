import Foundation

struct PokemonListResults: Codable {
    let next: String
    let results: [PokemonListResult]
}

struct PokemonListResult: Codable {
    let name: String
    let url: String
}

struct PokemonResult: Codable {
    let id: Int
    let name: String
    let types: [PokemonTypeEntry]
    let sprites: SpritesEntity
    let species: [String:String]
}

struct SpritesEntity: Codable {
    let front_default: String?
}

struct PokemonTypeEntry: Codable {
    let slot: Int
    let type: PokemonType
}

struct PokemonType: Codable {
    let name: String
}

struct PokemonSpecies: Codable {
    let flavor_text_entries: [FlavorTextRecord]
}

struct FlavorTextRecord: Codable {
    let flavor_text: String
    let language: [String:String]
}
