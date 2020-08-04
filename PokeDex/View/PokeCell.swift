//
//  PokeCell.swift
//  PokeDex
//
//  Created by Biswapratik Maharana on 03/08/20.
//  Copyright © 2020 Biswapratik Maharana. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var pokemon: Pokemon!
    
    override func awakeFromNib() {
        self.contentView.layer.cornerRadius = 5
        self.contentView.clipsToBounds = true
    }
    
    func configureCell(pokemon: Pokemon) {
        self.pokemon = pokemon
        nameLbl.text = self.pokemon.name.capitalized
        thumbImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
    }
    
}
