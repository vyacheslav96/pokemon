//
//  PokemonApi.swift
//  Pokemon
//
//  Created by Vyacheslav Lagutov on 18.04.2023.
//

import UIKit

let pokemonCache = NSCache<AnyObject, AnyObject>()

class NetworkManager {
    
    func fetchPokemons(offset: Int, completion: @escaping (PokemonListCodable) -> Void) {
        let urlString = "https://pokeapi.co/api/v2/pokemon/?offset=\(offset)&limit=20"
        
        if let itemFromCache = pokemonCache.object(forKey: urlString as AnyObject) as? PokemonListCodable {
            completion(itemFromCache)
            return
        }
        
        let url = URL(string: urlString)
        
        runFetch(url: url!) { data in
            if let data = data,
               let item = try? JSONDecoder().decode(PokemonListCodable.self, from: data) {
                pokemonCache.setObject(item as AnyObject, forKey: urlString as AnyObject)
                completion(item)
            }
        }
    }
    
    func fetchPokemon(name: String, completion: @escaping (PokemonCodable) -> Void) {
        let urlString = "https://pokeapi.co/api/v2/pokemon/\(name)/"
        
        if let itemFromCache = pokemonCache.object(forKey: urlString as AnyObject) as? PokemonCodable {
            completion(itemFromCache)
            return
        }
        
        let url = URL(string: urlString)
        
        runFetch(url: url!) { data in
            if let data = data,
               let item = try? JSONDecoder().decode(PokemonCodable.self, from: data) {
                pokemonCache.setObject(item as AnyObject, forKey: urlString as AnyObject)
                completion(item)
            }
        }
    }
    
    func fetchSpecies(name: Int, completion: @escaping (PokemonSpeciesCodable) -> Void) {
        let urlString = "https://pokeapi.co/api/v2/pokemon-species/\(name)/"
        
        if let itemFromCache = pokemonCache.object(forKey: urlString as AnyObject) as? PokemonSpeciesCodable {
            completion(itemFromCache)
            return
        }
        
        let url = URL(string: urlString)
        
        runFetch(url: url!) { data in
            if let data = data,
               let item = try? JSONDecoder().decode(PokemonSpeciesCodable.self, from: data) {
                pokemonCache.setObject(item as AnyObject, forKey: urlString as AnyObject)
                completion(item)
            }
        }
    }
    
    private func runFetch(url: URL, completion: @escaping (Data?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                debugPrint("Error with fetching films: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                debugPrint("Error with the response, unexpected status code.")
                return
            }
            completion(data)
        }
        task.resume()
    }
}

enum FetchSeek {
    case next
    case previous
}
