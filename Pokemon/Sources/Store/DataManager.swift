//
//  DataManager.swift
//  Pokemon
//
//  Created by Vyacheslav Lagutov on 29.04.2023.
//

import UIKit

class DataManager {
    func fetchPokemons(completion: @escaping ([UnitCodable]) -> Void) {
        NetworkManager().fetchPokemons() { d in
            completion(d)
        }
    }
}
