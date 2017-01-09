//
//  ViewController.swift
//  MyPokizz
//
//  Created by Majid on 30/12/2016.
//  Copyright © 2016 Majid. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UISearchBarDelegate {
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar :UISearchBar!
    
    var pokemons = [Pokemon]()
    var filteredPokemons = [Pokemon]()
    
   
    var inSearchMode = false

    override func viewDidLoad() {
        super.viewDidLoad()
       
         collection.delegate = self
         collection.dataSource = self
         searchBar.delegate = self
         searchBar.returnKeyType = UIReturnKeyType.done
        
         parseCSVFile()
    
    }
    
    func parseCSVFile(){
        
         let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        
        do{
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows {
                
                let pokeId =  Int(row["id"]!)!
                let pokeName = row["identifier"]!
                
                let poke = Pokemon(name: pokeName, pokedexId: pokeId)
                pokemons.append(poke)
            }
            
       }
        catch let err as NSError{
            
            print(err.debugDescription)
        }
        
        
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode{
            return filteredPokemons.count
        }
        
        return pokemons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeezCell", for: indexPath) as? PokeezCell{
            
            let pokez :Pokemon!
            
            if inSearchMode{
                pokez = filteredPokemons[indexPath.row]
                
            }else{
                pokez = pokemons[indexPath.row]
            }
                cell.configureCell(pokemon: pokez)
                return cell
        }
        else{
            
            return UICollectionViewCell()
        }
        
        
    }
    //On selecting a Cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let poke:Pokemon!
        
        if inSearchMode{
            poke = filteredPokemons[indexPath.row]
        }else{
           poke = pokemons[indexPath.row]
    }
           performSegue(withIdentifier: "PokemonsDetail", sender: poke)
}
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 83, height: 100)
    }
  
 
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    //SearchBar code for searching pokemons
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
        if searchBar.text == nil || searchBar.text == ""{
            
            inSearchMode = false
            view.endEditing(true)
            collection.reloadData()
        }
        else{
            
            inSearchMode = true
            let searchText = searchBar.text!.lowercased()
            filteredPokemons = pokemons.filter({$0.name.range(of: searchText) != nil})
            collection.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonsDetail"{
            if let controller = segue.destination as? PokemonsDetailsVC{
                if let poke = sender as? Pokemon{
                    controller.pokemons = poke
                }
                
            }
    }
    
 

}

}
