//
//  Pokeman.swift
//  MyPokizz
//
//  Created by Majid on 30/12/2016.
//  Copyright © 2016 Majid. All rights reserved.
//

import Foundation
import Alamofire



class Pokemon {
    
    private var _name :String!
    private var _pokeexId :Int!
    private var _description:String!
    private var _type:String!
    private var _defense:String!
    private var _height:String!
    private var _weight:String
    private var _attack:String!
    private var _nextEvolutionTxt:String!
    private var _pokemonUrl :String!
    
    
    init(name:String, pokedexId:Int) {
        
        self._name = name
        self._pokeexId = pokedexId
        _description = ""
        _type = ""
        _defense = ""
        _height = ""
        _weight = ""
        _attack = ""
        _nextEvolutionTxt = ""
        _pokemonUrl = "\(BASE_URL)\(POKEMON_URL)\(self._pokeexId)"
        
        
    }
    
    var name:String{
        
        return _name
    }
    
    var pokeexId :Int {
        
        return _pokeexId
    }

    func downloadPokemonDetails(completed:DownloadComplete){
       
        
       
        
        Alamofire.request("https").responseJSON{ response in
        
            print(response.request!)
            print(response.response!)
            print(response.data!)
            print(response.result)
            
        
        }
        
        
        
        }
        
    }
    

