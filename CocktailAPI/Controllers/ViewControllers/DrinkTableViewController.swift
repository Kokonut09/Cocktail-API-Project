//
//  DrinkTableViewController.swift
//  CocktailAPI
//
//  Created by Andrew Saeyang on 8/4/21.
//

import UIKit

class DrinkTableViewController: UITableViewController {

    // MARK: - PROPERTIES
    var drinks: [Drink] = []
    
    // MARK: - LIFECYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDrinks()
        
    }

    func fetchDrinks() {
        DrinkController.fetchDrinks { result in
            
            DispatchQueue.main.async {
                
                switch result{
                
                case .success(let drinks):
                    self.drinks = drinks
                    self.tableView.reloadData()
                    
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "drinkCell", for: indexPath)

        let margarita = drinks[indexPath.row]
        cell.textLabel?.text = margarita.strDrink
        
        return cell
    }
   
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Identifier - not needed for one segue but goo practice
        if segue.identifier == "toDrinkDetailVC"{
            
            // Index Path
            // Destination
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? DrinkDetailViewController else { return }
            
            // Object to send
            let drinkToSend = drinks[indexPath.row]
            
            // Object to Recieve
            destination.drink = drinkToSend
        }
    }
}
