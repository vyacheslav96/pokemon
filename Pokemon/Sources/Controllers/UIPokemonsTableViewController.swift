//
//  UIPokemonsTableViewController.swift
//  Pokemon
//
//  Created by Vyacheslav Lagutov on 18.04.2023.
//

import UIKit

class UIPokemonsTableViewController: UITableViewController {
    
    var data: [UnitCodable] = []
    var pokemons: [Int:PokemonCodable] = [:]
    
    let dataManager = DataManager()
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        tableView.register(UINib(nibName: "UIPokemonTableViewCell", bundle: nil), forCellReuseIdentifier: "PokemonItem")
        
        dataManager.fetchPokemons { [unowned self] d in
            self.data = d
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonItem", for: indexPath) as! UIPokemonTableViewCell

        NetworkManager().fetchPokemon(name: data[indexPath.row].name) { [unowned self] pokemon in
            
            if self.pokemons.count <= indexPath.row {
                self.pokemons[indexPath.row] = pokemon
            }
            
            guard let sprite = pokemon.sprites.front_default else { return }
            
            let url = URL(string: sprite)
            
            DispatchQueue.main.async {
                cell.icon.loadImageWithUrl(url!)
            }
        }
        
        cell.name.text = data[indexPath.row].name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 81
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedPokemon = pokemons[indexPath.row]

        guard let nc = navigationController else { return }
        let cardVC = UICardViewController(nibName: "UICardViewController", bundle: nil)
        cardVC.pokemon = selectedPokemon
        nc.pushViewController(cardVC, animated: true)
    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}
