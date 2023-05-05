//
//  DataManager.swift
//  Pokemon
//
//  Created by Vyacheslav Lagutov on 29.04.2023.
//

import UIKit

class DataManager {
    
    var offset = 0
    var count = 0
    
    func fetchPokemons(completion: @escaping ([UnitCodable]) -> Void) {
        NetworkManager().fetchPokemons(offset: min(offset, count)) { d in
            self.count = d.count
            completion(d.results)
        }
        self.offset += 20
    }
    
    func fetchNextPokemons(completion: @escaping ([UnitCodable]) -> Void) {
        
    }
}
