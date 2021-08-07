//
//  DrinkDetailViewController.swift
//  CocktailAPI
//
//  Created by Andrew Saeyang on 8/4/21.
//

import UIKit

class DrinkDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var drink: Drink?
    var ingredientList: [String?] = []
    var measurementList:[String?] = []
    
    // MARK: - OUTLETS

    @IBOutlet weak var ingredientTable: UITableView!
    @IBOutlet weak var drinkNameLabel: UILabel!
    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var drinkImageView: UIImageView!
    
    // MARK: - LIFECYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        
        
        ingredientTable.delegate = self
        ingredientTable.dataSource = self
        
    }
    
    // MARK: - TABLE VIEW DATA SOURCE
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

            return drinkIngredientCount(of: ingredientList)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
            
        let ingredient = "\(measurementList[indexPath.row] ?? "") \(ingredientList[indexPath.row] ?? "")"
        
        cell.textLabel?.text = ingredient
       
        
        return cell
    }
    
    
    // MARK: - HELPER METHODS
    func updateViews(){
        guard let drink = drink else { return }
        
        drinkNameLabel.text = drink.strDrink
        fillArrays(with: drink)
        instructionsLabel.text = drink.strInstructions
        
        DrinkController.fetchImage(with: drink.strDrinkThumb) { result in
            DispatchQueue.main.async {
                self.drinkImageView.layer.cornerRadius = 10
                
                switch result{
                case .success(let img):
                    self.drinkImageView.image = img
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }
    
    func fillArrays(with drink: Drink?){
        guard let drink = drink else { return }
    
        measurementList = [drink.strMeasure1,
                           drink.strMeasure2,
                           drink.strMeasure3,
                           drink.strMeasure4,
                           drink.strMeasure5,
                           drink.strMeasure6,
                           drink.strMeasure7,
                           drink.strMeasure8,
                           drink.strMeasure9,
                           drink.strMeasure10,
                           drink.strMeasure11,
                           drink.strMeasure12,
                           drink.strMeasure13,
                           drink.strMeasure14,
                           drink.strMeasure15]
        
        ingredientList = [  drink.strIngredient1,
                            drink.strIngredient2,
                            drink.strIngredient3,
                            drink.strIngredient4,
                            drink.strIngredient5,
                            drink.strIngredient6,
                            drink.strIngredient7,
                            drink.strIngredient8,
                            drink.strIngredient9,
                            drink.strIngredient10,
                            drink.strIngredient11,
                            drink.strIngredient12,
                            drink.strIngredient13,
                            drink.strIngredient14,
                            drink.strIngredient15
        ]
        
    }
    
    // Returns the number of non nil elements
    func drinkIngredientCount(of ingredients:[String?]) -> Int{
        var retVal = 0
        
        for i in ingredients{
            if i != nil{
                retVal += 1
            }else{
                break
            }
        }
        return retVal
        
    }
}
