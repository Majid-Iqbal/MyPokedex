//
//  PokeezCell.swift
//  MyPokizz
//
//  Created by Majid on 03/01/2017.
//  Copyright © 2017 Majid. All rights reserved.
//

import UIKit

class PokeezCell: UICollectionViewCell {
    
    @IBOutlet weak var pokeImg:UIImageView!
    @IBOutlet weak var nameLbl:UILabel!
    
    var pokemon : Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0

    }
    
    func configureCell(pokemon:Pokemon){
        self.pokemon = pokemon
        
       pokeImg.image = UIImage(named: "\(self.pokemon.pokeexId)")
       nameLbl.text = self.pokemon.name.capitalized
    }
    
    
}
