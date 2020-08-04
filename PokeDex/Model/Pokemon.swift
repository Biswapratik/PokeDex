//
//  Pokemon.swift
//  PokeDex
//
//  Created by Biswapratik Maharana on 03/08/20.
//  Copyright © 2020 Biswapratik Maharana. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvoText: String!
    private var _nextEvoName: String!
    private var _nextEvoId: String!
    private var _nextEvoLevel: String!
    private var _pokemanURL: String!
    private var _evoURL: String!
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    var description: String! {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    var nextEvoName: String! {
        if _nextEvoName == nil {
            _nextEvoName = ""
        }
        return _nextEvoName
    }
    
    var nextEvoId: String! {
        if _nextEvoId == nil {
            _nextEvoId = ""
        }
        return _nextEvoId
    }
    
    var nextEvoLevel: String! {
        if _nextEvoLevel == nil {
            _nextEvoLevel = ""
        }
        return _nextEvoLevel
    }
    
    var type: String! {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var defense: String! {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var weight: String! {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var height: String! {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var attack: String! {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    var nextEovText: String! {
        if _nextEvoText == nil {
            _nextEvoText = ""
        }
        return _nextEvoText
    }
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
        self._pokemanURL = "\(URL_BASE)\(self.pokedexId)"
        self._evoURL = "\(EVO_URL)\(self.pokedexId)"
    }
    
    func downloadPokemonDetail(completed: @escaping DownloadComplete) {
        AF.request(_pokemanURL!, method: .get, encoding: JSONEncoding.default)
            .responseJSON { response in
                let result = response.value
                if let dict = result as? [String: Any] {
                    if let weight = dict["weight"] as? Int {
                        self._weight = String(weight)
                    }
                    if let height = dict["height"] as? Int {
                        self._height = String(height)
                    }
                    if let stats = dict["stats"] as? [[String: Any]] {
                        for stat in stats {
                            if let statDict = stat["stat"] as? [String: Any] {
                                if let nameOfStat = statDict["name"] as? String {
                                    if nameOfStat.lowercased() == "attack" {
                                        if let attack = stat["base_stat"] as? Int {
                                            self._attack = String(attack)
                                        }
                                    } else if nameOfStat.lowercased() == "defense" {
                                        if let defense = stat["base_stat"] as? Int {
                                            self._defense = String(defense)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    if let types = dict["types"] as? [[String: Any]], types.count > 0 {
                        if let typeDict = types[0]["type"] as? [String: Any] {
                            if let type = typeDict["name"] as? String {
                                self._type = type.capitalized
                            }
                        }
                        if types.count > 1 {
                            for i in 1..<types.count {
                                if let typeDict = types[i]["type"] as? [String: Any] {
                                    if let type = typeDict["name"] as? String {
                                        self._type += ", \(type)"
                                    }
                                }
                            }
                        }
                    } else {
                        self._type = ""
                    }
                }
                completed()
        }
        AF.request(_evoURL!, method: .get, encoding: JSONEncoding.default)
            .responseJSON { response in
                let result = response.value
                if let dict = result as? [String: Any] {
                    if let chain = dict["chain"] as? [String: Any] {
                        if let evolves_to = chain["evolves_to"] as? [[String: Any]], evolves_to.count > 0 {
                            if let species = evolves_to[0]["species"] as? [String: Any] {
                                if let name = species["name"] as? String {
                                    self._nextEvoName = name
                                }
                                if let url = species["url"] as? String {
                                    self._nextEvoId = url.replacingOccurrences(of: "https://pokeapi.co/api/v2/pokemon-species/", with: "").replacingOccurrences(of: "/", with: "")
                                }
                            }
                        }
                    }
                }
                completed()
        }
    }
    
}

