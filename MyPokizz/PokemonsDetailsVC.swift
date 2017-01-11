//
//  PokemonsDetailsVC.swift
//  MyPokizz
//
//  Created by Majid on 07/01/2017.
//  Copyright © 2017 Majid. All rights reserved.
//

import UIKit

class PokemonsDetailsVC: UIViewController {

    
    @IBOutlet weak var pokeLbl:UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokeexLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var evoLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    
    var pokemons:Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokeLbl.text = pokemons.name
        let img = UIImage(named: "\(pokemons.pokeexId)")
        mainImg.image = img
        currentEvoImg.image = img
       
        pokemons.downloadPokemonDetails {
            
            print("Did we Got here")
            
            self.updatePokeUI()
            
        }
       
    }
    
    func updatePokeUI(){
        
        descriptionLbl.text = pokemons.description
        typeLbl.text = pokemons.type
        defenseLbl.text = pokemons.defense
        heightLbl.text = pokemons.height
        pokeexLbl.text = "\(pokemons.pokeexId)"
        weightLbl.text = pokemons.weight
        attackLbl.text = pokemons.attack
        
        
        if pokemons.nextEvolutionId == ""{
            evoLbl.text = "No Evolutions"
            nextEvoImg.isHidden = true
        }else{
            nextEvoImg.isHidden = false
            nextEvoImg.image = UIImage(named: pokemons.nextEvolutionId)
            var str = "Next Evolution: \(pokemons.nextEvolutionTxt)"
            evoLbl.text = str
            
            if pokemons.nextEvolutionLvl != ""{
               str += " - LVL \(pokemons.nextEvolutionLvl)"
                evoLbl.text = str
            }
        }
        
    }
    
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }



}
