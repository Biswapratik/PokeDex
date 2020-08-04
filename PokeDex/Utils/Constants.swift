//
//  Constants.swift
//  PokeDex
//
//  Created by Biswapratik Maharana on 04/08/20.
//  Copyright © 2020 Biswapratik Maharana. All rights reserved.
//

import Foundation

let VERSION = "v2"
let URL_BASE = "https://pokeapi.co/api/\(VERSION)/pokemon/"
let EVO_URL = "https://pokeapi.co/api/\(VERSION)/evolution-chain/"

typealias DownloadComplete = () -> ()
