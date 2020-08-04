//
//  PokemonDetailVC.swift
//  PokeDex
//
//  Created by Biswapratik Maharana on 04/08/20.
//  Copyright © 2020 Biswapratik Maharana. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenceLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var evoLbl: UILabel!
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLbl.text = pokemon.name.capitalized
        let img = UIImage(named: "\(pokemon.pokedexId)")
        mainImg.image = img
        currentEvoImg.image = img
        pokemon.downloadPokemonDetail {
            self.updateUI()
        }
    }

    @IBAction func backBtnClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func updateUI() {
        heightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        attackLbl.text = pokemon.attack
        defenceLbl.text = pokemon.defense
        pokedexLbl.text = "\(pokemon.pokedexId)"
        typeLbl.text = pokemon.type
        if pokemon.nextEvoId != "" {
            nextEvoImg.image = UIImage(named: "\(pokemon.nextEvoId!)")
            evoLbl.text = "Evolves to: \(pokemon.nextEvoName!.capitalized)"
        } else {
            evoLbl.text = "No Evolution"
            nextEvoImg.image = nil

        }
    }
    
}
