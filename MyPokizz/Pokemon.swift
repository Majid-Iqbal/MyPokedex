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
    private var _pokeexId :Int
    private var _description:String!
    private var _type:String!
    private var _defense:String!
    private var _height:String!
    private var _weight:String!
    private var _attack:String!
    private var _nextEvolutionTxt:String!
    private var _nextEvolutionId:String!
    private var _nextEvolutionLvl:String!
    private var _pokemonUrl :String!
    
    
    init(name:String, pokedexId:Int) {
        
        self._name = name
        self._pokeexId = pokedexId
     
        _pokemonUrl = "\(BASE_URL)\(POKEMON_URL)\(self._pokeexId)/"
        
        
    }
    
    var name:String{
        return _name
    }
    
    var pokeexId :Int {
       return _pokeexId
    }
    
    var description:String{
        
        if _description == nil{
            _description = ""
        }
        return _description
    }
    
    var type:String{
        if _type == nil{
            _type = ""
        }
        return _type
    }
    
    var defense:String{
        if _defense == nil{
            _defense = ""
        }
        return _defense
    }
    
    var height:String{
        if _height == nil{
            _height = ""
        }
        return _height
    }
    
    var weight:String{
        if _weight == nil{
            _weight = ""
        }
        return _weight
    }
    
    var attack:String{
        if _attack == nil{
            _attack = ""
        }
        return _attack
    }
    
    var nextEvolutionId:String{
        if _nextEvolutionId == nil{
            _nextEvolutionId = ""
        }
        return _nextEvolutionId
    }
    
    var nextEvolutionTxt:String{
        if _nextEvolutionTxt == nil{
            _nextEvolutionTxt = ""
        }
        return _nextEvolutionTxt
    }

    var nextEvolutionLvl:String{
        if _nextEvolutionLvl == nil {
            _nextEvolutionLvl = ""
        }
        return _nextEvolutionLvl
    }

    func downloadPokemonDetails(completed:@escaping DownloadComplete){
        
        let urlString = URL(string:_pokemonUrl)
        
       Alamofire.request(urlString!).responseJSON { response in
        
        if let dict = response.result.value as? Dictionary<String ,AnyObject> {
            
            if let height = dict["height"] as? String{
                self._height = height
            }
            if let weight = dict["weight"] as? String {
                self._weight = weight
            }
            if let attack = dict["attack"] as? Int{
                self._attack = "\(attack)"
            }
            if let defense = dict["defense"] as? Int{
                self._defense = "\(defense)"
            }
         
            print(self._height)
            print(self._weight)
            print(self._attack)
            print(self._defense)
            
            if let types = dict["types"] as? [Dictionary<String, String>], types.count > 0{
                
                if let name = types[0]["name"]{
                    self._type  = name.capitalized
                }
                
                if  types.count > 1 {
                    
                    for x in 1..<types.count {
                        if let name = types[x]["name"]{
                            self._type! += "/\(name.capitalized)"
                        }
                    }
                }
                
            }else{
                
                self._type = ""
            }
              print(self._type)
            
        if let descArray = dict["descriptions"] as? [Dictionary<String , String>] , descArray.count > 0{
                
                if let descUrl = descArray[0]["resource_uri"]{
                    let urlString = URL(string:"\(BASE_URL)\(descUrl)")
                    
                    Alamofire.request(urlString!).responseJSON{ response in
                        
                        if let descDict = response.result.value as? Dictionary<String ,AnyObject> {
                            if let description = descDict["description"] as? String {
                                
                                self._description = description
                                print(self._description)
                            }
                        }
                        completed()
                    }
                }
                
            }else{
                self._description = ""
            }
            
        if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>], evolutions.count > 0 {
            
            if let to = evolutions[0]["to"] as? String{
                
                if to.range(of: "mega") == nil { //Mega pokemon not supported here yet
                    
                    if let uri = evolutions[0]["resource_uri"] as? String {
                        
                        let newString = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                        let num = newString.replacingOccurrences(of: "/", with: "")
                        
                        self._nextEvolutionId = num
                        self._nextEvolutionTxt = to
                        
                        if let level = evolutions[0]["level"] as? Int{
                            self._nextEvolutionLvl = "\(level)"
                        }
                        print(self._nextEvolutionId)
                        print(self._nextEvolutionTxt)
                        print(self._nextEvolutionLvl)
                        
                    }
                    
                }
                
            }
        }
    }
        
    }
        
   }
    
        
    
        
}
    

