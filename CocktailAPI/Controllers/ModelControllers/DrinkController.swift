//
//  DrinkController.swift
//  CocktailAPI
//
//  Created by Andrew Saeyang on 8/4/21.
//

import Foundation
import UIKit.UIImage

class DrinkController{
    
    static func fetchDrinks(completion: @escaping (Result<[Drink], DrinkError >) -> Void){
         
        let baseURL = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=margarita")
        guard let finalURL = baseURL else { return completion(.failure(.invalidURL))}
        
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            if let error = error{
                return completion(.failure(.thrownError(error)))
            }
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode != 200
                {
                    print("STATUS CODE: \(response.statusCode)")
                }
            }
            
            guard let data = data else { return completion(.failure(.noData))}
            
            do{
                let drink = try JSONDecoder().decode(TopLevelObject.self, from: data)
                let secondLevel = drink.drinks
                completion(.success(secondLevel))
             
            }catch{
                return completion(.failure(.unableToDecode))
            }
            
        }.resume()
    }
    
    static func fetchImage(with url: String, completion: @escaping(Result<UIImage, DrinkError> ) -> Void){
        guard let finalURL = URL(string: url) else { return completion(.failure(.invalidURL)) }
        
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else { return }
            guard let thumbnail = UIImage(data: data) else { return completion(.failure(.unableToDecode))}
            
            //if no image cached it will cache
            completion(.success(thumbnail))
        }.resume()
        
        
    }
    
}

