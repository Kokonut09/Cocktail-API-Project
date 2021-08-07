//
//  DrinkErrors.swift
//  CocktailAPI
//
//  Created by Andrew Saeyang on 8/4/21.
//

import Foundation

enum DrinkError: LocalizedError{
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    
     var errorDescription: String{
        switch self{
        
        case .invalidURL:
            return "The server failed to reach the necessary URL."
        case .thrownError(let error):
            return "Whoops, there was an error with our network call -- \(error)"
        case .noData:
            return "No Data"
        case .unableToDecode:
            return "Unable to decode this data"
        }
    }
}
